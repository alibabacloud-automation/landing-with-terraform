variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_resource_manager_folder" "defaultuHQ8Cu" {
  folder_name = "folder-aone-example-1"
}

resource "alicloud_resource_manager_folder" "defaultioI16p" {
  folder_name = "folder-aone-example-2"
}

resource "alicloud_resource_manager_folder" "default55Uum4" {
  folder_name = "folder-aone-example-3"
}

resource "alicloud_resource_manager_folder" "defaultiEjEbe" {
  folder_name = "folder-aone-example-4"
}

resource "alicloud_resource_manager_folder" "defaultdNL2TN" {
  folder_name = "folder-aone-example-5"
}


resource "alicloud_resource_manager_multi_account_delivery_channel" "default" {
  resource_change_delivery {
    sls_properties {
      oversized_data_oss_target_arn = "acs:oss:cn-hangzhou:1511928242963727:resourcecenter-aone-example-delivery-oss"
    }
    target_arn = "acs:log:cn-hangzhou:1511928242963727:project/delivery-aone-example/logstore/resourcecenter-delivery-aone-example-sls"
  }
  delivery_channel_description        = "multi_delivery_channel_resource_spec_mq_example"
  multi_account_delivery_channel_name = "multi_delivery_channel_resource_spec_mq_example"
  delivery_channel_filter {
    account_scopes = ["${alicloud_resource_manager_folder.defaultuHQ8Cu.id}", "${alicloud_resource_manager_folder.defaultioI16p.id}", "${alicloud_resource_manager_folder.default55Uum4.id}"]
    resource_types = ["ACS::ACK::Cluster", "ACS::ActionTrail::Trail", "ACS::BPStudio::Application"]
  }
  resource_snapshot_delivery {
    delivery_time     = "16:00Z"
    target_arn        = "acs:log:cn-hangzhou:1511928242963727:project/delivery-aone-example/logstore/resourcecenter-delivery-aone-example-sls"
    target_type       = "SLS"
    custom_expression = "select * from resources limit 10;"
    sls_properties {
      oversized_data_oss_target_arn = "acs:oss:cn-hangzhou:1511928242963727:resourcecenter-aone-example-delivery-oss"
    }
  }
}