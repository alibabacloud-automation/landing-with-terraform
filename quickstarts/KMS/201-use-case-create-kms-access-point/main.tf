variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "instance_name" {
  default = "tf-kms-vpc-172-16"
}
variable "instance_type" {
  default = "ecs.n1.tiny"
}
# 使用数据源来获取可用的可用区信息。资源只能在指定的可用区内创建。
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}
# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.instance_name
  cidr_block = "192.168.0.0/16"
}
# 创建一个Vswitch CIDR 块为 192.168.10.0.24
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.10.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "terraform-example-1"
}
# 创建另一个Vswitch CIDR 块为 192.168.20.0/24
resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.20.0/24"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "terraform-example-2"
}
# 创建KMS软件密钥管理实例，并使用网络参数启动
resource "alicloud_kms_instance" "default" {
  # 软件密钥管理实例
  product_version = "3"
  vpc_id          = alicloud_vpc.vpc.id
  # 规定 KMS 实例所在的可用区，使用前面获取的可用区 ID
  zone_ids = [
    "cn-heyuan-a",
    "cn-heyuan-b",
  ]
  # 交换机id
  vswitch_ids = [
    alicloud_vswitch.vsw.id, alicloud_vswitch.vsw1.id
  ]
  # 计算性能、密钥数量、凭据数量、访问管理数量
  vpc_num    = "1"
  key_num    = "1000"
  secret_num = "100"
  spec       = "1000"
  # 为KMS实例关联其他VPC，可选参数
  # 如果VPC与KMS实例的VPC属于不同阿里云账号，您需要先共享交换机。
  #bind_vpcs {
  #vpc_id = "vpc-j6cy0l32yz9ttxfy6****"
  #vswitch_id = "vsw-j6cv7rd1nz8x13ram****"
  #region_id = "cn-shanghai"
  #vpc_owner_id = "119285303511****"
  #}
  #bind_vpcs {
  #vpc_id = "vpc-j6cy0l32yz9ttd7g3****"
  #vswitch_id = "vsw-3h4yrd1nz8x13ram****"
  #region_id = "cn-shanghai"
  #vpc_owner_id = "119285303511****"
  #}
}
# 保存KMS实例CA证书到本地文件
resource "local_file" "ca_certificate_chain_pem" {
  content  = alicloud_kms_instance.default.ca_certificate_chain_pem
  filename = "ca.pem"
}
# 创建网络控制规则
resource "alicloud_kms_network_rule" "network_rule_example" {
  # 网络规则的名称
  network_rule_name = "sample_network_rule"
  # 描述
  description = "description_test_module"
  # 允许的源私有IP地址范围
  source_private_ip = ["172.16.0.0/12"]
}

# 创建访问控制策略
resource "alicloud_kms_policy" "policy_example" {
  # 策略名称
  policy_name = "sample_policy"
  # 描述
  description = "description_test_module"
  # 定义的权限列表，包括加密服务密钥和加密服务密钥的访问权限
  permissions = ["RbacPermission/Template/CryptoServiceKeyUser", "RbacPermission/Template/CryptoServiceSecretUser"]
  # 资源列表，指向所有密钥和凭据
  resources = ["key/*", "secret/*"]
  # KMS实例的ID
  kms_instance_id = alicloud_kms_instance.default.id
  # 访问控制规则，以JSON格式提供，引用先前定义的网络规则
  access_control_rules = <<EOF
  {
      "NetworkRules":[
          "alicloud_kms_network_rule.network_rule_example.network_rule_name"
      ]
  }
  EOF
}

# 创建应用接入点的资源定义
resource "alicloud_kms_application_access_point" "application_access_point_example" {
  # 应用接入点的名称
  application_access_point_name = "sample_aap"
  # 关联的策略列表，引用之前创建的访问控制策略名称
  policies = [alicloud_kms_policy.policy_example.policy_name]
  # 应用接入点的描述
  description = "aap_description"
}

# 创建应用身份凭证的资源定义
resource "alicloud_kms_client_key" "client_key" {
  # 指定应用接入点的名称
  aap_name = alicloud_kms_application_access_point.application_access_point_example.application_access_point_name
  # 身份凭证的密码,替换为您的密码
  password = "P@ssw0rd***"
  # 身份凭证的有效开始时间
  not_before = "2023-09-01T14:11:22Z"
  not_after  = "2032-09-01T14:11:22Z"
  # 设置保存应用身份凭证的本地文件地址
  private_key_data_file = "./client_key.json"

}