variable "region" {
  default = "cn-hangzhou"
}
provider "alicloud" {
  region = var.region
}
# 变量定义名称。
variable "name" {
  default = "test-mns"
}
# 变量定义策略名称。
variable "policy_name" {
  type        = string
  description = "The name of the policy."
  default     = "test-policy"
}
# 定义变量角色名称
variable "role_name" {
  type        = string
  description = "The role for eb to start execution of flow."
  default     = "eb-to-fnf-role"
}
# 变量定义云工作流名称
variable "flow_name" {
  type        = string
  description = "The name of the flow."
  default     = "test-flow"
}
# 定义流的描述
variable "flow_description" {
  default = "For flow_description"
}
# 定义变量总线名称。
variable "event_bus_name" {
  type        = string
  description = "The name of the event bus."
  default     = "test-eventbus1"
}
# 定义变量总线描述。
variable "event_bus_description" {
  default = "For event_bus_description"
}
# 定义变量事件源的代码名称
variable "event_source_name" {
  type        = string
  description = "The name of the event source."
  default     = "test-eventsource1"
}
# 定义事件规则名称
variable "event_rule_name" {
  type        = string
  description = "The name of the event rule."
  default     = "test-eventrule1"
}
# 自定义事件目标的 ID
variable "target_id" {
  type        = string
  description = "The ID of the target."
  default     = "test-target1"
}
# 获取当前阿里云uid
data "alicloud_account" "current" {
}
# 创建随机数
resource "random_integer" "default" {
  min = 10000
  max = 99999
}
# 创建一个RAM策略来定义权限。
resource "alicloud_ram_policy" "policy_exmaple" {
  # RAM 策略的名称。
  policy_name = "${var.policy_name}-${random_integer.default.result}"
  # （可选）此参数用于资源销毁。默认值为 false。
  force = true
  # RAM 策略的文档
  policy_document = <<EOF
  {
    "Statement": [
      {
        "Action": [
          "fnf:*",        
          "mns:*",         
          "eventbridge:*",       
          "ram:*"  
        ],
        "Effect": "Allow",
        "Resource": [
          "*"
        ]
      }
    ],
      "Version": "1"
  }
  EOF
}
# 创建一个RAM角色。
resource "alicloud_ram_role" "role_example" {
  # 角色名称
  name = var.role_name
  # （可选）此参数用于资源销毁。默认值为 false。
  force = true
  # 角色策略文档
  document = <<EOF
  {
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Effect": "Allow",
        "Principal": {
          "Service": [
            "fnf.aliyuncs.com"
          ]
        }
      }
    ],
    "Version": "1"
  }
  EOF
}
# 将创建的RAM策略附加到RAM角色上，以授予该角色相应的权限。
resource "alicloud_ram_role_policy_attachment" "attach_example" {
  # RAM策略名称
  policy_name = alicloud_ram_policy.policy_exmaple.policy_name
  # RAM策略类型
  policy_type = alicloud_ram_policy.policy_exmaple.type
  # RAM角色名称
  role_name = alicloud_ram_role.role_example.name
}
# 创建一个云工作流资源
resource "alicloud_fnf_flow" "flow_example" {
  depends_on = [alicloud_ram_role_policy_attachment.attach_example]
  # (必填) 流的定义。必须符合流定义语言（FDL）的语法。
  definition = <<EOF
  version: v1beta1
  type: flow
  steps:
    - type: pass
      name: helloworld
  EOF
  # 无服务器工作流在执行流时使用的指定 RAM 角色的 ARN。
  role_arn = alicloud_ram_role.role_example.arn
  # 流的描述
  description = var.flow_description
  # 流的名称
  name = var.flow_name
  # 流的类型有效值为 FDL 或 DEFAULT。
  type = "FDL"
}
# 创建一个事件总线来接收和路由事件。
resource "alicloud_event_bridge_event_bus" "eventbus_example" {
  # 事件总线名称
  event_bus_name = var.event_bus_name
  # （可选）事件总线的描述
  description = var.event_bus_description
}
# 创建 MNS 队列资源
resource "alicloud_mns_queue" "example" {
  # 名字
  name = "${var.name}-${random_integer.default.result}"
  # 此属性定义发送到队列的每条消息在出队后延迟的时间（以秒为单位）
  delay_seconds = 0
  # 此属性指示发送到队列的任何消息体的最大长度（以字节为单位）
  maximum_message_size = 65536
  # 消息在队列中被删除的时间段，无论它们是否已被激活。此属性定义每条消息在队列中的有效期（以秒为单位）。
  message_retention_period = 345600
  # 队列的可见性超时属性。
  visibility_timeout = 30
  # 长轮询的时间，以秒为单位
  polling_wait_seconds = 0
}
# 创建一个事件源，用于生成定时事件。
resource "alicloud_event_bridge_event_source" "eventsource_example" {
  # 事件总线的名称。
  event_bus_name = alicloud_event_bridge_event_bus.eventbus_example.event_bus_name
  # 事件源的代码名称
  event_source_name = var.event_source_name
  # （可选，计算得出）是否连接到外部数据源。默认值：false。
  linked_external_source = true
  # （可选）外部数据源的类型。有效值：RabbitMQ、RocketMQ 和 MNS。注意：仅当 linked_external_source 为 true 时，此字段有效。
  external_source_type = "MNS"
  # （可选，映射）外部源的配置。
  external_source_config = {
    QueueName = alicloud_mns_queue.example.name
  }
}

# 定义一个本地变量，用于存储云工作流的ARN。
locals {
  flow_arn = format("acs:fnf:::flow/%s", var.flow_name)
}

# 创建一个事件规则，用于匹配事件源生成的事件，并将这些事件路由到指定的云工作流。
resource "alicloud_event_bridge_rule" "eventrule_example" {
  # 事件总线的名称。
  event_bus_name = alicloud_event_bridge_event_bus.eventbus_example.event_bus_name
  # 事件规则名称
  rule_name = var.event_rule_name
  # 匹配感兴趣事件的模式。事件模式，JSON 格式。值的描述如下：stringEqual 模式，stringExpression 模式。
  filter_pattern = format("{\"source\":[\"%s\"]}", var.event_source_name)
  # 规则的目标
  targets {
    #  自定义事件目标的 ID。
    target_id = var.target_id
    # 事件目标的端点。
    endpoint = local.flow_arn
    # 事件目标的类型。
    type = "acs.fnf"
    param_list {
      resource_key = "Input"
      form         = "ORIGINAL"
    }
    param_list {
      form         = "CONSTANT"
      resource_key = "FlowName"
      value        = var.flow_name
    }
    param_list {
      form         = "CONSTANT"
      resource_key = "RoleName"
      value        = var.role_name
    }
  }
}