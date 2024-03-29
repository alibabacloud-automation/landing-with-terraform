provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tfexample"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

data "alicloud_service_mesh_versions" "default" {
  edition = "Default"
}
data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}
data "alicloud_vpcs" "default" {
  name_regex = "^default-NODELETING$"
}

data "alicloud_vswitches" "default" {
  vpc_id  = data.alicloud_vpcs.default.ids.0
  zone_id = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_ram_user" "default" {
  name = var.name
}

resource "alicloud_service_mesh_service_mesh" "default1" {
  service_mesh_name = "${var.name}-${random_integer.default.result}"
  edition           = "Default"
  cluster_spec      = "standard"
  version           = data.alicloud_service_mesh_versions.default.versions.0.version
  network {
    vpc_id        = data.alicloud_vpcs.default.ids.0
    vswitche_list = [data.alicloud_vswitches.default.ids.0]
  }
  load_balancer {
    pilot_public_eip      = false
    api_server_public_eip = false
  }
}

resource "alicloud_service_mesh_user_permission" "default" {
  sub_account_user_id = alicloud_ram_user.default.id
  permissions {
    role_name       = "istio-ops"
    service_mesh_id = alicloud_service_mesh_service_mesh.default1.id
    role_type       = "custom"
    is_custom       = true
  }
}