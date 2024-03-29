variable "name" {
  default = "tf-example"
}
resource "alicloud_dcdn_er" "default" {
  er_name     = var.name
  description = var.name
  env_conf {
    staging {
      spec_name     = "5ms"
      allowed_hosts = ["example.com"]
    }
    production {
      spec_name     = "5ms"
      allowed_hosts = ["example.com"]
    }
  }
}