variable "name" {
  default = "tf_example"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
  cidr_block = "10.4.0.0/16"
}

data "alicloud_vswitches" "default" {
  cidr_block = "10.4.0.0/24"
  vpc_id     = data.alicloud_vpcs.default.ids.0
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_security_group" "default" {
  vpc_id = data.alicloud_vpcs.default.ids.0
}

resource "alicloud_bastionhost_instance" "default" {
  description        = var.name
  license_code       = "bhah_ent_50_asset"
  plan_code          = "cloudbastion"
  storage            = "5"
  bandwidth          = "5"
  period             = 1
  security_group_ids = [alicloud_security_group.default.id]
  vswitch_id         = data.alicloud_vswitches.default.ids[0]
  ad_auth_server {
    server         = "192.168.1.1"
    standby_server = "192.168.1.3"
    port           = "80"
    domain         = "domain"
    account        = "cn=Manager,dc=test,dc=com"
    password       = "YouPassword123"
    filter         = "objectClass=person"
    name_mapping   = "nameAttr"
    email_mapping  = "emailAttr"
    mobile_mapping = "mobileAttr"
    is_ssl         = false
    base_dn        = "dc=test,dc=com"
  }
  ldap_auth_server {
    server             = "192.168.1.1"
    standby_server     = "192.168.1.3"
    port               = "80"
    login_name_mapping = "uid"
    account            = "cn=Manager,dc=test,dc=com"
    password           = "YouPassword123"
    filter             = "objectClass=person"
    name_mapping       = "nameAttr"
    email_mapping      = "emailAttr"
    mobile_mapping     = "mobileAttr"
    is_ssl             = false
    base_dn            = "dc=test,dc=com"
  }
}