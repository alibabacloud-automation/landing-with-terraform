# Alibaba Cloud Terraform QuickStarts Contribution Guidelines

## Example Structure

The naming of a catalog consists of a prefix and a usage situation. 

The naming prefix reflects the complexity of the examples. It consists of the following values: `101`, `201`, `301`, which indicate the `beginner`, `intermediate`, and `advanced` usage of the resource, respectively.

- beginner：For beginner developers, mainly for single resource types. The directory naming format is: 101-\<example name\>.

- intermediate：For intermediate developers, mainly multi-resource types, presenting a small scene. The directory naming format is: 201-\<example name\>.

- advanced：Aimed at advanced developers, the main focus is on actual customer scenarios, presenting an actual customer scenario example. The directory naming format is: 301-\<example name\>.

An example contains at least the following files: 

```bash
.
├── README.md
├── footer.md
├── header.md
├── main.tf
├── provider.tf
└── variable.tf
```

### `provider.tf`

This file defines the provider information required for the example to execute.

### `variable.tf`

This file defines all the variable informations in the example. Each variable definition should contain the default value, variable type, and description information.

```
variable "name" {
  description = "The usage of variables is described here."
  type        = string
  default     = "tf-example"
}
```

### `main.tf`

This file demonstrates the use of specific data source and resource resources.



### `README.md`

Each example should be followed by the corresponding documentation. It can be automatically generated with the terraform-docs CLI. The command is wrapped in `scripts/doc-generate.sh` script. 

**NOTE:**  The generation of The `README.md` depends on the contents of `header.md`, and `footer.md`.

Before executing the following commands, you need to [Install the terraform-docs CLI](https://terraform-docs.io/user-guide/installation/) first.


```bash
# The argument is the path of the examples, unlimited in number.
./scripts/doc-generate.sh quickstarts/VPC/101-vpc-complete quickstarts/VPC/101-vpc-doc-Example

# You can also specify a folder to generate documents.
./scripts/doc-generate.sh quickstarts/VPC/

# If there are no arguments, all examples‘ documents in the quickstarts directory will be generated
./scripts/doc-generate.sh 
```


### `header.md` 

This file contains the introduction and requirements of the example. It will be added to the beginning of the `README.md`. 

```markdown

## Introduction

Here is the brief introduction for example usage scenes.

## Requirements

Here is a list of dependencies that need to be created before executing the example

```

### `footer.md`

The contents of `footer.md` will be used as a footnote in `README.md`


