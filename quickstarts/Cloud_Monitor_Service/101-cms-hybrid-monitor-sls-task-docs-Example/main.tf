variable "name" {
  default = "tf_example"
}
data "alicloud_account" "default" {}
data "alicloud_regions" "default" {
  current = true
}
resource "random_uuid" "default" {
}
resource "alicloud_log_project" "default" {
  name = substr("tf-example-${replace(random_uuid.default.result, "-", "")}", 0, 16)
}

resource "alicloud_log_store" "default" {
  project               = alicloud_log_project.default.name
  name                  = var.name
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_cms_sls_group" "default" {
  sls_group_config {
    sls_user_id  = data.alicloud_account.default.id
    sls_logstore = alicloud_log_store.default.name
    sls_project  = alicloud_log_project.default.name
    sls_region   = data.alicloud_regions.default.regions.0.id
  }
  sls_group_description = var.name
  sls_group_name        = var.name
}

resource "alicloud_cms_namespace" "default" {
  namespace     = substr("tf-example-${replace(random_uuid.default.result, "-", "")}", 0, 16)
  specification = "cms.s1.large"
}

resource "alicloud_cms_hybrid_monitor_sls_task" "default" {
  task_name           = var.name
  namespace           = alicloud_cms_namespace.default.id
  description         = var.name
  collect_interval    = 60
  collect_target_type = alicloud_cms_sls_group.default.id

  sls_process_config {
    filter {
      relation = "and"
      filters {
        operator     = "="
        value        = "200"
        sls_key_name = "code"
      }
    }
    statistics {
      function      = "count"
      alias         = "level_count"
      sls_key_name  = "name"
      parameter_one = "200"
      parameter_two = "299"
    }
    group_by {
      alias        = "code"
      sls_key_name = "ApiResult"
    }
    express {
      express = "success_count"
      alias   = "SuccRate"
    }
  }

  attach_labels {
    name  = "app_service"
    value = "example_Value"
  }
}