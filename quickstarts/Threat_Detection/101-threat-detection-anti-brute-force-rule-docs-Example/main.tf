resource "alicloud_threat_detection_anti_brute_force_rule" "default" {
  anti_brute_force_rule_name = "apispec_example"
  forbidden_time             = 360
  uuid_list                  = ["032b618f-b220-4a0d-bd37-fbdc6ef58b6a"]
  fail_count                 = 80
  span                       = 10
}