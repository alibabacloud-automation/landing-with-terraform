# 定义区域变量，默认为 "cn-guangzhou"
variable "region" {
  default = "cn-guangzhou"
}

# 配置阿里云提供者，并使用上面定义的区域变量
provider "alicloud" {
  region = var.region
}

# 定义实例类型变量，默认为 "ecs.c6.large"（适用于Ubuntu的实例类型）
variable "instance_type" {
  type    = string
  default = "ecs.c6.large"
}

# 获取可用区信息的数据源，确保选择的实例类型、资源创建类型和磁盘类别都可用
data "alicloud_zones" "default" {
  available_instance_type     = var.instance_type
  available_resource_creation = "VSwitch"
  available_disk_category     = "cloud_essd"
}

# 定义VPC的CIDR块，默认为 "172.16.0.0/16"
variable "vpc_cidr_block" {
  default = "172.16.0.0/16"
}

# 定义VSwitch的CIDR块，默认为 "172.16.0.0/24"
variable "vsw_cidr_block" {
  default = "172.16.0.0/24"
}

# 定义实例默认登录密码
variable "password" {
  default = "Terraform@Example"
}

# 创建一个随机整数，用于在资源名称中添加唯一性，防止资源冲突
resource "random_integer" "default" {
  min = 10000
  max = 99999
}

# 创建VPC资源，并设置名称和CIDR块
resource "alicloud_vpc" "vpc" {
  vpc_name   = "vpc-test-${random_integer.default.result}" # VPC名称包含随机数以保证唯一性
  cidr_block = var.vpc_cidr_block                          # 使用变量定义的CIDR块
}

# 创建安全组资源，并设置名称和所属VPC ID
resource "alicloud_security_group" "group" {
  security_group_name = "sg-test-${random_integer.default.result}"
  vpc_id              = alicloud_vpc.vpc.id
}

# 安全组规则 - 入方向规则放行SSH（端口22）
resource "alicloud_security_group_rule" "allow_ssh" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "22/22"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组规则 - 入方向规则放行HTTP（端口80）
resource "alicloud_security_group_rule" "allow_http" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

# 安全组规则 - 入方向规则放行HTTPS（端口443）
resource "alicloud_security_group_rule" "allow_https" {
  type              = "ingress"
  ip_protocol       = "tcp"
  policy            = "accept"
  port_range        = "443/443"
  priority          = 1
  cidr_ip           = "0.0.0.0/0"
  security_group_id = alicloud_security_group.group.id
}

# 创建vSwitch资源，并设置所属VPC、子网CIDR块、所在可用区及名称
resource "alicloud_vswitch" "vswitch" {
  vpc_id       = alicloud_vpc.vpc.id
  cidr_block   = var.vsw_cidr_block
  zone_id      = data.alicloud_zones.default.zones[0].id
  vswitch_name = "vswitch-test-${random_integer.default.result}"
}

# 创建 ECS 实例
resource "alicloud_instance" "instance" {
  availability_zone          = data.alicloud_zones.default.zones[0].id
  security_groups            = [alicloud_security_group.group.id]
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = "test_hhm_system_disk_${random_integer.default.result}"
  system_disk_description    = "test_hhm_system_disk_description"
  image_id                   = "centos_7_9_x64_20G_alibase_20240628.vhd"
  instance_name              = "test_ecs_${random_integer.default.result}"
  vswitch_id                 = alicloud_vswitch.vswitch.id
  internet_max_bandwidth_out = 10
  password                   = var.password

  user_data = base64encode(<<EOF
#!/bin/bash
# 检查是否为root用户，如果不是则使用sudo执行命令
if [ "$EUID" -ne 0 ]; then
  echo "请以root用户或使用sudo运行此脚本"
  exit
fi

# 安装必要的软件包
echo "正在安装Subversion, Apache httpd 和 mod_dav_svn..."
yum install -y subversion httpd mod_dav_svn

# 检查安装是否成功并获取版本信息
echo "查看Subversion版本:"
svnserve --version
echo "查看httpd版本:"
httpd -v

# 创建SVN版本库，如果已存在则跳过
echo "创建SVN版本库..."
if [ -d /var/svn/svnrepos ]; then
  echo "SVN版本库已存在，跳过创建步骤。"
else
  mkdir -p /var/svn/svnrepos
  svnadmin create /var/svn/svnrepos
  chown -R apache:apache /var/svn/svnrepos
fi

# 设置SVN用户密码文件，并确保不会重复添加用户
echo "设置SVN用户密码..."
htpasswd -b /var/svn/svnrepos/conf/passwd userTest passWDTest

# 配置SVN读写权限
echo "配置SVN读写权限..."
echo "[/]
userTest=rw" | tee /var/svn/svnrepos/conf/authz > /dev/null

# 修改SVN服务配置
echo "修改SVN服务配置..."
sed -i '/^# anon-access = read/s/^# //' /var/svn/svnrepos/conf/svnserve.conf
sed -i 's/anon-access = read/anon-access = none/' /var/svn/svnrepos/conf/svnserve.conf

sed -i '/^# auth-access = write/s/^# //' /var/svn/svnrepos/conf/svnserve.conf

sed -i '/^# password-db = passwd/s/^# //' /var/svn/svnrepos/conf/svnserve.conf

sed -i '/^# authz-db = authz/s/^# //' /var/svn/svnrepos/conf/svnserve.conf

sed -i '/^# realm = My First Repository/s/^# //' /var/svn/svnrepos/conf/svnserve.conf
sed -i 's/realm = My First Repository/realm = \/var\/svn\/svnrepos/' /var/svn/svnrepos/conf/svnserve.conf

# 检查SVN服务是否已经启动，避免端口占用
if pgrep -x "svnserve" > /dev/null; then
  echo "SVN服务已经运行。"
else
  echo "启动SVN服务..."
  svnserve -d -r /var/svn/svnrepos/
fi

# 配置Apache以支持SVN
echo "配置Apache以支持SVN..."
cat <<'INNER_EOF' | tee /etc/httpd/conf.d/subversion.conf > /dev/null
<Location /svn>
    DAV svn
    SVNParentPath /var/svn
    AuthType Basic
    AuthName "Authorization SVN"
    AuthzSVNAccessFile /var/svn/svnrepos/conf/authz
    AuthUserFile /var/svn/svnrepos/conf/passwd
    Require valid-user
</Location>
INNER_EOF

# 启动Apache服务
echo "启动Apache服务..."
systemctl start httpd.service

# 设置服务开机自启
echo "设置服务开机自启..."
systemctl enable httpd.service
systemctl enable svnserve

echo "完成！"
EOF
  )
}