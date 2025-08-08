output "vpc1_id" {
  value = module.vpc1.vpc_id
}

output "vpc2_id" {
  value = module.vpc2.vpc_id
}

output "vpc3_id" {
  value = module.vpc3.vpc_id
}

output "vpc1_vsw1_id" {
  value = module.vpc1.vsw1_id
}

output "vpc1_vsw2_id" {
  value = module.vpc1.vsw2_id
}

output "vpc2_vsw1_id" {
  value = module.vpc2.vsw1_id
}

output "vpc2_vsw2_id" {
  value = module.vpc2.vsw2_id
}

output "vpc3_vsw1_id" {
  value = module.vpc3.vsw1_id
}

output "vpc3_vsw2_id" {
  value = module.vpc3.vsw2_id
}

output "vpc1_route_table_id" {
  value = module.vpc1.route_table_id
}

output "vpc2_route_table_id" {
  value = module.vpc2.route_table_id
}

output "vpc3_route_table_id" {
  value = module.vpc3.route_table_id
}

output "alb_dns_name" {
  value       = module.alb.alb_dns_name
  description = "ALB域名"
}