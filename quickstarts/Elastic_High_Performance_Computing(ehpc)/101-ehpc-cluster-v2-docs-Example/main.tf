variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}

resource "alicloud_vpc" "example" {
  is_default = false
  cidr_block = "10.0.0.0/24"
  vpc_name   = "example-cluster-vpc"
}

resource "alicloud_nas_access_group" "example" {
  access_group_type = "Vpc"
  description       = var.name
  access_group_name = "StandardMountTarget"
  file_system_type  = "standard"
}

resource "alicloud_nas_file_system" "example" {
  description  = "example-cluster-nas"
  storage_type = "Capacity"
  nfs_acl {
    enabled = false
  }
  zone_id          = "cn-hangzhou-k"
  encrypt_type     = "0"
  protocol_type    = "NFS"
  file_system_type = "standard"
}

resource "alicloud_vswitch" "example" {
  is_default   = false
  vpc_id       = alicloud_vpc.example.id
  zone_id      = "cn-hangzhou-k"
  cidr_block   = "10.0.0.0/24"
  vswitch_name = "example-cluster-vsw"
}

resource "alicloud_nas_access_rule" "example" {
  priority          = "1"
  access_group_name = alicloud_nas_access_group.example.access_group_name
  file_system_type  = alicloud_nas_file_system.example.file_system_type
  source_cidr_ip    = "10.0.0.0/24"
}

resource "alicloud_security_group" "example" {
  vpc_id              = alicloud_vpc.example.id
  security_group_type = "normal"
}

resource "alicloud_nas_mount_target" "example" {
  vpc_id            = alicloud_vpc.example.id
  network_type      = "Vpc"
  access_group_name = alicloud_nas_access_group.example.access_group_name
  vswitch_id        = alicloud_vswitch.example.id
  file_system_id    = alicloud_nas_file_system.example.id
}


resource "alicloud_ehpc_cluster_v2" "default" {
  cluster_credentials {
    password = "aliHPC123"
  }
  cluster_vpc_id      = alicloud_vpc.example.id
  cluster_category    = "Standard"
  cluster_mode        = "Integrated"
  security_group_id   = alicloud_security_group.example.id
  cluster_name        = "minimal-example-cluster"
  deletion_protection = true
  client_version      = "2.0.47"
  shared_storages {
    mount_directory     = "/home"
    nas_directory       = "/"
    mount_target_domain = alicloud_nas_mount_target.example.mount_target_domain
    protocol_type       = "NFS"
    file_system_id      = alicloud_nas_file_system.example.id
    mount_options       = "-t nfs -o vers=3,nolock,proto=tcp,noresvport"
  }
  shared_storages {
    mount_directory     = "/opt"
    nas_directory       = "/"
    mount_target_domain = alicloud_nas_mount_target.example.mount_target_domain
    protocol_type       = "NFS"
    file_system_id      = alicloud_nas_file_system.example.id
    mount_options       = "-t nfs -o vers=3,nolock,proto=tcp,noresvport"
  }
  shared_storages {
    mount_directory     = "/ehpcdata"
    nas_directory       = "/"
    mount_target_domain = alicloud_nas_mount_target.example.mount_target_domain
    protocol_type       = "NFS"
    file_system_id      = alicloud_nas_file_system.example.id
    mount_options       = "-t nfs -o vers=3,nolock,proto=tcp,noresvport"
  }
  cluster_vswitch_id = alicloud_vswitch.example.id
  manager {
    manager_node {
      system_disk {
        category = "cloud_essd"
        size     = "40"
        level    = "PL0"
      }
      enable_ht            = true
      instance_charge_type = "PostPaid"
      image_id             = "centos_7_6_x64_20G_alibase_20211130.vhd"
      spot_price_limit     = 0
      instance_type        = "ecs.c6.xlarge"
      spot_strategy        = "NoSpot"
    }
    scheduler {
      type    = "SLURM"
      version = "22.05.8"
    }
    dns {
      type    = "nis"
      version = "1.0"
    }
    directory_service {
      type    = "nis"
      version = "1.0"
    }
  }
}