## Demo for HashiTalks Africa Talk

[Slides](https://docs.google.com/presentation/d/1EDzJdlaBkgbw5jECntb3i4TLyic0aG2mWZMopeg8PUQ/edit#slide=id.g7ffe38d48e_2_1266)

The talk focuses on demoing a simple scenario

- Create a docker image using Docker
- Create an AMI with docker pre-installed using Packer
- Create an instance with the AMI using Terraform
- Provision the instance with a docker container 

All these various steps are unit tested and an eventual integration and E2E test is used to check all the components work as needed.

All the tests are in the tests package.


## What is Terratest
[Terratest](https://terratest.gruntwork.io/) is a testing library in Go that checks that your terraform code works as expected.

To properly test your application, it's advisable to package your code into modules.

Terraform modules allow you resuse your TF code and configure different variables to your resources.

So this allows you to have isolations for testing a single resource independently  without specifying a `-target` that's more of a hack to testing.


## Folder Structures

```bash
> tree examples modules tests
examples
├── data.tf
├── main.tf
├── outputs.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
modules
├── aws
│   ├── ec2
│   │   ├── data.tf
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   └── variables.tf
│   └── security_group
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
├── docker
│   ├── Dockerfile
│   ├── main.go
│   └── README.md
└── packer
    ├── README.md
    └── builder.json
tests
├── aws_ec2_instance_test.go
├── aws_infra_integration_test.go
├── aws_security_group_module_test.go
├── docker_test.go
└── packer_build_test.go

12 directories, 33 files
```

### Examples
All the code for the demo using the modules are here
We use this to deploy the entire app.

### Modules
All the modules we use in the examples are written here.
We define a 
 - Module for creating a security group and ec2 instance on AWS.
 - Module for the docker artifacts
 - Module for the packer artifacts

### Tests
All the tests for the modules and the entire thing runninng together is found here
You can run the tests by doing
```
cd tests
go test
```

