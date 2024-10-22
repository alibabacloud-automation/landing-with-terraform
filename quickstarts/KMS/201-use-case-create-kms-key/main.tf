variable "region" {
  default = "cn-shanghai"
}

provider "alicloud" {
  region = var.region
}
variable "instance_name" {
  default = "tf-kms-vpc-172-16"
}

variable "instance_type" {
  default = "ecs.n1.tiny"
}
# 使用数据源来获取可用的可用区信息。资源只能在指定的可用区内创建。
data "alicloud_zones" "default" {
  available_disk_category     = "cloud_efficiency"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}
# 创建VPC
resource "alicloud_vpc" "vpc" {
  vpc_name   = var.instance_name
  cidr_block = "172.16.0.0/12"
}
# 创建一个Vswitch CIDR 块为 172.16.0.0/12
resource "alicloud_vswitch" "vsw" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.0.0/21"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "terraform-example-1"
}
# 创建另一个Vswitch CIDR 块为 172.16.128.0/17
resource "alicloud_vswitch" "vsw1" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = "172.16.128.0/17"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = "terraform-example-2"
}
# 创建KMS软件密钥管理实例，并使用网络参数启动
resource "alicloud_kms_instance" "default" {
  timeouts {
    delete = "20m" # 给删除加上超时时间
  }
  # 软件密钥管理实例
  product_version = "3"
  vpc_id          = alicloud_vpc.vpc.id
  # 规定 KMS 实例所在的可用区，使用前面获取的可用区 ID
  zone_ids = [
    data.alicloud_zones.default.zones.0.id,
    data.alicloud_zones.default.zones.1.id
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
  # 为KMS实例关联其他VPC，可选参数
  # 如果VPC与KMS实例的VPC属于不同阿里云账号，您需要先共享交换机。
  #bind_vpcs {
  #vpc_id = "vpc-j6cy0l32yz9ttxfy6****"
  #vswitch_id = "vsw-j6cv7rd1nz8x13ram****"
  #region_id = "cn-shanghai"
  #vpc_owner_id = "119285303511****"
  #}
  #bind_vpcs {
  #vpc_id = "vpc-j6cy0l32yz9ttd7g3****"
  #vswitch_id = "vsw-3h4yrd1nz8x13ram****"
  #region_id = "cn-shanghai"
  #vpc_owner_id = "119285303511****"
  #}
}

# 保存KMS实例CA证书到本地文件
resource "local_file" "ca_certificate_chain_pem" {
  content  = alicloud_kms_instance.default.ca_certificate_chain_pem
  filename = "ca.pem"
}

#密钥规格为Aliyun_AES_256，密钥用途是加密解密（ENCRYPT/DECRYPT）
resource "alicloud_kms_key" "kms_software_key_encrypt_decrypt" {
  timeouts {
    delete = "20m" # 给删除加上超时时间
  }
  description = "default_key_encrypt_decrypt description"
  # 密钥的使用方式。默认值：ENCRYPT/DECRYPT。有效值：ENCRYPT/DECRYPT: 加密或解密数据。
  key_usage = "ENCRYPT/DECRYPT"
  # 密钥的规格。默认值：Aliyun_AES_256。
  key_spec = "Aliyun_AES_256"
  # KMS 实例的 ID。
  # 若添加此参数表明是在KMS实例中创建密钥，否则是创建默认密钥（主密钥）
  dkms_instance_id = alicloud_kms_instance.default.id
  # 在 CMK 删除之前的天数。
  pending_window_in_days = 7
  # 要分配给资源的标签映射，可选
  #tags = {
  #"Environment" = "Production"
  #"Name" = "KMS-01"
  #"SupportTeam" = "PlatformEngineering"
  #"Contact" = "aliyun@test.com"
  #}
}
#密钥别名为alias/kms_software_key_encrypt_decrypt，在整个阿里云账号下唯一。
resource "alicloud_kms_alias" "kms_software_key_encrypt_decrypt_alias" {
  # 别名
  alias_name = "alias/kms_software_key_encrypt_decrypt"
  # 密钥id
  key_id = alicloud_kms_key.kms_software_key_encrypt_decrypt.id
}