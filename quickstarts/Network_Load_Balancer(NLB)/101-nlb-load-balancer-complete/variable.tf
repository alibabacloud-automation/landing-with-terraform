variable "name" {
  default     = "tf-example"
  description = "This variable can be used in all resources in this example."
}

variable "cross_zone_enabled" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = false
}

variable "modification_protection_reason" {
  description = "This variable can be used in all resources in this example."
  type        = string
  default     = "tf-open"
}

variable "modification_protection_status" {
  description = "This variable can be used in all resources in this example."
  type        = string
  default     = "NonProtection"
}

variable "deletion_protection_enabled" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = false
}

variable "deletion_protection_reason" {
  description = "This variable can be used in all resources in this example."
  type        = string
  default     = "tf-open"
}

variable "address_type" {
  description = "This variable can be used in all resources in this example."
  type        = string
  default     = "Internet"
}

