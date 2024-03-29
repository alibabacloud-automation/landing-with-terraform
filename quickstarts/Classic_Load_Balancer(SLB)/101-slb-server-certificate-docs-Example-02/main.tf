# create a server certificate
resource "alicloud_slb_server_certificate" "foo" {
  name               = "slbservercertificate"
  server_certificate = file("${path.module}/server_certificate.pem")
  private_key        = file("${path.module}/private_key.pem")
}