# Create a new RAM Group.
resource "alicloud_ram_group" "group" {
  name     = "groupName"
  comments = "this is a group comments."
}