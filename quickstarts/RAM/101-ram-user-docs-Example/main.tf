# Create a new RAM user.
resource "alicloud_ram_user" "user" {
  name         = "terraform-example"
  display_name = "user_display_name"
  mobile       = "86-18688888888"
  email        = "hello.uuu@aaa.com"
  comments     = "yoyoyo"
}