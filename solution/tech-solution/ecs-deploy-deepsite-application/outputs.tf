output "ecs_login_address" {
  description = <<EOT
  {
    "Label": {
      "zh-cn": "ECS登录地址",
      "en": "ECS Login Address"
    }
  }
  EOT
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions.0.id}&instanceId=${alicloud_instance.ecs_instance.id}"
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

// 数据源获取当前地域
data "alicloud_regions" "current" {
  current = true
}

