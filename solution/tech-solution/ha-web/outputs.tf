output "ecs1_url" {
  description = "ECS 1 URL"
  value       = format("https://ecs.console.aliyun.com/#/server/region/%s?instanceIds=%s", data.alicloud_regions.current.regions[0].id, alicloud_instance.ecs_instance1.id)
}

output "ecs2_url" {
  description = "ECS 2 URL"
  value       = format("https://ecs.console.aliyun.com/#/server/region/%s?instanceIds=%s", data.alicloud_regions.current.regions[0].id, alicloud_instance.ecs_instance2.id)
}

output "master_nas_url" {
  description = "Master NAS"
  value       = format("https://nasnext.console.aliyun.com/%s/filesystem/%s", data.alicloud_regions.current.regions[0].id, alicloud_nas_file_system.master_fs.id)
}

output "backup_nas_url" {
  description = "Backup NAS"
  value       = format("https://nasnext.console.aliyun.com/%s/filesystem/%s", data.alicloud_regions.current.regions[0].id, alicloud_nas_file_system.backup_fs.id)
}

output "mount_dir1" {
  description = "NAS在ECS上的挂载目录1"
  value       = "/nas_master"
}

output "mount_dir2" {
  description = "NAS在ECS上的挂载目录2"
  value       = "/nas_backup"
}

output "slb_address" {
  description = "对外暴露的公网IP地址"
  value       = format("http://%s", alicloud_slb_load_balancer.slb.address)
}