provider "alicloud" {
  region = "cn-hangzhou"
}
variable "name" {
  default = "tf-example"
}
data "alicloud_service_mesh_versions" "default" {
  edition = "Default"
}

data "alicloud_zones" "default" {
  available_resource_creation = "VSwitch"
}

resource "alicloud_vpc" "default" {
  vpc_name   = var.name
  cidr_block = "10.4.0.0/16"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.name
  cidr_block   = "10.4.0.0/24"
  vpc_id       = alicloud_vpc.default.id
  zone_id      = data.alicloud_zones.default.zones.3.id
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix          = "tf-test-service_mesh"
  cluster_spec         = "ack.pro.small"
  vswitch_ids          = [alicloud_vswitch.default.id]
  new_nat_gateway      = true
  pod_cidr             = cidrsubnet("10.0.0.0/8", 8, 36)
  service_cidr         = cidrsubnet("172.16.0.0/16", 4, 7)
  slb_internet_enabled = true
}

resource "alicloud_ecs_key_pair" "default" {
  key_pair_name = var.name
}

data "alicloud_instance_types" "default" {
  availability_zone    = alicloud_vswitch.default.zone_id
  kubernetes_node_role = "Worker"
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  node_pool_name       = "desired_size"
  cluster_id           = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids          = [alicloud_vswitch.default.id]
  instance_types       = [data.alicloud_instance_types.default.instance_types.0.id]
  system_disk_category = "cloud_efficiency"
  system_disk_size     = 40
  key_name             = alicloud_ecs_key_pair.default.key_pair_name
  desired_size         = 2
}

resource "alicloud_log_project" "default" {
  project_name = var.name
  description  = "created by terraform"
}

resource "alicloud_service_mesh_service_mesh" "default" {
  service_mesh_name = var.name
  edition           = "Default"
  version           = reverse(data.alicloud_service_mesh_versions.default.versions).0.version
  cluster_spec      = "standard"
  network {
    vpc_id        = alicloud_vpc.default.id
    vswitche_list = [alicloud_vswitch.default.id]
  }
  load_balancer {
    pilot_public_eip      = false
    api_server_public_eip = false
  }
  mesh_config {
    customized_zipkin  = false
    enable_locality_lb = false
    telemetry          = true
    kiali {
      enabled = true
    }

    tracing = true
    pilot {
      http10_enabled = true
      trace_sampling = 100
    }
    opa {
      enabled        = true
      log_level      = "info"
      request_cpu    = "1"
      request_memory = "512Mi"
      limit_cpu      = "2"
      limit_memory   = "1024Mi"
    }
    audit {
      enabled = true
      project = alicloud_log_project.default.project_name
    }
    proxy {
      request_memory = "128Mi"
      limit_memory   = "1024Mi"
      request_cpu    = "100m"
      limit_cpu      = "2000m"
    }
    sidecar_injector {
      enable_namespaces_by_default  = false
      request_memory                = "128Mi"
      limit_memory                  = "1024Mi"
      request_cpu                   = "100m"
      auto_injection_policy_enabled = true
      limit_cpu                     = "2000m"
    }
    outbound_traffic_policy = "ALLOW_ANY"
    access_log {
      enabled         = true
      gateway_enabled = true
      sidecar_enabled = true
    }
  }
  cluster_ids = [alicloud_cs_kubernetes_node_pool.default.cluster_id]
  extra_configuration {
    cr_aggregation_enabled = true
  }
}