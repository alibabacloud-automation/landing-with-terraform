variable "name" {
  default = "terraform-example"
}

resource "random_integer" "default" {
  min = 10000
  max = 99999
}

resource "alicloud_log_project" "default" {
  project_name = "${var.name}-${random_integer.default.result}"
}

resource "alicloud_cms_workspace" "default" {
  workspace_name = var.name
  sls_project    = alicloud_log_project.default.project_name
}

resource "alicloud_cms_prometheus_instance" "default" {
  count                    = 2
  prometheus_instance_name = "${var.name}_${count.index}"
  workspace                = alicloud_cms_workspace.default.id
}


resource "alicloud_cms_agg_task_group" "default" {
  source_prometheus_id  = alicloud_cms_prometheus_instance.default.0.id
  target_prometheus_id  = alicloud_cms_prometheus_instance.default.1.id
  agg_task_group_name   = var.name
  agg_task_group_config = <<EOF
groups:
- name: "node.rules"
  interval: "60s"
  rules:
  - record: "node_namespace_pod:kube_pod_info:"
    expr: "max(label_replace(kube_pod_info{job=\"kubernetes-pods-kube-state-metrics\" }, \"pod\", \"$1\", \"pod\", \"(.*)\")) by (node, namespace, pod, cluster)"
EOF
}