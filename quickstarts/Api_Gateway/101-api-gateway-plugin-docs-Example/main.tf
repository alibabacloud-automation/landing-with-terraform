variable "name" {
  default = "terraform_example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_api_gateway_plugin" "default" {
  description = var.name
  plugin_name = var.name
  plugin_data = jsonencode({
    "routes" : [
      {
        "name" : "Vip",
        "condition" : "$CaAppId = 123456",
        "backend" : {
          "type" : "HTTP-VPC",
          "vpcAccessName" : "slbAccessForVip"
        }
      },
      {
        "name" : "MockForOldClient",
        "condition" : "$ClientVersion < '2.0.5'",
        "backend" : {
          "type" : "MOCK",
          "statusCode" : 400,
          "mockBody" : "This version is not supported!!!"
        }
      },
      {
        "name" : "BlueGreenPercent05",
        "condition" : "1 = 1",
        "backend" : {
          "type" : "HTTP",
          "address" : "https://beta-version.api.foo.com"
        },
        "constant-parameters" : [
          {
            "name" : "x-route-blue-green",
            "location" : "header",
            "value" : "route-blue-green"
          }
        ]
      }
    ]
  })
  plugin_type = "routing"
}