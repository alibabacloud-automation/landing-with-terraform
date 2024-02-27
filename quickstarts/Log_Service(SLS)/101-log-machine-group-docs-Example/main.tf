resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
}

resource "alicloud_log_machine_group" "example" {
  project       = alicloud_log_project.example.name
  name          = "terraform-example"
  identify_type = "ip"
  topic         = "terraform"
  identify_list = ["10.0.0.1", "10.0.0.2"]
}