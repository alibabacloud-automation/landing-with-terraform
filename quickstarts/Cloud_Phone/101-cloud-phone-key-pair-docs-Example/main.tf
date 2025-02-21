variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_cloud_phone_policy" "defaultjZ1gi0" {
}

resource "alicloud_cloud_phone_instance_group" "defaultYHMlTO" {
  instance_group_spec = "acp.basic.small"
  policy_group_id     = alicloud_cloud_phone_policy.defaultjZ1gi0.id
  instance_group_name = "AutoCreateGroupName"
  period              = "1"
  number_of_instances = "1"
  charge_type         = "PostPaid"
  image_id            = "imgc-075cllfeuazh03tg9"
  period_unit         = "Hour"
  auto_renew          = false
  amount              = "1"
  auto_pay            = false
  gpu_acceleration    = false
}

resource "alicloud_cloud_phone_instance" "defaulthdBep1" {
  android_instance_group_id = alicloud_cloud_phone_instance_group.defaultYHMlTO.id
  android_instance_name     = "CreateInstanceName"
}


resource "alicloud_cloud_phone_key_pair" "default" {
  key_pair_name   = "example"
  public_key_body = "QAAAAH0o+PMrbz9ZlxaNMYlk1rJkN4JXqwSUVYW5YzMW3fWJ7At1XO40GYDEFL43fLob52pmRxRDuRoGAELmS1AyzqUle2v9yGKFziqS/vK/4vM4MW/ppnTmvh9zPXir0fB/uwXS4iS6xt0gmvprgyRNs7hgXtBK9ASiGuPCv47aRJqh9mYzq2pe2rgb+K0OU5/nQXwWKSxYsv+w3KWPshpwx8iF/JWvjixILJ5gygndd+1HyE8jrLVmvm/OitNaMgkolY1bvmRVVKLmzde7FtXw0s4TVfYUvF385gwlrOulKcL7UuMHV87MV/tcvEA0Gg88JrKgI5LmvQ8BDkrfoSi+bchk1KTAqJ8YMvL2pOogXbBoONeJS176zLYpLHmONtIDQFz/gEqAjGQVW+j4J+1w8oWrn8EjtcDe2kY34s3PDLioK3BN9CIBBQur+SH25R0RnEqD0YPFT7/ym0LomtPOS0t72n5JejBTfWaXiqb/I4f2Ypy1PA6fV5UUFIHODpNtuS4g2HKKqDS/sgYRBA2gpN2MmqeqgsQmSy+EljHdUe4KDVqAZ/qxLqnbp47BGHw2xjuZ60nXAoRecWCg2GDbx13ga4dKUQY+ER8Jruz7ILK4MRB7E4SjSUVmgcdh534c51BYIdI2HkQwQU2dgyJyQme9sDQxxGHpYKFQlFSyXUeOSjXLtQEAAQA= qiaozhou_15694163938@h2sqyfpc71g1t2w"
}