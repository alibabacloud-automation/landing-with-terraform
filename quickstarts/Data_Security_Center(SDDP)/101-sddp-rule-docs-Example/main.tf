variable "name" {
  default = "tf-example-name"
}

resource "alicloud_sddp_rule" "default" {
  rule_name     = var.name
  category      = "2"
  content       = <<EOF
  [
    {
      "rule": [
        {
          "operator": "contains",
          "target": "content",
          "value": "tf-testACCContent"
        }
      ],
      "ruleRelation": "AND"
    }
  ]
  EOF
  risk_level_id = "4"
  product_code  = "OSS"
}