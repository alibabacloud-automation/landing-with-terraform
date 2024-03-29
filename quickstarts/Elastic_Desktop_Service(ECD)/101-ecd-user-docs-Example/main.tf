provider "alicloud" {
  region = "cn-shanghai"
}

resource "alicloud_ecd_user" "default" {
  end_user_id = "terraform_example123"
  email       = "tf.example@abc.com"
  phone       = "18888888888"
  password    = "Example_123"
}