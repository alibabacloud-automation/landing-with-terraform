variable "name" {
  default = "tf-example-config-name"
}

data "alicloud_regions" "default" {
  current = true
}

resource "alicloud_config_rule" "rule1" {
  description                 = var.name
  source_owner                = "ALIYUN"
  source_identifier           = "ram-user-ak-create-date-expired-check"
  risk_level                  = 1
  maximum_execution_frequency = "TwentyFour_Hours"
  region_ids_scope            = data.alicloud_regions.default.regions.0.id
  config_rule_trigger_types   = "ScheduledNotification"
  resource_types_scope        = ["ACS::RAM::User"]
  rule_name                   = "ciscompliancecheck_ram-user-ak-create-date-expired-check"
  input_parameters = {
    days = "90"
  }
}

resource "alicloud_config_rule" "rule2" {
  description               = var.name
  source_owner              = "ALIYUN"
  source_identifier         = "adb-cluster-maintain-time-check"
  risk_level                = 2
  region_ids_scope          = data.alicloud_regions.default.regions.0.id
  config_rule_trigger_types = "ScheduledNotification"
  resource_types_scope      = ["ACS::ADB::DBCluster"]
  rule_name                 = "governance-evaluation-adb-cluster-maintain-time-check"
  input_parameters = {
    maintainTimes = "02:00-04:00,06:00-08:00,12:00-13:00"
  }
}

resource "alicloud_config_compliance_pack" "default" {
  compliance_pack_name = var.name
  description          = "CloudGovernanceCenter evaluation"
  risk_level           = "2"
  config_rule_ids {
    config_rule_id = alicloud_config_rule.rule1.id
  }
  config_rule_ids {
    config_rule_id = alicloud_config_rule.rule2.id
  }
}