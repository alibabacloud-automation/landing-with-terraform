variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}

variable "api_key_name" {
  default = "<使用API_KEY_AUTH鉴权方式的用户名>"
}


variable "api_key_value" {
  default = "<使用API_KEY_AUTH鉴权方式的Value>"
}

# API端点的URL
variable "endpoint" {
  default = "http://xxxx:8080/putEventsByAPiKey"
}

data "alicloud_account" "default" {
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 自定义事件总线
resource "alicloud_event_bridge_event_bus" "example" {
  event_bus_name = "event_bus_name_${random_integer.default.result}"
}

# 消息队列,用于作为事件源
resource "alicloud_mns_queue" "source" {
  name = "queue-name-source-${random_integer.default.result}"
}

# 自定义事件源
resource "alicloud_event_bridge_event_source" "default" {
  event_bus_name         = alicloud_event_bridge_event_bus.example.event_bus_name
  event_source_name      = "event_source_name_${random_integer.default.result}"
  description            = "description_${random_integer.default.result}"
  linked_external_source = true
  external_source_type   = "MNS"
  external_source_config = {
    QueueName = alicloud_mns_queue.source.name
  }
}

# 连接配置
resource "alicloud_event_bridge_connection" "defaultConnection" {
  connection_name = "connection_name_${random_integer.default.result}"
  description     = "description_alicloud_event_bridge_connection_${random_integer.default.result}"
  network_parameters {
    network_type = "PublicNetwork"
  }
  auth_parameters {
    authorization_type = "API_KEY_AUTH"
    api_key_auth_parameters {
      api_key_name  = var.api_key_name
      api_key_value = var.api_key_value
    }
  }
}

# API端点
resource "alicloud_event_bridge_api_destination" "default" {
  description = "description_alicloud_event_bridge_api_destinationn_${random_integer.default.result}"
  http_api_parameters {
    endpoint = var.endpoint
    method   = "POST"
  }
  api_destination_name = "api_destination_name_${random_integer.default.result}"
  connection_name      = alicloud_event_bridge_connection.defaultConnection.connection_name
}

# 事件规则
resource "alicloud_event_bridge_rule" "default" {
  event_bus_name = alicloud_event_bridge_event_bus.example.event_bus_name
  rule_name      = "rule_name_${random_integer.default.result}"
  description    = "description_${random_integer.default.result}"
  filter_pattern = "{\n \"source\": [\n \"tf-test-api-key\"\n ]\n}"
  targets {
    target_id = "tf_example_${random_integer.default.result}"
    endpoint  = "acs:api-destination:${var.region}:${data.alicloud_account.default.id}:name/${alicloud_event_bridge_api_destination.default.api_destination_name}"
    type      = "acs.api.destination"
    param_list {
      resource_key = "Name"
      form         = "CONSTANT"
      value        = "terraform-api_destination-name-api-key"
    }
    param_list {
      resource_key = "QueryStringParameters"
      form         = "TEMPLATE"
      value        = "{\"queryKey1\":\"id\",\"queryValue1\":\"$.data.name\"}"
      # ${}用于声明EventBridge中的变量，$${}用于在Terraform文件中声明变量。
      template = "{\"$${queryKey1}\":\"$${queryValue1}\"}"
    }
  }
}