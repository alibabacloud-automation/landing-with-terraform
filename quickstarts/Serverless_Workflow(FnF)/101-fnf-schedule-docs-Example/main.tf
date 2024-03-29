provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_fnf_flow" "example" {
  definition  = <<EOF
  version: v1beta1
  type: flow
  steps:
    - type: pass
      name: helloworld
  EOF  
  description = "tf-exampleFnFFlow983041"
  name        = "tf-exampleSchedule"
  type        = "FDL"
}

resource "alicloud_fnf_schedule" "example" {
  cron_expression = "30 9 * * * *"
  description     = "tf-exampleFnFSchedule983041"
  enable          = "true"
  flow_name       = alicloud_fnf_flow.example.name
  payload         = "{\"tf-example\": \"example success\"}"
  schedule_name   = "tf-exampleFnFSchedule983041"
}