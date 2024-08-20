variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

variable "function_name" {
  default = "TerraformTriggerResourceAPI"
}

variable "trigger_name" {
  default = "TerraformTrigger_CDN"
}

resource "alicloud_fcv3_function" "function" {
  memory_size = "512"
  cpu         = 0.5
  handler     = "index.Handler"
  code {
    zip_file = "UEsDBBQACAAIAAAAAAAAAAAAAAAAAAAAAAAIAAAAaW5kZXgucHmEkEFKxEAQRfd9ig9ZTCJOooIwDMwNXLqXnnQlaalUhU5lRj2KZ/FOXkESGR114bJ/P/7jV4b1xRq1hijtFpM1682cuNgPmgysbRulPT0fRxXnMtwrSPyeCdYRokSLnuMLJTTkbUqEvDMbxm1VdcRD6Tk+T1LW2ldB66knsYdA5iNX17ebm6tN2VnPhcswMPmREPuBacb+CiapLarAj9gT6/H97dVlCNScY3mtYvRkxdZlwDKDEnanPWVLdrdkeXEGlFEazVdfPVHaVeHc3N15CUwppwOJXeK7HshAB8NuOU7J6sP4SRXuH/EvbUfMiqMmDqv5M5FNSfAj/wgAAP//UEsHCPl//NYAAQAArwEAAFBLAQIUABQACAAIAAAAAAD5f/zWAAEAAK8BAAAIAAAAAAAAAAAAAAAAAAAAAABpbmRleC5weVBLBQYAAAAAAQABADYAAAA2AQAAAAA="
  }
  function_name = var.name
  runtime       = "python3.9"
  disk_size     = "512"
  log_config {
    log_begin_rule = "None"
  }
}

data "alicloud_account" "current" {
}

resource "alicloud_fcv3_trigger" "default" {
  trigger_type    = "cdn_events"
  trigger_name    = var.name
  description     = "create"
  qualifier       = "LATEST"
  trigger_config  = jsonencode({ "eventName" : "CachedObjectsPushed", "eventVersion" : "1.0.0", "notes" : "example", "filter" : { "domain" : ["example.com"] } })
  source_arn      = "acs:cdn:*:${data.alicloud_account.current.id}"
  invocation_role = "acs:ram::${data.alicloud_account.current.id}:role/aliyuncdneventnotificationrole"
  function_name   = alicloud_fcv3_function.function.function_name
}