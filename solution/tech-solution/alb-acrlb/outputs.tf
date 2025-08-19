output "vpc1_id" {
  value = alicloud_vpc.vpc1.id
}

output "vpc2_id" {
  value = alicloud_vpc.vpc2.id
}

output "vpc3_id" {
  value = alicloud_vpc.vpc3.id
}

output "vsw11_id" {
  value = alicloud_vswitch.vsw11.id
}

output "vsw12_id" {
  value = alicloud_vswitch.vsw12.id
}

output "vsw21_id" {
  value = alicloud_vswitch.vsw21.id
}

output "vsw22_id" {
  value = alicloud_vswitch.vsw22.id
}

output "vsw31_id" {
  value = alicloud_vswitch.vsw31.id
}

output "vsw32_id" {
  value = alicloud_vswitch.vsw32.id
}

output "ecs1_ip" {
  value = alicloud_instance.ecs1.private_ip
}

output "ecs2_ip" {
  value = alicloud_instance.ecs2.private_ip
}

output "ecs3_ip" {
  value = alicloud_instance.ecs3.private_ip
}

output "alb_dns_name" {
  value       = alicloud_alb_load_balancer.alb.dns_name
  description = "ALB域名"
}