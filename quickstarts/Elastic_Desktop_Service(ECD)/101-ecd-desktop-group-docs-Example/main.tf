variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-shanghai"
}

data "alicloud_ecd_bundles" "default" {
  bundle_type = "SYSTEM"
}

resource "alicloud_ecd_simple_office_site" "default" {
  cidr_block          = "172.16.0.0/12"
  desktop_access_type = "Internet"
  office_site_name    = var.name
}

resource "alicloud_ecd_policy_group" "default" {
  policy_group_name = var.name
  clipboard         = "readwrite"
  local_drive       = "read"
  authorize_access_policy_rules {
    description = var.name
    cidr_ip     = "1.2.3.4/24"
  }
  authorize_security_policy_rules {
    type        = "inflow"
    policy      = "accept"
    description = var.name
    port_range  = "80/80"
    ip_protocol = "TCP"
    priority    = "1"
    cidr_ip     = "0.0.0.0/0"
  }
}

resource "alicloud_ecd_user" "default" {
  end_user_id = "terraform-example-user"
  email       = "terraform-example@example.com"
  password    = "Example12345"
}

resource "alicloud_ecd_desktop_group" "default" {
  desktop_group_name = var.name
  office_site_id     = alicloud_ecd_simple_office_site.default.id
  policy_group_id    = alicloud_ecd_policy_group.default.id
  bundle_id          = data.alicloud_ecd_bundles.default.bundles.0.id
  end_user_ids       = [alicloud_ecd_user.default.id]
  allow_buffer_count = 1
  comments           = var.name
}