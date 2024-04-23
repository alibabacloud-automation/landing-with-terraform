# You need to activate the link before you can return to the alarm contact information, otherwise diff will appear in terraform. So please confirm the activation link as soon as possible. Besides, you can ignore the diff of the alarm contact information by `lifestyle`. 
resource "alicloud_cms_alarm_contact" "example" {
  alarm_contact_name = "tf-example"
  describe           = "For example"
  channels_mail      = "terraform@test.com"
  lifecycle {
    ignore_changes = [channels_mail]
  }
}