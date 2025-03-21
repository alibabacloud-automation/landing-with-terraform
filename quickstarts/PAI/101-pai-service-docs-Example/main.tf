variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_pai_service" "default" {
  develop        = "false"
  service_config = jsonencode({ "metadata" : { "cpu" : 1, "gpu" : 0, "instance" : 1, "memory" : 2000, "name" : "tfexample", "rpc" : { "keepalive" : 70000 } }, "model_path" : "http://eas-data.oss-cn-shanghai.aliyuncs.com/processors/echo_processor_release.tar.gz", "processor_entry" : "libecho.so", "processor_path" : "http://eas-data.oss-cn-shanghai.aliyuncs.com/processors/echo_processor_release.tar.gz", "processor_type" : "cpp" })
}