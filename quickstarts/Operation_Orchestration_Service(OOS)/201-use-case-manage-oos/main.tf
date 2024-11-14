variable "region" {
  default = "cn-beijing"
}

provider "alicloud" {
  region = var.region
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oos_template" "example" {
  tags = {
    "Created" = "TF",
    "For"     = "template Test"
  }
  content       = <<EOF
        {
        "FormatVersion": "OOS-2019-06-01",
        "Description": "Update Describe instances of given status",
        "Parameters":{
            "Status":{
                "Type": "String",
                "Description": "(Required) The status of the Ecs instance."
            }
        },
        "Tasks": [
            {
                "Properties" :{
                    "Parameters":{
                        "Status": "{{ Status }}"
                    },
                    "API": "DescribeInstances",
                    "Service": "Ecs"
                },
                "Name": "foo",
                "Action": "ACS::ExecuteApi"
            }]
        }
        EOF
  template_name = "terraform-test-${random_integer.default.result}"
}

resource "alicloud_oos_execution" "exampleExecution" {
  template_name = alicloud_oos_template.example.template_name
  description   = "From TF Test"
  parameters    = <<EOF
          {"Status":"Running"}
        EOF
}