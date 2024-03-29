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
  record_id     = "user_tf_resource_1"
  tag           = "resource tag"
  value         = <<EOF
    {
      "col1": "this is col1 value",
      "col2": "col2   value"
    }
  EOF
}