variable "name" {
  default = "terraform_example"
}
resource "alicloud_datahub_project" "example" {
  name    = var.name
  comment = "created by terraform"
}

resource "alicloud_datahub_topic" "example" {
  name         = var.name
  project_name = alicloud_datahub_project.example.name
  record_type  = "BLOB"
  shard_count  = 3
  life_cycle   = 7
  comment      = "created by terraform"
}

resource "alicloud_datahub_subscription" "example" {
  project_name = alicloud_datahub_project.example.name
  topic_name   = alicloud_datahub_topic.example.name
  comment      = "created by terraform"
}