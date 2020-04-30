
provider aws {

}

resource "random_string" "name" {
    length = 10
    upper = false
    special = false
}

resource "aws_key_pair" "deployer" {
    key_name   = format("deployer-key-%s", random_string.name.result)
    public_key = file(var.public_key_path)
    tags = local.tags
}


locals {
  default_tags = {"managed_by": "terraform"}
  tags = merge(var.tags, local.default_tags)
  default_run_args = join(" ", var.default_run_args)
  run_args = join(" ", var.run_args)
}

resource "aws_instance" "web" {
    ami           = data.aws_ami.packer.id
    instance_type = var.instance_type
    tags = local.tags
    key_name = aws_key_pair.deployer.key_name
    security_groups = var.security_groups
    metadata_options {
      http_endpoint = var.enable_metadata_server ? "enabled" : "disabled"  
    }
    provisioner "remote-exec" {
      inline = [
        format("docker pull %s", var.image_name),
        format("docker run %s %s %s", local.default_run_args, local.run_args, var.image_name)
      ]

      connection {
        type = "ssh"
        user     = "ubuntu"
        host = self.public_ip
        private_key = file(replace(var.public_key_path, ".pub", ""))
      }
    }
  }

  
