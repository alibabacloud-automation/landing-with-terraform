data "alicloud_nas_zones" "example" {
  file_system_type = "standard"
}

resource "alicloud_nas_file_system" "example" {
  protocol_type    = "SMB"
  storage_type     = "Capacity"
  description      = "terraform-example"
  encrypt_type     = "0"
  file_system_type = "standard"
  zone_id          = data.alicloud_nas_zones.example.zones[0].zone_id
}

resource "alicloud_nas_smb_acl_attachment" "example" {
  file_system_id = alicloud_nas_file_system.example.id
  keytab         = "BQIAAABHAAIADUFMSUFEVEVTVC5DT00ABGNpZnMAGXNtYnNlcnZlcjI0LmFsaWFkdGVzdC5jb20AAAABAAAAAAEAAQAIqIx6v7p11oUAAABHAAIADUFMSUFEVEVTVC5DT00ABGNpZnMAGXNtYnNlcnZlcjI0LmFsaWFkdGVzdC5jb20AAAABAAAAAAEAAwAIqIx6v7p11oUAAABPAAIADUFMSUFEVEVTVC5DT00ABGNpZnMAGXNtYnNlcnZlcjI0LmFsaWFkdGVzdC5jb20AAAABAAAAAAEAFwAQnQZWB3RAPHU7PMIJyBWePAAAAF8AAgANQUxJQURURVNULkNPTQAEY2lmcwAZc21ic2VydmVyMjQuYWxpYWR0ZXN0LmNvbQAAAAEAAAAAAQASACAGJ7F0s+bcBjf6jD5HlvlRLmPSOW+qDZe0Qk0lQcf8WwAAAE8AAgANQUxJQURURVNULkNPTQAEY2lmcwAZc21ic2VydmVyMjQuYWxpYWR0ZXN0LmNvbQAAAAEAAAAAAQARABDdFmanrSIatnDDhoOXYadj"
  keytab_md5     = "E3CCF7E2416DF04FA958AA4513EA29E8"
}