provider aws {  
  version = "2.58"
}

locals {
  ip = format("%s/32", data.http.ip.body)
  ingress = [
  {
    "to_port": 22,
    "from_port": 22,
    "cidr_blocks": [local.ip]
  },
  {
    "to_port": 80,
    "from_port": 80,
    "cidr_blocks": ["0.0.0.0/0"]
  }
]
}

module "sg" {
  source = "../modules/aws/security_group"
  ingress = local.ingress
  egress = var.egress
  name = var.name
  tags = var.tags
  used_by = var.used_by
}

module "instance" {
  source = "../modules/aws/ec2"
  public_key_path = var.public_key_path
  instance_type = var.instance_type
  tags = var.tags
  security_groups = [module.sg.name]
  enable_metadata_server = var.enable_metadata_server
  image_name = var.image_name
  run_args = var.run_args
}
