variable "login_network_masks" {
  description = "This variable can be used in all resources in this example."
  type        = string
  default     = ""
}

variable "login_session_duration" {
  description = "This variable can be used in all resources in this example."
  type        = number
  default     = 7
}

variable "allow_user_to_change_password" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = true
}

variable "allow_user_to_manage_access_keys" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = true
}

variable "allow_user_to_manage_mfa_devices" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = true
}

variable "enable_save_mfa_ticket" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = true
}

variable "enforce_mfa_for_login" {
  description = "This variable can be used in all resources in this example."
  type        = bool
  default     = false
}

