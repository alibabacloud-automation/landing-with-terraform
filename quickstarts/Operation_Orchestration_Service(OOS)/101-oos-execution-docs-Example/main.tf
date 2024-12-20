resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oos_template" "default" {
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
  template_name = "tf-example-name-${random_integer.default.result}"
  version_name  = "example"
  tags = {
    "Created" = "TF",
    "For"     = "acceptance Test"
  }
}

resource "alicloud_oos_execution" "example" {
  template_name = alicloud_oos_template.default.template_name
  description   = "From TF Test"
  parameters    = <<EOF
				{"Status":"Running"}
		  	EOF
}