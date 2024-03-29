resource "alicloud_ram_security_preference" "default" {
  allow_user_to_manage_mfa_devices = var.allow_user_to_manage_mfa_devices
  enable_save_mfa_ticket           = var.enable_save_mfa_ticket
  enforce_mfa_for_login            = var.enforce_mfa_for_login
  login_network_masks              = var.login_network_masks
  login_session_duration           = var.login_session_duration
  allow_user_to_change_password    = var.allow_user_to_change_password
  allow_user_to_manage_access_keys = var.allow_user_to_manage_access_keys
}