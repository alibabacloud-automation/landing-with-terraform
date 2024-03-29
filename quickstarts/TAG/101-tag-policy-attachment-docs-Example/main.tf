variable "name" {
  default = "tf-example"
}
provider "alicloud" {
  region = "cn-shanghai"
}
data "alicloud_account" "default" {}
resource "alicloud_tag_policy" "example" {
  policy_name    = var.name
  policy_desc    = var.name
  user_type      = "USER"
  policy_content = <<EOF
		{"tags":{"CostCenter":{"tag_value":{"@@assign":["Beijing","Shanghai"]},"tag_key":{"@@assign":"CostCenter"}}}}
    EOF
}

resource "alicloud_tag_policy_attachment" "example" {
  policy_id   = alicloud_tag_policy.example.id
  target_id   = data.alicloud_account.default.id
  target_type = "USER"
}