variable "region1" {
  type        = string
  description = ""
  default     = "cn-shanghai"
}

variable "region2" {
  type        = string
  description = ""
  default     = "cn-beijing"
}

variable "region1_zone_id1" {
  type        = string
  description = ""
  default     = "cn-shanghai-e"
}

variable "region1_zone_id2" {
  type        = string
  description = ""
  default     = "cn-shanghai-f"
}

variable "region2_zone_id1" {
  type        = string
  description = ""
  default     = "cn-beijing-k"
}

variable "region2_zone_id2" {
  type        = string
  description = ""
  default     = "cn-beijing-l"
}

variable "region1_instance_type1" {
  description = ""
  default     = "ecs.g8i.large"
}

variable "region1_instance_type2" {
  description = ""
  default     = "ecs.g8i.large"
}

variable "region2_instance_type1" {
  description = ""
  default     = "ecs.g7.large"
}

variable "region2_instance_type2" {
  description = ""
  default     = "ecs.g7.large"
}

# variable "ecs_password" {
#   type        = string
#   sensitive   = true
#   description = ""
# }

variable "polardb_account_name" {
  type        = string
  description = ""
  default     = "terraform"
}

# variable "polardb_password" {
#   type        = string
#   sensitive   = true
#   description = ""
# }

variable "ecs_instance_password" {
  type        = string
  sensitive   = true
  description = "Please enter the ECS login password, with a length of 8-30 characters, and it must include three of the following: uppercase letters, lowercase letters, numbers, and special characters from ()`~!@#$%^&*_-+=|{}[]:;'<>,.?/."
}

variable "db_password" {
  description = "Please enter the PolarDB database password. The password must be 8-32 characters long and include uppercase letters, lowercase letters, numbers, and special characters (e.g., !@#$%^&*()_+-=). If repeating the configuration in this tutorial, please ensure that the MySQL database password is identical to the one set during the first execution of the template. Otherwise, the configuration result will be invalid."
  type        = string
  sensitive   = true
}

variable "polardb_class" {
  type        = string
  description = ""
  default     = "polar.mysql.x4.large"
  # default = "polar.mysql.g2m.large.c"
}