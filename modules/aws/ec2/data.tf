data "aws_ami" "packer" {
    most_recent      = true
    owners           = ["self"]
      filter {
        name   = "name"
        values = ["packer-*"]
      }
      filter {
        name   = "root-device-type"
        values = ["ebs"]
      }
      filter {
        name   = "virtualization-type"
        values = ["hvm"]      
      }
      filter {
        name = "tag:Managed_By"
        values = ["packer"]
      }
}


