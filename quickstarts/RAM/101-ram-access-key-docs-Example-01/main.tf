resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# Create a new RAM access key for user.
resource "alicloud_ram_user" "user" {
  name         = "terraform-example-${random_integer.default.result}"
  display_name = "user_display_name"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
  force        = true
}

resource "alicloud_ram_access_key" "ak" {
  user_name   = alicloud_ram_user.user.name
  secret_file = "/xxx/xxx/xxx.txt"
}