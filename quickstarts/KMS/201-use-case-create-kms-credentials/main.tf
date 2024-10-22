variable "region" {
  default = "cn-heyuan"
}
provider "alicloud" {
  region = var.region
}
variable "instance_name" {
  default = "tf-kms-vpc-172-16"
}
# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.instance_name
  cidr_block = "192.168.0.0/16"
}
# 创建一个Vswitch CIDR 块为 192.168.10.0.24
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.10.0/24"
  zone_id      = "cn-heyuan-a"
  vswitch_name = "terraform-example-1"
}
# 创建另一个Vswitch CIDR 块为 192.168.20.0/24
resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "192.168.20.0/24"
  zone_id      = "cn-heyuan-b"
  vswitch_name = "terraform-example-2"
}
# 创建KMS软件密钥管理实例，并使用网络参数启动
resource "alicloud_kms_instance" "default" {
  # 软件密钥管理实例
  product_version = "3"
  vpc_id          = alicloud_vpc.vpc.id
  # 规定 KMS 实例所在的可用区，使用前面获取的可用区 ID
  zone_ids = [
    "cn-heyuan-a",
    "cn-heyuan-b",
  ]
  # 交换机id
  vswitch_ids = [
    alicloud_vswitch.vsw.id, alicloud_vswitch.vsw1.id
  ]
  # 计算性能、密钥数量、凭据数量、访问管理数量
  vpc_num    = "1"
  key_num    = "1000"
  secret_num = "100"
  spec       = "1000"
}
# 保存KMS实例CA证书到本地文件
resource "local_file" "ca_certificate_chain_pem" {
  content  = alicloud_kms_instance.default.ca_certificate_chain_pem
  filename = "ca.pem"
}
#密钥规格为Aliyun_AES_256，密钥用途是加密解密（ENCRYPT/DECRYPT）
resource "alicloud_kms_key" "kms_software_key_encrypt_decrypt" {
  timeouts {
    delete = "30m" # 给删除加上超时时间
  }
  description = "default_key_encrypt_decrypt description"
  # 密钥的使用方式。默认值：ENCRYPT/DECRYPT。有效值：ENCRYPT/DECRYPT: 加密或解密数据。
  key_usage = "ENCRYPT/DECRYPT"
  # 密钥的规格。默认值：Aliyun_AES_256。
  key_spec = "Aliyun_AES_256"
  # KMS 实例的 ID。
  dkms_instance_id       = alicloud_kms_instance.default.id
  pending_window_in_days = 7
}
#密钥别名为alias/kms_software_key_encrypt_decrypt，在整个阿里云账号下唯一。
resource "alicloud_kms_alias" "kms_software_key_encrypt_decrypt_alias" {
  # 别名
  alias_name = "alias/kms_software_key_encrypt_decrypt"
  # 密钥id
  key_id = alicloud_kms_key.kms_software_key_encrypt_decrypt.id
}
# 创建通用凭据，凭据名称为kms_secret_general1，凭据值为secret_data_kms_secret_general1
resource "alicloud_kms_secret" "kms_secret_general" {
  # 名称
  secret_name = "kms_secret_general1"
  # 描述
  description = "secret_data_kms_secret_general"
  # 类型
  secret_type = "Generic"
  # 指定是否立即删除。默认值：false。有效值：true，false。
  force_delete_without_recovery = true
  # KMS 实例的 ID。
  dkms_instance_id = alicloud_kms_instance.default.id
  # KMS 密钥的 ID
  encryption_key_id = alicloud_kms_key.kms_software_key_encrypt_decrypt.id
  # 版本号
  version_id = "v1"
  # 值的类型。默认值：text。有效值：text，binary。
  secret_data_type = "text"
  # 数据
  secret_data = "secret_data_kms_secret_general1"
}