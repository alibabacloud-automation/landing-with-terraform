variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-hangzhou"
}


resource "alicloud_open_api_explorer_api_mcp_server" "default" {
  system_tools = ["FetchRamActionDetails"]
  description  = "Create"
  prompts {
    description = "Obtain user customization information description"
    content     = "Prompt body,{{name}}"
    arguments {
      description = "Name information"
      required    = true
      name        = "name"
    }
    name = "Obtain user customization information"
  }
  prompts {
    description = "Obtain user customization information description"
    content     = "Prompt text, {{name }}, {{age }}, {{description}}"
    arguments {
      description = "Name information"
      required    = true
      name        = "name"
    }
    arguments {
      description = "Age information"
      required    = true
      name        = "age"
    }
    arguments {
      description = "Description Information"
      required    = true
      name        = "description"
    }
    name = "Obtain user customization information 1"
  }
  oauth_client_id = "123456"
  apis {
    api_version = "2014-05-26"
    product     = "Ecs"
    selectors   = ["DescribeAvailableResource", "DescribeRegions", "DescribeZones"]
  }
  apis {
    api_version = "2017-03-21"
    product     = "vod"
    selectors   = ["CreateUploadVideo"]
  }
  apis {
    api_version = "2014-05-15"
    product     = "Slb"
    selectors   = ["DescribeAvailableResource"]
  }
  instructions = "Describes the role of the entire MCP Server"
  additional_api_descriptions {
    api_version          = "2014-05-26"
    enable_output_schema = true
    api_name             = "DescribeAvailableResource"
    const_parameters {
      value = "cn-hangzhou"
      key   = "x_mcp_region_id"
    }
    const_parameters {
      value = "B1"
      key   = "a1"
    }
    const_parameters {
      value = "b2"
      key   = "a2"
    }
    api_override_json   = jsonencode({ "summary" : "This operation supports querying the list of instances based on different request conditions and associating the query instance details. " })
    product             = "Ecs"
    execute_cli_command = false
  }
  additional_api_descriptions {
    api_version          = "2014-05-26"
    enable_output_schema = true
    api_name             = "DescribeRegions"
    product              = "Ecs"
    execute_cli_command  = true
  }
  additional_api_descriptions {
    api_version          = "2014-05-26"
    enable_output_schema = true
    api_name             = "DescribeZones"
    product              = "Ecs"
    execute_cli_command  = true
  }
  vpc_whitelists           = ["vpc-examplea", "vpc-exampleb", "vpc-examplec"]
  name                     = "my-name"
  language                 = "ZH_CN"
  enable_assume_role       = true
  assume_role_extra_policy = jsonencode({ "Version" : "1", "Statement" : [{ "Effect" : "Allow", "Action" : ["ecs:Describe*", "vpc:Describe*", "vpc:List*"], "Resource" : "*" }] })
  terraform_tools {
    description    = "Terraform as tool example"
    async          = true
    destroy_policy = "NEVER"
    code           = <<EOF
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default" {
  ipv6_isp    = "BGP"
  description = "example"
  cidr_block  = "10.0.0.0/8"
  vpc_name    = var.name
  enable_ipv6 = true
}
  EOF
    name           = "tfexample"
  }
  terraform_tools {
    description    = "Terraform as tool example"
    async          = true
    destroy_policy = "NEVER"
    code           = <<EOF
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default" {
  ipv6_isp    = "BGP"
  description = "example"
  cidr_block  = "10.0.0.0/8"
  vpc_name    = var.name
  enable_ipv6 = true
}
  EOF
    name           = "tfexample2"
  }
  terraform_tools {
    description    = "Terraform as tool example"
    async          = true
    destroy_policy = "NEVER"
    code           = <<EOF
variable "name" {
  default = "terraform-example"
}

provider "alicloud" {
  region = "cn-beijing"
}

resource "alicloud_vpc" "default" {
  ipv6_isp    = "BGP"
  description = "example"
  cidr_block  = "10.0.0.0/8"
  vpc_name    = var.name
  enable_ipv6 = true
}
  EOF
    name           = "tfexample3"
  }
  assume_role_name            = "default-role"
  public_access               = "on"
  enable_custom_vpc_whitelist = true
}