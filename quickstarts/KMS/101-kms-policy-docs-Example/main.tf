variable "name" {
  default = "terraform-example"
}

resource "alicloud_kms_network_rule" "networkRule1" {
  description       = "dummy"
  source_private_ip = ["10.10.10.10"]
  network_rule_name = format("%s1", var.name)
}

resource "alicloud_kms_network_rule" "networkRule2" {
  description       = "dummy"
  source_private_ip = ["10.10.10.10"]
  network_rule_name = format("%s2", var.name)
}

resource "alicloud_kms_network_rule" "networkRule3" {
  description       = "dummy"
  source_private_ip = ["10.10.10.10"]
  network_rule_name = format("%s3", var.name)
}


resource "alicloud_kms_policy" "default" {
  description          = "terraformpolicy"
  permissions          = ["RbacPermission/Template/CryptoServiceKeyUser", "RbacPermission/Template/CryptoServiceSecretUser"]
  resources            = ["secret/*", "key/*"]
  policy_name          = var.name
  kms_instance_id      = "shared"
  access_control_rules = <<EOF
  {
      "NetworkRules":[
          "alicloud_kms_network_rule.networkRule1.network_rule_name"
      ]
  }
  EOF
}