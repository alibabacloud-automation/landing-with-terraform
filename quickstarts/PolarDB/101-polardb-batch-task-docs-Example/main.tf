resource "alicloud_polardb_batch_task" "default" {
  task_name    = "terraform-batch-task-example"
  task_type    = "polarclaw_install_skills"
  region_id    = "cn-hangzhou"
  instance_ids = ["pa-xxx", "pa-abc"]

  task_params {
    skill_name = "ontology"
    version    = "1.0.4"
  }
}