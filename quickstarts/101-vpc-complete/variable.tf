variable "dry_run" {
  description = "Whether to PreCheck this request only. Value:\n-**true**: sends a check request and does not create a VPC. Check items include whether required parameters, request format, and business restrictions have been filled in. If the check fails, the corresponding error is returned. If the check passes, the error code 'DryRunOperation' is returned '.\n-**false** (default): Sends a normal request, returns the HTTP 2xx status code after the check, and directly creates a VPC."
  type        = bool
  default     = false
}

variable "enable_ipv6" {
  description = "Whether to enable the IPv6 network segment. Value:\n\n-**false** (default): not enabled.\n-**true**: on."
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The name of the VPC. Defaults to null."
  type        = string
  default     = "tf-example"
}

variable "classic_link_enabled" {
  description = "The status of ClassicLink function."
  type        = bool
  default     = true
}

variable "ipv6_isp" {
  description = "The IPv6 address segment type of the VPC. Value:\n\n-**BGP** (default): Alibaba Cloud BGP IPv6.\n-**ChinaMobile**: China Mobile (single line).\n-**ChinaUnicom**: China Unicom (single line).\n-**ChinaTelecom**: China Telecom (single line).\n\n> If a single-line bandwidth whitelist is enabled, this field can be set to **ChinaTelecom** (China Telecom), **ChinaUnicom** (China Unicom), or **ChinaMobile** (China Mobile)."
  type        = string
  default     = "BGP"
}

variable "cidr_block" {
  description = "The CIDR block for the VPC. The `cidr_block` is Optional and default value is `172.16.0.0/12` after v1.119.0+."
  type        = string
  default     = "172.16.0.0/12"
}

variable "description" {
  description = "The VPC description. Defaults to null."
  type        = string
  default     = "tf-example"
}

