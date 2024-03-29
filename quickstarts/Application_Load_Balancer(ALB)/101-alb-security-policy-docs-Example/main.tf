resource "alicloud_alb_security_policy" "default" {
  security_policy_name = "tf_example"
  tls_versions         = ["TLSv1.0"]
  ciphers              = ["ECDHE-ECDSA-AES128-SHA", "AES256-SHA"]
}