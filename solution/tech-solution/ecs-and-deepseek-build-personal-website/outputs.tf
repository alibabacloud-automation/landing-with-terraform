output "ecs_login_address" {
  description = <<EOT
  {
    "Description": {
      "en": "Ecs login address.",
      "zh-cn": "ECS登录地址。"
    }
  }
  EOT
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

output "demo_url" {
  description = <<EOT
  {
    "Label": {
      "zh-cn": "体验地址",
      "en": "Experience Addresses"
    },
    "Description": {
      "en": "Experience address.",
      "zh-cn": "体验地址。"
    }
  }
  EOT
  value       = "http://${alicloud_instance.ecs_instance.public_ip}:8080"
}

# 获取当前区域信息的数据源
data "alicloud_regions" "current" {
  current = true
}
