variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_resource_manager_delivery_channel" "default" {
  resource_change_delivery {
    sls_properties {
      oversized_data_oss_target_arn = "acs:oss:cn-hangzhou:1511928242963727:resourcecenter-aone-example-delivery-oss"
    }
    target_arn = "acs:log:cn-hangzhou:1511928242963727:project/delivery-aone-example/logstore/resourcecenter-delivery-aone-example-sls"
  }
  delivery_channel_name        = "delivery_channel_resource_spec_example"
  delivery_channel_description = "delivery_channel_resource_spec_example"
  delivery_channel_filter {
    resource_types = ["ACS::ECS::Instance", "ACS::ECS::Disk", "ACS::VPC::VPC"]
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