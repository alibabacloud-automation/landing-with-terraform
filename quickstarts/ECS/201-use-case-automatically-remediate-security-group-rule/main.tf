variable "region_id" {
  type    = string
  default = "cn-guangzhou"
}

provider "alicloud" {
  region = var.region_id
}

resource "local_file" "python_script" {
  content  = <<EOF
#!/usr/bin/env python
# -*- encoding: utf-8 -*-
import sys
sys.path.append('/opt/python')
import json
import logging
import jmespath  # 使用jmespath代替jsonpath
from aliyunsdkcore.client import AcsClient
from aliyunsdkcore.auth.credentials import AccessKeyCredential
from aliyunsdkcore.auth.credentials import StsTokenCredential
from aliyunsdkcore.request import CommonRequest


logger = logging.getLogger()


def handler(event, context):
    logger.info(f"This is event: {str(event, encoding='utf-8')}")
    get_resources_non_compliant(event, context)


def get_resources_non_compliant(event, context):
    # 获取不合规的资源信息
    resources = parse_json(event)
    # 遍历不合规资源，进行修正操作
    for resource in resources:
        remediation(resource, context)


def parse_json(content):
    """
    Parse string to json object
    :param content: json string content
    :return: Json object
    """
    try:
        return json.loads(content)
    except Exception as e:
        logger.error('Parse content:{} to json error:{}.'.format(content, e))
        return None


def remediation(resource, context):
    logger.info(f"需要修复的资源信息: {resource}")
    region_id = resource['regionId']
    account_id = resource['accountId']
    resource_id = resource['resourceId']
    resource_type = resource['resourceType']
    if resource_type == 'ACS::ECS::SecurityGroup' :
        # 获取不合规安全组的配置信息，重新校验，确保不合规安全组的评估准确性
        resource_result = get_discovered_resource(context, resource_id, resource_type, region_id)
        resource_json = json.loads(resource_result)
        configuration = json.loads(resource_json["DiscoveredResourceDetail"]["Configuration"])
        # 判断是否是托管的安全组
        is_managed_security_group = configuration.get('ServiceManaged')
        # 使用jmespath获取入方向为接受且授权0.0.0.0/0的安全组规则id
        delete_security_group_rule_ids = jmespath.search(
            "Permissions.Permission[?SourceCidrIp=='0.0.0.0/0'].SecurityGroupRuleId",
            configuration
        )
        # 非托管的安全组，且授权了0.0.0.0/0的入方向安全组规则，则删除
        if is_managed_security_group is False and delete_security_group_rule_ids:
            logger.info(f"注意：删除安全组规则 {region_id}:{resource_id}:{delete_security_group_rule_ids}")
            revoke_security_group(context, region_id, resource_id, delete_security_group_rule_ids)

def revoke_security_group(context, region_id, resource_id, security_group_rule_ids):
    creds = context.credentials
    client = AcsClient(creds.access_key_id, creds.access_key_secret, region_id=region_id)
    request = CommonRequest()
    request.set_accept_format('json')
    request.set_domain(f'ecs.{region_id}.aliyuncs.com')
    request.set_method('POST')
    request.set_protocol_type('https') # https | http
    request.set_version('2014-05-26')
    request.set_action_name('RevokeSecurityGroup')
    request.add_query_param('RegionId', region_id)
    for index, value in enumerate(security_group_rule_ids):
        request.add_query_param(f'SecurityGroupRuleId.{index + 1}', value)
    request.add_query_param('SecurityGroupId', resource_id)
    request.add_query_param('SecurityToken', creds.security_token)

    response = client.do_action_with_exception(request)
    logger.info(f"删除结果: {str(response, encoding='utf-8')}")


# 获取资源详情
def get_discovered_resource(context, resource_id, resource_type, region_id):
    """
    调用API获取资源配置详情
    :param context：函数计算上下文
    :param resource_id：资源ID
    :param resource_type：资源类型
    :param region_id：资源所属地域ID
    :return: 资源详情
    """
    # 需具备权限AliyunConfigFullAccess的函数计算FC的服务角色。
    creds = context.credentials
    client = AcsClient(creds.access_key_id, creds.access_key_secret, region_id='cn-shanghai')

    request = CommonRequest()
    request.set_domain('config.cn-shanghai.aliyuncs.com')
    request.set_version('2020-09-07')
    request.set_action_name('GetDiscoveredResource')
    request.add_query_param('ResourceId', resource_id)
    request.add_query_param('ResourceType', resource_type)
    request.add_query_param('Region', region_id)
    request.add_query_param('SecurityToken', creds.security_token)
    request.set_method('GET')

    try:
        response = client.do_action_with_exception(request)
        resource_result = str(response, encoding='utf-8')
        return resource_result
    except Exception as e:
        logger.error('GetDiscoveredResource error: %s' % e)
  EOF
  filename = "${path.module}/python/index.py"
}

resource "local_file" "requirements_txt" {
  content  = <<EOF
  aliyun-python-sdk-core==2.15.2
  jmespath>=0.10.0
  EOF
  filename = "${path.module}/python/requests/requirements.txt"
}
locals {
  code_dir       = "${path.module}/python/"
  archive_output = "${path.module}/code.zip"
  base64_output  = "${path.module}/code_base64.txt"
}

data "archive_file" "code_package" {
  type        = "zip"
  source_dir  = local.code_dir
  output_path = local.archive_output

  depends_on = [
    local_file.python_script,
    local_file.requirements_txt,
  ]
}

resource "null_resource" "upload_code" {
  provisioner "local-exec" {
    command = <<EOT
      base64 -w 0 ${local.archive_output} > ${local.base64_output}
    EOT

    interpreter = ["sh", "-c"]
  }

  depends_on = [data.archive_file.code_package]
}

data "local_file" "base64_encoded_code" {
  filename   = local.base64_output
  depends_on = [null_resource.upload_code]
}
resource "alicloud_fcv3_function" "fc_function" {
  runtime       = "python3.10"
  handler       = "index.handler"
  function_name = "HHM-FC-TEST"
  role          = alicloud_ram_role.role.arn
  code {
    zip_file = data.local_file.base64_encoded_code.content
  }

  depends_on = [data.local_file.base64_encoded_code]
}

resource "alicloud_config_rule" "default" {
  rule_name    = "SPM安全组不允许对全部网段开启风险端口"
  description  = "spm禁止安全组对所有网段开放风险端口22, 3389"
  source_owner = "ALIYUN"
  # （必需，ForceNew）指定是您还是阿里云拥有并管理该规则。有效值： CUSTOM_FC: 该规则是自定义规则，您拥有该规则 ● ALIYUN: 该规则是托管规则，阿里云拥有该规则。
  source_identifier = "sg-risky-ports-check"
  #配置审计ARN（必需，ForceNew）规则的标识符。对于托管规则，值为托管规则的名称。对于自定义规则，值为自定义规则的ARN。
  resource_types_scope = ["ACS::ECS::SecurityGroup"]
  #规则监控被排除的资源ID，多个ID用逗号分隔，仅适用于基于托管规则创建的规则，定制规则此字段为空。
  config_rule_trigger_types   = "ConfigurationItemChangeNotification,ScheduledNotification" #规则在配置更改时被触发
  maximum_execution_frequency = "One_Hour"
  #有效值包括：One_Hour、Three_Hours、Six_Hours、Twelve_Hours、TwentyFour_Hours。
  risk_level = 1 #    ● 1: 严重 ● 2: 警告● 3: 信息

  input_parameters = {
    "ports" : "22,3389"
  }
}

resource "alicloud_config_remediation" "default" {
  config_rule_id          = alicloud_config_rule.default.id
  remediation_template_id = alicloud_fcv3_function.fc_function.function_arn
  remediation_source_type = "CUSTOM"
  invoke_type             = "AUTO_EXECUTION"
  params                  = "{}"
  remediation_type        = "FC"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_ram_role" "role" {
  name        = "tf-example-role-${random_integer.default.result}"
  document    = <<EOF
{
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "fc.aliyuncs.com"
        ]
      }
    }
  ],
  "Version": "1"
}
EOF
  description = "Ecs ram role."
  force       = true
}
resource "alicloud_ram_policy" "policy" {
  policy_name     = "tf-example-ram-policy-${random_integer.default.result}"
  policy_document = <<EOF
  {
    "Statement": [
      {
        "Action":  [
          "config:GetDiscoveredResource",
          "ecs:RevokeSecurityGroup"
        ],
        "Effect":  "Allow",
        "Resource": ["*"]
      }
    ],
      "Version": "1"
  }
  EOF
  description     = "this is a policy test"
  force           = true
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.policy_name
  policy_type = "Custom"
  role_name   = alicloud_ram_role.role.name
}
