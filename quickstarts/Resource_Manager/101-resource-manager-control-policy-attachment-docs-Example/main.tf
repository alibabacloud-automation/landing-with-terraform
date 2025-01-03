variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_resource_manager_control_policy" "default" {
  control_policy_name = var.name
  description         = var.name
  effect_scope        = "RAM"
  policy_document     = <<EOF
  {
    "Version": "1",
    "Statement": [
      {
        "Effect": "Deny",
        "Action": [
          "ram:UpdateRole",
          "ram:DeleteRole",
          "ram:AttachPolicyToRole",
          "ram:DetachPolicyFromRole"
        ],
        "Resource": "acs:ram:*:*:role/ResourceDirectoryAccountAccessRole"
      }
    ]
  }
  EOF
}

resource "alicloud_resource_manager_folder" "default" {
  folder_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_resource_manager_control_policy_attachment" "default" {
  policy_id = alicloud_resource_manager_control_policy.default.id
  target_id = alicloud_resource_manager_folder.default.id
}