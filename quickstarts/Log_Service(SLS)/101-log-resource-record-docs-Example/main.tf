provider "alicloud" {
  region = "cn-heyuan"
}

resource "alicloud_log_resource" "example" {
  type        = "userdefine"
  name        = "user.tf.resource"
  description = "user tf resource desc"
  ext_info    = "{}"
  schema      = <<EOF
    {
      "schema": [
        {
          "column": "col1",
          "desc": "col1   desc",
          "ext_info": {
          },
          "required": true,
          "type": "string"
        },
        {
          "column": "col2",
          "desc": "col2   desc",
          "ext_info": "optional",
          "required": true,
          "type": "string"
        }
      ]
    }
  EOF
}

resource "alicloud_log_resource_record" "example" {
  resource_name = alicloud_log_resource.example.id
  record_id     = "tf_user_example"
  tag           = "tf example"
  value         = <<EOF
{
  "user_name": "tf example",
  "sms_enabled": true,
  "phone": "18888888889",
  "voice_enabled": false,
  "email": [
    "test@qq.com"
  ],
  "enabled": true,
  "user_id": "tf_user",
  "country_code": "86"
}
EOF
}