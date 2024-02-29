variable "name" {
  default = "terraform-example"
}


resource "alicloud_oos_patch_baseline" "default" {
  patch_baseline_name = var.name
  operation_system    = "Windows"
  approval_rules      = "{\"PatchRules\":[{\"EnableNonSecurity\":true,\"PatchFilterGroup\":[{\"Values\":[\"*\"],\"Key\":\"Product\"},{\"Values\":[\"Security\",\"Bugfix\"],\"Key\":\"Classification\"},{\"Values\":[\"Critical\",\"Important\"],\"Key\":\"Severity\"}],\"ApproveAfterDays\":7,\"ComplianceLevel\":\"Unspecified\"}]}"
}