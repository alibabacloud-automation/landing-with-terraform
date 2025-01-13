//实例名称
variable "name" {
  default = "terraform-example"
}

// 实例规格
variable "instance_type" {
  default = "ecs.e-c1m2.large"
}

//实例登录密码
variable "instance_password" {
  default = "Test@12345"
}

// 地域
variable "region" {
  default = "cn-beijing"
}

provider "alicloud" {
  region = var.region
}

variable "create_instance" {
  default = true
}

//实例ID
variable "instance_id" {
  default = ""
}

// 镜像ID
variable "image_id" {
  default = "ubuntu_24_04_x64_20G_alibase_20241115.vhd"
}

// 创建VPC
resource "alicloud_vpc" "vpc" {
  count      = local.create_instance ? 1 : 0
  cidr_block = "192.168.0.0/16"
}

// 创建交换机
resource "alicloud_vswitch" "vswitch" {
  count        = local.create_instance ? 1 : 0
  vpc_id       = alicloud_vpc.vpc[0].id
  cidr_block   = "192.168.0.0/16"
  zone_id      = data.alicloud_zones.default.zones.0.id
  vswitch_name = var.name
}

//创建安全组
resource "alicloud_security_group" "group" {
  security_group_name = var.name
  description         = "foo"
  vpc_id              = local.vpc_id
}

//创建安全组规则（此处仅作示例参考，请您按照自身安全策略设置）
resource "alicloud_security_group_rule" "allow_all_tcp" {
  type              = "ingress"                        # 规则类型：入站
  ip_protocol       = "tcp"                            # 协议类型：TCP
  policy            = "accept"                         # 策略：接受
  port_range        = "22/22"                          # 端口范围：仅22端口
  priority          = 1                                # 优先级：1
  security_group_id = alicloud_security_group.group.id # 关联到之前创建的安全组
  cidr_ip           = "0.0.0.0/0"                      # 允许所有IP地址访问
}

resource "alicloud_security_group_rule" "allow_tcp_80" {
  type              = "ingress"
  ip_protocol       = "tcp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "80/80"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "allow_icmp_all" {
  type              = "ingress"
  ip_protocol       = "icmp"
  nic_type          = "intranet"
  policy            = "accept"
  port_range        = "-1/-1"
  priority          = 1
  security_group_id = alicloud_security_group.group.id
  cidr_ip           = "0.0.0.0/0"
}

data "alicloud_zones" "default" {
  available_disk_category     = "cloud_essd"
  available_resource_creation = "VSwitch"
  available_instance_type     = var.instance_type
}

//创建实例
resource "alicloud_instance" "instance" {
  count             = var.create_instance ? 1 : 0
  availability_zone = data.alicloud_zones.default.zones.0.id
  security_groups   = alicloud_security_group.group.*.id
  # series III
  instance_type              = var.instance_type
  system_disk_category       = "cloud_essd"
  system_disk_name           = var.name
  system_disk_description    = "test_foo_system_disk_description"
  image_id                   = var.image_id
  instance_name              = var.name
  vswitch_id                 = alicloud_vswitch.vswitch.0.id
  internet_max_bandwidth_out = 10
  password                   = var.instance_password
}

resource "alicloud_ecs_command" "install_content" {
  name            = "InstallJDK"
  type            = "RunShellScript"
  command_content = base64encode(local.install_content)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_command" "configure_hadoop" {
  name            = "ConfigureHadoop"
  type            = "RunShellScript"
  command_content = base64encode(local.configure_hadoop_content)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_command" "start_hadoop1" {
  name            = "StartHadoop"
  type            = "RunShellScript"
  command_content = base64encode(local.start_hadoop_content1)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_command" "start_hadoop2" {
  name            = "StartHadoop"
  type            = "RunShellScript"
  command_content = base64encode(local.start_hadoop_content2)
  timeout         = 3600
  working_dir     = "/root"
}

resource "alicloud_ecs_invocation" "invocation_install" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.install_content.id
  timeouts {
    create = "5m"
  }

}


resource "alicloud_ecs_invocation" "invocation_configure_hadoop" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.configure_hadoop.id
  timeouts {
    create = "5m"
  }
  depends_on = [alicloud_ecs_invocation.invocation_install]

}

resource "alicloud_ecs_invocation" "invocation_start_hadoop1" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.start_hadoop1.id
  timeouts {
    create = "10m"
  }
  depends_on = [alicloud_ecs_invocation.invocation_configure_hadoop]

}

resource "alicloud_ecs_invocation" "invocation_start_hadoop2" {
  instance_id = [local.instanceId]
  command_id  = alicloud_ecs_command.start_hadoop2.id
  timeouts {
    create = "10m"
  }
  depends_on = [alicloud_ecs_invocation.invocation_start_hadoop1]

}

data "alicloud_instances" "default" {
  count = local.create_instance ? 0 : 1
  ids   = [var.instance_id]
}

locals {
  create_instance    = var.instance_id == ""
  instanceId         = local.create_instance ? alicloud_instance.instance[0].id : var.instance_id
  instance_public_ip = local.create_instance ? element(alicloud_instance.instance.*.public_ip, 0) : lookup(data.alicloud_instances.default[0].instances.0, "public_ip")
  vpc_id             = local.create_instance ? alicloud_vpc.vpc[0].id : lookup(data.alicloud_instances.default[0].instances.0, "vpc_id")
  install_content    = <<SHELL
#!/bin/bash
# 安装JDK
wget https://download.java.net/openjdk/jdk8u41/ri/openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
tar -zxvf openjdk-8u41-b04-linux-x64-14_jan_2020.tar.gz
sudo mv java-se-8u41-ri/ /usr/java8
JAVA_HOME=/usr/java8
PATH=$PATH:$JAVA_HOME/bin
echo "export JAVA_HOME=$JAVA_HOME" | sudo tee -a /etc/profile
echo "export PATH=$PATH" | sudo tee -a /etc/profile
source /etc/profile
# 配置SSH免密登录
cd
if [ ! -f /root/.ssh/id_rsa ]; then
    ssh-keygen -t rsa -b 4096 -f /root/.ssh/id_rsa -N ""
fi
cd .ssh
cat id_rsa.pub >> authorized_keys
#安装Hadoop
wget http://mirrors.cloud.aliyuncs.com/apache/hadoop/common/hadoop-3.2.4/hadoop-3.2.4.tar.gz
sudo tar -zxvf hadoop-3.2.4.tar.gz -C /opt/
sudo mv /opt/hadoop-3.2.4 /opt/hadoop
HADOOP_HOME=/opt/hadoop
PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
echo "export HADOOP_HOME=$HADOOP_HOME" | sudo tee -a /etc/profile
echo "export PATH=\$PATH:\$HADOOP_HOME/bin:\$HADOOP_HOME/sbin" | sudo tee -a /etc/profile
sudo sh -c "echo 'export JAVA_HOME=$JAVA_HOME' >> /opt/hadoop/etc/hadoop/hadoop-env.sh"
sudo sh -c "echo 'export JAVA_HOME=$JAVA_HOME' >> /opt/hadoop/etc/hadoop/yarn-env.sh"
JAVA_HOME=/usr/java8
sudo sh -c "echo 'export JAVA_HOME=$JAVA_HOME' >> /opt/hadoop/etc/hadoop/hadoop-env.sh"
sudo sh -c "echo 'export JAVA_HOME=$JAVA_HOME' >> /opt/hadoop/etc/hadoop/yarn-env.sh"
source /etc/profile
SHELL

  configure_hadoop_content = <<SHELL
#!/bin/bash
# 配置Hadoop
sudo mv /opt/hadoop/etc/hadoop/core-site.xml /opt/hadoop/etc/hadoop/core-site.xml.bak
cat << "CORE" > /opt/hadoop/etc/hadoop/core-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<configuration>
    <property>
        <name>hadoop.tmp.dir</name>
        <value>file:/opt/hadoop/tmp</value>
        <description>location to store temporary files</description>
    </property>
    <property>
        <name>fs.defaultFS</name>
        <value>hdfs://localhost:9000</value>
    </property>
</configuration>
CORE

sudo mv /opt/hadoop/etc/hadoop/hdfs-site.xml /opt/hadoop/etc/hadoop/hdfs-site.xml.bak
cat << "HDFS" > /opt/hadoop/etc/hadoop/hdfs-site.xml
<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet type="text/xsl" href="configuration.xsl"?>

<configuration>
    <property>
        <name>dfs.replication</name>
        <value>1</value>
    </property>
    <property>
        <name>dfs.namenode.name.dir</name>
        <value>file:/opt/hadoop/tmp/dfs/name</value>
    </property>
    <property>
        <name>dfs.datanode.data.dir</name>
        <value>file:/opt/hadoop/tmp/dfs/data</value>
    </property>
</configuration>
HDFS
SHELL

  start_hadoop_content1 = <<SHELL
#!/bin/bash
sudo mv /opt/hadoop/sbin/start-dfs.sh /opt/hadoop/sbin/start-dfs.sh.bak
cat << "START" > /opt/hadoop/sbin/start-dfs.sh
#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Start hadoop dfs daemons.
# Optinally upgrade or rollback dfs state.
# Run this on master node.

## startup matrix:
#
# if $EUID != 0, then exec
# if $EUID =0 then
#    if hdfs_subcmd_user is defined, su to that user, exec
#    if hdfs_subcmd_user is not defined, error
#
# For secure daemons, this means both the secure and insecure env vars need to be
# defined.  e.g., HDFS_DATANODE_USER=root HDFS_DATANODE_SECURE_USER=hdfs
#

## @description  usage info
## @audience     private
## @stability    evolving
## @replaceable  no
HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root
function hadoop_usage
{
  echo "Usage: start-dfs.sh [-upgrade|-rollback] [-clusterId]"
}

this="$${BASH_SOURCE-$0}"
bin=$(cd -P -- "$(dirname -- "$${this}")" >/dev/null && pwd -P)

# let's locate libexec...
if [[ -n "$${HADOOP_HOME}" ]]; then
  HADOOP_DEFAULT_LIBEXEC_DIR="$${HADOOP_HOME}/libexec"
else
  HADOOP_DEFAULT_LIBEXEC_DIR="$${bin}/../libexec"
fi

HADOOP_LIBEXEC_DIR="$${HADOOP_LIBEXEC_DIR:-$HADOOP_DEFAULT_LIBEXEC_DIR}"
# shellcheck disable=SC2034
HADOOP_NEW_CONFIG=true
if [[ -f "$${HADOOP_LIBEXEC_DIR}/hdfs-config.sh" ]]; then
  . "$${HADOOP_LIBEXEC_DIR}/hdfs-config.sh"
else
  echo "ERROR: Cannot execute $${HADOOP_LIBEXEC_DIR}/hdfs-config.sh." 2>&1
  exit 1
fi

# get arguments
if [[ $# -ge 1 ]]; then
  startOpt="$1"
  shift
  case "$startOpt" in
    -upgrade)
      nameStartOpt="$startOpt"
    ;;
    -rollback)
      dataStartOpt="$startOpt"
    ;;
    *)
      hadoop_exit_with_usage 1
    ;;
  esac
fi


#Add other possible options
nameStartOpt="$nameStartOpt $*"

#---------------------------------------------------------
# namenodes

NAMENODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -namenodes 2>/dev/null)

if [[ -z "$${NAMENODES}" ]]; then
  NAMENODES=$(hostname)
fi

echo "Starting namenodes on [$${NAMENODES}]"
hadoop_uservar_su hdfs namenode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${NAMENODES}" \
    --daemon start \
    namenode $${nameStartOpt}

HADOOP_JUMBO_RETCOUNTER=$?

#---------------------------------------------------------
# datanodes (using default workers file)

echo "Starting datanodes"
hadoop_uservar_su hdfs datanode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --daemon start \
    datanode $${dataStartOpt}
(( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))

#---------------------------------------------------------
# secondary namenodes (if any)

SECONDARY_NAMENODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -secondarynamenodes 2>/dev/null)

if [[ -n "$${SECONDARY_NAMENODES}" ]]; then

  if [[ "$${NAMENODES}" =~ , ]]; then

    hadoop_error "WARNING: Highly available NameNode is configured."
    hadoop_error "WARNING: Skipping SecondaryNameNode."

  else

    if [[ "$${SECONDARY_NAMENODES}" == "0.0.0.0" ]]; then
      SECONDARY_NAMENODES=$(hostname)
    fi

    echo "Starting secondary namenodes [$${SECONDARY_NAMENODES}]"

    hadoop_uservar_su hdfs secondarynamenode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
      --workers \
      --config "$${HADOOP_CONF_DIR}" \
      --hostnames "$${SECONDARY_NAMENODES}" \
      --daemon start \
      secondarynamenode
    (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
  fi
fi

#---------------------------------------------------------
# quorumjournal nodes (if any)

JOURNAL_NODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -journalNodes 2>&-)

if [[ "$${#JOURNAL_NODES}" != 0 ]]; then
  echo "Starting journal nodes [$${JOURNAL_NODES}]"

  hadoop_uservar_su hdfs journalnode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${JOURNAL_NODES}" \
    --daemon start \
    journalnode
   (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
fi

#---------------------------------------------------------
# ZK Failover controllers, if auto-HA is enabled
AUTOHA_ENABLED=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey dfs.ha.automatic-failover.enabled | tr '[:upper:]' '[:lower:]')
if [[ "$${AUTOHA_ENABLED}" = "true" ]]; then
  echo "Starting ZK Failover Controllers on NN hosts [$${NAMENODES}]"

  hadoop_uservar_su hdfs zkfc "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${NAMENODES}" \
    --daemon start \
    zkfc
  (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
fi

exit $${HADOOP_JUMBO_RETCOUNTER}

# eof
START

sudo mv /opt/hadoop/sbin/stop-dfs.sh /opt/hadoop/sbin/stop-dfs.sh.bak
cat << "STOP" > /opt/hadoop/sbin/stop-dfs.sh
#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Stop hadoop dfs daemons.
# Run this on master node.

## @description  usage info
## @audience     private
## @stability    evolving
## @replaceable  no
HDFS_DATANODE_USER=root
HADOOP_SECURE_DN_USER=hdfs
HDFS_NAMENODE_USER=root
HDFS_SECONDARYNAMENODE_USER=root
function hadoop_usage
{
  echo "Usage: stop-dfs.sh"
}

this="$${BASH_SOURCE-$0}"
bin=$(cd -P -- "$(dirname -- "$${this}")" >/dev/null && pwd -P)

# let's locate libexec...
if [[ -n "$${HADOOP_HOME}" ]]; then
  HADOOP_DEFAULT_LIBEXEC_DIR="$${HADOOP_HOME}/libexec"
else
  HADOOP_DEFAULT_LIBEXEC_DIR="$${bin}/../libexec"
fi

HADOOP_LIBEXEC_DIR="$${HADOOP_LIBEXEC_DIR:-$HADOOP_DEFAULT_LIBEXEC_DIR}"
# shellcheck disable=SC2034
HADOOP_NEW_CONFIG=true
if [[ -f "$${HADOOP_LIBEXEC_DIR}/hdfs-config.sh" ]]; then
  . "$${HADOOP_LIBEXEC_DIR}/hdfs-config.sh"
else
  echo "ERROR: Cannot execute $${HADOOP_LIBEXEC_DIR}/hdfs-config.sh." 2>&1
  exit 1
fi

#---------------------------------------------------------
# namenodes

NAMENODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -namenodes 2>/dev/null)

if [[ -z "$${NAMENODES}" ]]; then
  NAMENODES=$(hostname)
fi

echo "Stopping namenodes on [$${NAMENODES}]"

  hadoop_uservar_su hdfs namenode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${NAMENODES}" \
    --daemon stop \
    namenode

#---------------------------------------------------------
# datanodes (using default workers file)

echo "Stopping datanodes"

hadoop_uservar_su hdfs datanode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
  --workers \
  --config "$${HADOOP_CONF_DIR}" \
  --daemon stop \
  datanode

#---------------------------------------------------------
# secondary namenodes (if any)

SECONDARY_NAMENODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -secondarynamenodes 2>/dev/null)

if [[ "$${SECONDARY_NAMENODES}" == "0.0.0.0" ]]; then
  SECONDARY_NAMENODES=$(hostname)
fi

if [[ -n "$${SECONDARY_NAMENODES}" ]]; then
  echo "Stopping secondary namenodes [$${SECONDARY_NAMENODES}]"

  hadoop_uservar_su hdfs secondarynamenode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${SECONDARY_NAMENODES}" \
    --daemon stop \
    secondarynamenode
fi

#---------------------------------------------------------
# quorumjournal nodes (if any)

JOURNAL_NODES=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -journalNodes 2>&-)

if [[ "$${#JOURNAL_NODES}" != 0 ]]; then
  echo "Stopping journal nodes [$${JOURNAL_NODES}]"

  hadoop_uservar_su hdfs journalnode "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${JOURNAL_NODES}" \
    --daemon stop \
    journalnode
fi

#---------------------------------------------------------
# ZK Failover controllers, if auto-HA is enabled
AUTOHA_ENABLED=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey dfs.ha.automatic-failover.enabled | tr '[:upper:]' '[:lower:]')
if [[ "$${AUTOHA_ENABLED}" = "true" ]]; then
  echo "Stopping ZK Failover Controllers on NN hosts [$${NAMENODES}]"

  hadoop_uservar_su hdfs zkfc "$${HADOOP_HDFS_HOME}/bin/hdfs" \
    --workers \
    --config "$${HADOOP_CONF_DIR}" \
    --hostnames "$${NAMENODES}" \
    --daemon stop \
    zkfc
fi

# eof
STOP
SHELL

  start_hadoop_content2 = <<SHELL
#!/bin/bash
sudo mv /opt/hadoop/sbin/start-yarn.sh /opt/hadoop/sbin/start-yarn.sh.bak
cat << "START" > /opt/hadoop/sbin/start-yarn.sh
#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## @description  usage info
## @audience     private
## @stability    evolving
## @replaceable  no
YARN_RESOURCEMANAGER_USER=root
HADOOP_SECURE_DN_USER=yarn
YARN_NODEMANAGER_USER=root
function hadoop_usage
{
  hadoop_generate_usage "$${MYNAME}" false
}

MYNAME="$${BASH_SOURCE-$0}"

bin=$(cd -P -- "$(dirname -- "$${MYNAME}")" >/dev/null && pwd -P)

# let's locate libexec...
if [[ -n "$${HADOOP_HOME}" ]]; then
  HADOOP_DEFAULT_LIBEXEC_DIR="$${HADOOP_HOME}/libexec"
else
  HADOOP_DEFAULT_LIBEXEC_DIR="$${bin}/../libexec"
fi
HADOOP_LIBEXEC_DIR="$${HADOOP_LIBEXEC_DIR:-$HADOOP_DEFAULT_LIBEXEC_DIR}"
# shellcheck disable=SC2034
HADOOP_NEW_CONFIG=true
if [[ -f "$${HADOOP_LIBEXEC_DIR}/yarn-config.sh" ]]; then
  . "$${HADOOP_LIBEXEC_DIR}/yarn-config.sh"
else
  echo "ERROR: Cannot execute $${HADOOP_LIBEXEC_DIR}/yarn-config.sh." 2>&1
  exit 1
fi

HADOOP_JUMBO_RETCOUNTER=0

# start resourceManager
HARM=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey yarn.resourcemanager.ha.enabled 2>&-)
if [[ $${HARM} = "false" ]]; then
  echo "Starting resourcemanager"
  hadoop_uservar_su yarn resourcemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --daemon start \
      resourcemanager
  (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
else
  logicals=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey yarn.resourcemanager.ha.rm-ids 2>&-)
  logicals=$${logicals//,/ }
  for id in $${logicals}
  do
      rmhost=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey "yarn.resourcemanager.hostname.$${id}" 2>&-)
      RMHOSTS="$${RMHOSTS} $${rmhost}"
  done
  echo "Starting resourcemanagers on [$${RMHOSTS}]"
  hadoop_uservar_su yarn resourcemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --daemon start \
      --workers \
      --hostnames "$${RMHOSTS}" \
      resourcemanager
  (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
fi

# start nodemanager
echo "Starting nodemanagers"
hadoop_uservar_su yarn nodemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
    --config "$${HADOOP_CONF_DIR}" \
    --workers \
    --daemon start \
    nodemanager
(( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))


# start proxyserver
PROXYSERVER=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey  yarn.web-proxy.address 2>&- | cut -f1 -d:)
if [[ -n $${PROXYSERVER} ]]; then
 hadoop_uservar_su yarn proxyserver "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --workers \
      --hostnames "$${PROXYSERVER}" \
      --daemon start \
      proxyserver
 (( HADOOP_JUMBO_RETCOUNTER=HADOOP_JUMBO_RETCOUNTER + $? ))
fi

exit $${HADOOP_JUMBO_RETCOUNTER}
START

sudo mv /opt/hadoop/sbin/stop-yarn.sh /opt/hadoop/sbin/stop-yarn.sh.bak
cat << "STOP" > /opt/hadoop/sbin/stop-yarn.sh
#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

## @description  usage info
## @audience     private
## @stability    evolving
## @replaceable  no
YARN_RESOURCEMANAGER_USER=root
HADOOP_SECURE_DN_USER=yarn
YARN_NODEMANAGER_USER=root
function hadoop_usage
{
  hadoop_generate_usage "$${MYNAME}" false
}

MYNAME="$${BASH_SOURCE-$0}"

bin=$(cd -P -- "$(dirname -- "$${MYNAME}")" >/dev/null && pwd -P)

# let's locate libexec...
if [[ -n "$${HADOOP_HOME}" ]]; then
  HADOOP_DEFAULT_LIBEXEC_DIR="$${HADOOP_HOME}/libexec"
else
  HADOOP_DEFAULT_LIBEXEC_DIR="$${bin}/../libexec"
fi

HADOOP_LIBEXEC_DIR="$${HADOOP_LIBEXEC_DIR:-$HADOOP_DEFAULT_LIBEXEC_DIR}"
# shellcheck disable=SC2034
HADOOP_NEW_CONFIG=true
if [[ -f "$${HADOOP_LIBEXEC_DIR}/yarn-config.sh" ]]; then
  . "$${HADOOP_LIBEXEC_DIR}/yarn-config.sh"
else
  echo "ERROR: Cannot execute $${HADOOP_LIBEXEC_DIR}/yarn-config.sh." 2>&1
  exit 1
fi

# stop nodemanager
echo "Stopping nodemanagers"
hadoop_uservar_su yarn nodemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
    --config "$${HADOOP_CONF_DIR}" \
    --workers \
    --daemon stop \
    nodemanager

# stop resourceManager
HARM=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey yarn.resourcemanager.ha.enabled 2>&-)
if [[ $${HARM} = "false" ]]; then
  echo "Stopping resourcemanager"
  hadoop_uservar_su yarn resourcemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --daemon stop \
      resourcemanager
else
  logicals=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey yarn.resourcemanager.ha.rm-ids 2>&-)
  logicals=$${logicals//,/ }
  for id in $${logicals}
  do
      rmhost=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey "yarn.resourcemanager.hostname.$${id}" 2>&-)
      RMHOSTS="$${RMHOSTS} $${rmhost}"
  done
  echo "Stopping resourcemanagers on [$${RMHOSTS}]"
  hadoop_uservar_su yarn resourcemanager "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --daemon stop \
      --workers \
      --hostnames "$${RMHOSTS}" \
      resourcemanager
fi

# stop proxyserver
PROXYSERVER=$("$${HADOOP_HDFS_HOME}/bin/hdfs" getconf -confKey  yarn.web-proxy.address 2>&- | cut -f1 -d:)
if [[ -n $${PROXYSERVER} ]]; then
  echo "Stopping proxy server [$${PROXYSERVER}]"
  hadoop_uservar_su yarn proxyserver "$${HADOOP_YARN_HOME}/bin/yarn" \
      --config "$${HADOOP_CONF_DIR}" \
      --workers \
      --hostnames "$${PROXYSERVER}" \
      --daemon stop \
      proxyserver
fi
STOP
# 启动Hadoop
sudo -u root /opt/hadoop/bin/hdfs namenode -format
chmod +x /opt/hadoop/sbin/start-dfs.sh
chmod +x /opt/hadoop/sbin/start-yarn.sh
/opt/hadoop/sbin/start-dfs.sh
/opt/hadoop/sbin/start-yarn.sh
SHELL
}

output "ecs_login_address" {
  value = "https://ecs-workbench.aliyun.com/?from=EcsConsole&instanceType=ecs&regionId=${var.region}&instanceId=${local.instanceId}"
}