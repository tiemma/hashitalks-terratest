variable "ingress" {
  type = list(any)
  description = "Default ingress security group definition"
  default = []
}

variable "egress" {
  type = list(any)
  description = "Default egress security group definition"
  default = [
    {
      "to_port": 0
      "from_port": 0
      "protocol": -1
      "cidr_blocks": ["0.0.0.0/0"] 
    }
  ]
}

variable "name" {
  type = string
  default = "allow_ssh"
  description = "Name of the security group"
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags of the security group"
}

variable "vpc_id" {
  type = string
  default = ""
  description = "VPC where this security group is deployed"
}

variable "used_by" {
  type = list(string)
  default = []
  description = "List of resources using this security group"
}

variable "public_key_path" {
  type = string
  description = "Path to a public key (*.pub) file for use in the ec2 keypair"
  default = "~/.ssh/terraform.pub"
}

variable "instance_type" {
  type = string
  description = "Instance type to provision"
  default = "t2.micro"
}

variable "security_groups" {
  type = list(string)
  description = "Security groups to apply to the instance"
  default = []
}

variable "enable_metadata_server" {
  type = bool
  description = "Flag to enable or disable the metadata endpoint, disabled by default"
  default = true
}

variable "image_name" {
  type = string
  description = "Image to run on the EC2 instance"
  default = "docker.io/tiemma/ecs-app:latest"
}

variable "run_args" {
  type = list(string)
  description = "Extra arguments to pass to the run command" 
  default = ["-p 80:8080", "-e PORT=8080"]
}
