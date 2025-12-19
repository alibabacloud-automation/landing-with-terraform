output "ecs_login_address" {
  description = <<EOT
  {
    "Label": {
      "zh-cn": "ECS登录地址",
      "en": "ECS Login Address"
    },
    "zh-cn": "ECS登录地址，可通过此地址远程连接到云服务器。",
    "en": "ECS login address for remote connection."
  }
  EOT
  value       = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${data.alicloud_regions.current.regions.0.id}&instanceId=${alicloud_instance.ecs_instance.id}"
}

output "deepsite_url" {
  description = <<EOT
  {
    "Label": {
      "zh-cn": "DeepSite 体验地址",
      "en": "DeepSite Experience URL"
    },
    "zh-cn": "DeepSite 应用访问地址，部署完成后可通过此地址体验 AI 网页生成功能。",
    "en": "DeepSite application URL for AI-powered web page generation."
  }
  EOT
  value       = "http://${alicloud_instance.ecs_instance.public_ip}:8080"
}

output "ecs_public_ip" {
  description = <<EOT
  {
    "Label": {
      "zh-cn": "ECS公网IP",
      "en": "ECS Public IP"
    },
    "zh-cn": "云服务器的公网IP地址。",
    "en": "Public IP address of the ECS instance."
  }
  EOT
  value       = alicloud_instance.ecs_instance.public_ip
}

// 数据源获取当前地域
data "alicloud_regions" "current" {
  current = true
}

