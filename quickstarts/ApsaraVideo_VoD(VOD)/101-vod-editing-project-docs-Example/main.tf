variable "name" {
  default = "tfexample"
}
data "alicloud_regions" "default" {
  current = true
}
resource "alicloud_vod_editing_project" "example" {
  editing_project_name = var.name
  title                = var.name
  timeline             = <<EOF
  {
    "VideoTracks":[
      {
        "VideoTrackClips":[
          {
          "MediaId":"0c60e6f02dae71edbfaa472190a90102",
          "In":2811
          }
        ]
      }
    ]
  }
  EOF
  cover_url            = "https://demo.aliyundoc.com/6AB4D0E1E1C74468883516C2349D1FC2-6-2.png"
  division             = data.alicloud_regions.default.regions.0.id
}