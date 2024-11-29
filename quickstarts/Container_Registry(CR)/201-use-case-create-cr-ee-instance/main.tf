variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "name" {
  default = "tf-example"
}
resource "alicloud_cr_ee_instance" "default" {
  payment_type   = "Subscription"  # （可选，强制新建）容器镜像企业版实例的订阅类型。默认值：Subscription。有效值：Subscription。
  period         = 1               # （可选，整数）容器镜像企业版实例的服务时间。默认值：12。有效值：1、2、3、6、12、24、36、48、60。单位：月。
  renew_period   = 0               # （可选，强制新建，整数）容器镜像企业版实例的续费周期。单位：月。
  renewal_status = "ManualRenewal" # （可选，强制新建）容器镜像企业版实例的续费状态。有效值：AutoRenewal、ManualRenewal。
  instance_type  = "Advanced"      # （必填，强制新建）容器镜像企业版实例的类型。有效值：Basic、Standard、Advanced。注意：国际账户不支持 Standard。
  instance_name  = var.name        # （必填，强制新建）容器镜像企业版实例的名称。
}