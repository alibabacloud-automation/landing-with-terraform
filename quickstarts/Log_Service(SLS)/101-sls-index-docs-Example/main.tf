variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-nanjing"
}

variable "logstore_name" {
  default = "logstore-example"
}

variable "project_name" {
  default = "project-for-index-terraform-example"
}

resource "alicloud_log_project" "default" {
  description  = "terraform example"
  project_name = var.project_name
}

resource "alicloud_log_store" "default" {
  hot_ttl          = "7"
  retention_period = "30"
  shard_count      = "2"
  project_name     = alicloud_log_project.default.project_name
  logstore_name    = var.logstore_name
}

resource "alicloud_sls_index" "default" {
  line {
    chn            = "true"
    case_sensitive = "true"
    token = [
      "a"
    ]
    exclude_keys = [
      "t"
    ]
  }
  keys = jsonencode(
    {
      "example" : {
        "caseSensitive" : false,
        "token" : [
          "\n",
          "\t",
          ",",
          " ",
          ";",
          "\"",
          "'",
          "(",
          ")",
          "{",
          "}",
          "[",
          "]",
          "<",
          ">",
          "?",
          "/",
          "#",
          ":"
        ],
        "type" : "text",
        "doc_value" : false,
        "alias" : "",
        "chn" : false
      }
    }
  )

  logstore_name = alicloud_log_store.default.logstore_name
  project_name  = var.project_name
}