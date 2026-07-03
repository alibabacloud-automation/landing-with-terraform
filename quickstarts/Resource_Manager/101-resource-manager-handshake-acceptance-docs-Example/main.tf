terraform {
  required_providers {
    alicloud = {
      source = "aliyun/alicloud"
    }
  }
}

variable "region" {
  default = "cn-hangzhou"
}

variable "management_access_key" {
  type      = string
  sensitive = true
}

variable "management_secret_key" {
  type      = string
  sensitive = true
}

variable "invited_access_key" {
  type      = string
  sensitive = true
}

variable "invited_secret_key" {
  type      = string
  sensitive = true
}

variable "invited_account_id" {
  type = string
}

provider "alicloud" {
  alias      = "management"
  region     = var.region
  access_key = var.management_access_key
  secret_key = var.management_secret_key
}

provider "alicloud" {
  alias      = "invited"
  region     = var.region
  access_key = var.invited_access_key
  secret_key = var.invited_secret_key
}

# The management account sends the invitation.
resource "alicloud_resource_manager_handshake" "example" {
  provider = alicloud.management

  target_entity = var.invited_account_id
  target_type   = "Account"
  note          = "test resource manager handshake"
}

# The invited account accepts it.
resource "alicloud_resource_manager_handshake_acceptance" "example" {
  provider     = alicloud.invited
  handshake_id = alicloud_resource_manager_handshake.example.id
}