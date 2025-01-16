provider "alicloud" {
  region = "cn-guangzhou"
}

# 添加随机整数生成器以保证策略名称唯一性
resource "random_integer" "default" {
  min = 1000
  max = 9999
}

resource "alicloud_ram_user" "example" {
  name         = "HHM-example-user"
  display_name = "HHM-Example User"
  mobile       = "86-18600001111"      # 可选
  email        = "HHMuser@example.com" # 可选
}

resource "alicloud_ram_policy" "policy" {
  policy_name = "tf-example-${random_integer.default.result}"
  description = "Policy to allow ECS actions only from specified IP addresses."

  policy_document = jsonencode({
    Version = "1",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "ecs:*", // 或者更具体的ECS API操作
        Resource = "*",     // 根据需要，这里可以替换成具体的资源ID
        Condition = {
          IpAddress = {
            "acs:SourceIp" = [
              "192.0.2.0/24",  //用户自行修改为允许的IP地址范围
              "203.0.113.2/32" //用户自行修改为允许的IP地址范围
            ]
          }
        }
      }
    ]
  })
}

# 将策略附加给RAM用户
resource "alicloud_ram_user_policy_attachment" "policy_attachment" {
  policy_type = "Custom"
  policy_name = alicloud_ram_policy.policy.policy_name
  user_name   = alicloud_ram_user.example.name
}