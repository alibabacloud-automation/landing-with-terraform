provider "alicloud" {
  region = "cn-hangzhou"
}

variable "name" {
  default = "terraform-example"
}

resource "alicloud_esa_page" "default" {
  description  = "example resource html page"
  content_type = "text/html"
  content      = "PCFET0NUWVBFIGh0bWw+CjxodG1sIGxhbmc9InpoLUNOIj4KICA8aGVhZD4KICAgIDx0aXRsZT40MDMgRm9yYmlkZGVuPC90aXRsZT4KICA8L2hlYWQ+CiAgPGJvZHk+CiAgICA8aDE+NDAzIEZvcmJpZGRlbjwvaDE+CiAgPC9ib2R5Pgo8L2h0bWw+"
  page_name    = "resource_example_html_page"
}