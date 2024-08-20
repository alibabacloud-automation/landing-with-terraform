variable "name" {
  default = "terraform"
}

provider "alicloud" {
  region = "cn-shanghai"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_oss_bucket" "defaultPyhXOV" {
  storage_class = "Standard"
  bucket        = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_aligreen_callback" "defaultJnW8Na" {
  callback_url         = "https://www.aliyun.com/"
  crypt_type           = "0"
  callback_name        = "${var.name}${random_integer.default.result}"
  callback_types       = ["machineScan"]
  callback_suggestions = ["block"]
}


resource "alicloud_aligreen_oss_stock_task" "default" {
  image_opened                       = true
  auto_freeze_type                   = "acl"
  audio_max_size                     = "200"
  image_scan_limit                   = "1"
  video_frame_interval               = "1"
  video_scan_limit                   = "1000"
  audio_scan_limit                   = "1000"
  video_max_frames                   = "200"
  video_max_size                     = "500"
  start_date                         = "2024-08-01 00:00:00 +0800"
  end_date                           = "2024-12-31 09:06:42 +0800"
  buckets                            = jsonencode([{ "Bucket" : "${alicloud_oss_bucket.defaultPyhXOV.bucket}", "Selected" : true, "Prefixes" : [] }])
  image_scenes                       = ["porn"]
  audio_antispam_freeze_config       = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  image_live_freeze_config           = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  video_terrorism_freeze_config      = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  image_terrorism_freeze_config      = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  callback_id                        = alicloud_aligreen_callback.defaultJnW8Na.id
  image_ad_freeze_config             = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  biz_type                           = "recommend_massmedia_template_01"
  audio_scenes                       = jsonencode(["antispam"])
  image_porn_freeze_config           = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  video_live_freeze_config           = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  video_porn_freeze_config           = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  video_voice_antispam_freeze_config = jsonencode({ "Type" : "suggestion", "Value" : "block" })
  video_scenes                       = jsonencode(["ad", "terrorism", "live", "porn", "antispam"])
  video_ad_freeze_config             = jsonencode({ "Type" : "suggestion", "Value" : "block" })
}