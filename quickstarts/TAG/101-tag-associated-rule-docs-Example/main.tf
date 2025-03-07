variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_tag_associated_rule" "default" {
  status                  = "Enable"
  associated_setting_name = "rule:AttachEni-DetachEni-TagInstance:Ecs-Instance:Ecs-Eni"
  tag_keys                = ["user"]
}