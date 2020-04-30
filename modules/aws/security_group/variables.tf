variable "ingress" {
  type = list(any)
  default = []
  description = "Default ingress security group definition"
}

variable "egress" {
  type = list(any)
  default = []
  description = "Default egress security group definition"
}

variable "name" {
  type = string
  default = ""
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
