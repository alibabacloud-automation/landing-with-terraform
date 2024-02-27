resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_log_project" "example" {
  name        = "terraform-example-${random_integer.default.result}"
  description = "terraform-example"
}

resource "alicloud_log_store" "example" {
  project               = alicloud_log_project.example.name
  name                  = "example-store"
  shard_count           = 3
  auto_split            = true
  max_split_shard_count = 60
  append_meta           = true
}

resource "alicloud_log_dashboard" "example" {
  project_name   = alicloud_log_project.example.name
  dashboard_name = "terraform-example"
  display_name   = "terraform-example"
  attribute      = <<EOF
  {
    "type":"grid"
  }
EOF
  char_list      = <<EOF
  [
    {
      "action": {},
      "title":"new_title",
      "type":"map",
      "search":{
        "logstore":"example-store",
        "topic":"new_topic",
        "query":"* | SELECT COUNT(name) as ct_name, COUNT(product) as ct_product, name,product GROUP BY name,product",
        "start":"-86400s",
        "end":"now"
      },
      "display":{
        "xAxis":[
          "ct_name"
        ],
        "yAxis":[
          "ct_product"
        ],
        "xPos":0,
        "yPos":0,
        "width":10,
        "height":12,
        "displayName":"terraform-example"
      }
    }
  ]
EOF
}