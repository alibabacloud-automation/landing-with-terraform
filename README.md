# landing-with-terraform

Alibaba Cloud Terraform QuickStart Templates and Solutions Repository

## Directory Structure

This repository contains Alibaba Cloud Terraform quickstart templates, reusable modules, technical solutions, and learning resources.

```
landing-with-terraform/
├── quickstarts/          # QuickStart templates
├── modules/              # Reusable Terraform modules
├── solution/             # Technical solutions
├── learnings/            # Learning resources
├── provider/             # Terraform Provider source code
└── README.md             # This file
```

### quickstarts/ - QuickStart Templates

Organized by product categories. Each example contains:

- `main.tf` - Terraform configuration file
- `provider.tf` - Provider configuration
- `README.md` - Usage documentation
- `TestRecord.md` - Test records

Each product directory contains multiple examples. Example naming follows the format below, with prefixes distinguishing difficulty levels:

- **beginner**: For entry-level developers, mainly single resource types. Example directory naming format: `101-<example name>`
- **intermediate**: For intermediate developers, mainly multiple resource types, presenting a small scenario. Example directory naming format: `201-<example name>`
- **advanced**: For advanced developers, mainly actual customer scenarios, presenting real customer scenario cases. Example directory naming format: `301-<example name>`

### modules/ - Terraform Modules

Contains reusable Terraform modules for quickly building common infrastructure combinations.

### solution/ - Technical Solutions

Used to store automation solutions based on Terraform and IaC. Each solution is managed using an independent directory and organized by specific domains, such as LandingZone, Well-Architect-Framework, Cloud Native, etc.

### learnings/ - Learning Resources

The learnings directory is primarily used to store Terraform-related learning content, helping customers better understand, get started with, and learn Terraform. 


### provider/ - Terraform Provider Source Code

Contains the complete source code of `terraform-provider-alicloud` for developing and maintaining the Alibaba Cloud Terraform Provider.

## Quick Start

1. **Using QuickStart Templates**:
   ```bash
   cd quickstarts/{product-name}/{example-name}
   terraform init
   terraform plan
   terraform apply
   ```

2. **Deploying Technical Solutions**:
   ```bash
   cd solution/tech-solution/{solution-name}
   terraform init
   terraform plan
   terraform apply
   ```

## Contributing

Issues and Pull Requests are welcome to improve this repository.
