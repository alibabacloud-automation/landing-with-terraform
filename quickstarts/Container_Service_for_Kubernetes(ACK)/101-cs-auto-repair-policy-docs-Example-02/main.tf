resource "alicloud_cs_auto_repair_policy" "gpu" {
  cluster_id        = alicloud_cs_managed_kubernetes.default.id
  name              = "gpu-repair"
  resource_sub_type = "ess"

  rules {
    incidents {
      name = "NvidiaXID48Error"
    }
    repair_procedure {
      name = "Repair"
    }
  }
}