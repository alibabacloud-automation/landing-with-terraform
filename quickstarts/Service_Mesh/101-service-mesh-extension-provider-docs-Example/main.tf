provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "tf_example"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

data "alicloud_vpcs" "default" {
  name_regex = "default-NODELETING"
}

resource "alicloud_vpc" "default" {
  count = length(data.alicloud_vpcs.default.ids) > 0 ? 0 : 1
}

data "alicloud_vswitches" "default" {
  vpc_id = length(data.alicloud_vpcs.default.ids) > 0 ? data.alicloud_vpcs.default.ids[0] : alicloud_vpc.default[0].id
}

resource "alicloud_vswitch" "default" {
  count      = length(data.alicloud_vswitches.default.ids) > 0 ? 0 : 1
  vpc_id     = length(data.alicloud_vpcs.default.ids) > 0 ? data.alicloud_vpcs.default.ids[0] : alicloud_vpc.default[0].id
  cidr_block = cidrsubnet(data.alicloud_vpcs.default.vpcs[0].cidr_block, 8, 2)
  zone_id    = data.alicloud_zones.default.zones.0.id
}

resource "alicloud_service_mesh_service_mesh" "default" {
  service_mesh_name = "mesh-c50f3fef117ad45b6b26047cdafef65ad"
  version           = "v1.21.6.103-g5ddeaef7-aliyun"
  edition           = "Default"
  network {
    vpc_id        = length(data.alicloud_vpcs.default.ids) > 0 ? data.alicloud_vpcs.default.ids[0] : alicloud_vpc.default[0].id
    vswitche_list = [length(data.alicloud_vswitches.default.ids) > 0 ? data.alicloud_vswitches.default.ids[0] : alicloud_vswitch.default[0].id]
  }
}

resource "alicloud_service_mesh_extension_provider" "default" {
  service_mesh_id         = alicloud_service_mesh_service_mesh.default.id
  extension_provider_name = "httpextauth-tf-example"
  type                    = "httpextauth"
  config                  = "{\"headersToDownstreamOnDeny\":[\"content-type\",\"set-cookie\"],\"headersToUpstreamOnAllow\":[\"authorization\",\"cookie\",\"path\",\"x-auth-request-access-token\",\"x-forwarded-access-token\"],\"includeRequestHeadersInCheck\":[\"cookie\",\"x-forward-access-token\"],\"oidc\":{\"clientID\":\"qweqweqwewqeqwe\",\"clientSecret\":\"asdasdasdasdsadas\",\"cookieExpire\":\"1000\",\"cookieRefresh\":\"500\",\"cookieSecret\":\"scxzcxzcxzcxzcxz\",\"issuerURI\":\"qweqwewqeqweqweqwe\",\"redirectDomain\":\"www.alicloud-provider.cn\",\"redirectProtocol\":\"http\",\"scopes\":[\"profile\"]},\"port\":4180,\"service\":\"oauth2proxy-httpextauth-tf-example.istio-system.svc.cluster.local\",\"timeout\":\"10s\"}"
}