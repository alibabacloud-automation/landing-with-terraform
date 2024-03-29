resource "random_integer" "default" {
  max = 99999
  min = 10000
}

resource "alicloud_oss_bucket" "bucket_src" {
  bucket = "example-src-${random_integer.default.result}"
}

resource "alicloud_oss_bucket" "bucket_dest" {
  bucket = "example-dest-${random_integer.default.result}"
}

resource "alicloud_ram_role" "role" {
  name        = "example-role-${random_integer.default.result}"
  document    = <<EOF
		{
		  "Statement": [
			{
			  "Action": "sts:AssumeRole",
			  "Effect": "Allow",
			  "Principal": {
				"Service": [
				  "oss.aliyuncs.com"
				]
			  }
			}
		  ],
		  "Version": "1"
		}
	  	EOF
  description = "this is a test"
  force       = true
}

resource "alicloud_ram_policy" "policy" {
  policy_name     = "example-policy-${random_integer.default.result}"
  policy_document = <<EOF
		{
		  "Statement": [
			{
			  "Action": [
				"*"
			  ],
			  "Effect": "Allow",
			  "Resource": [
				"*"
			  ]
			}
		  ],
			"Version": "1"
		}
		EOF
  description     = "this is a policy test"
  force           = true
}

resource "alicloud_ram_role_policy_attachment" "attach" {
  policy_name = alicloud_ram_policy.policy.name
  policy_type = alicloud_ram_policy.policy.type
  role_name   = alicloud_ram_role.role.name
}

resource "alicloud_kms_key" "key" {
  description            = "Hello KMS"
  pending_window_in_days = "7"
  status                 = "Enabled"
}

resource "alicloud_oss_bucket_replication" "cross-region-replication" {
  bucket                        = alicloud_oss_bucket.bucket_src.id
  action                        = "PUT,DELETE"
  historical_object_replication = "enabled"
  prefix_set {
    prefixes = ["prefix1/", "prefix2/"]
  }
  destination {
    bucket   = alicloud_oss_bucket.bucket_dest.id
    location = alicloud_oss_bucket.bucket_dest.location
  }
  sync_role = alicloud_ram_role.role.name
  encryption_configuration {
    replica_kms_key_id = alicloud_kms_key.key.id
  }
  source_selection_criteria {
    sse_kms_encrypted_objects {
      status = "Enabled"
    }
  }
}