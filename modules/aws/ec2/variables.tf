variable "public_key_path" {
  type = string
  description = "Path to a public key (*.pub) file for use in the ec2 keypair"
}

variable "instance_type" {
  type = string
  description = "Instance type to provision"
  default = "t2.micro"
}

variable "tags" {
  type = map(string)
  description = "Tags to add to the instance"
  default = {}
}

variable "security_groups" {
  type = list(string)
  description = "Security groups to apply to the instance"
}

variable "enable_metadata_server" {
  type = bool
  description = "Flag to enable or disable the metadata endpoint, disabled by default"
  default = true
}

variable "image_name" {
  type = string
  description = "Image to run on the EC2 instance"
}

variable "default_run_args" {
  type = list(string)
  description = "Default arguments to pass to the run command, by default grants access to bind to ports only"
  default = ["--rm", "--detach", "--cap-drop=ALL", "--cap-add=CAP_NET_RAW"]
}

variable "run_args" {
  type = list(string)
  description = "Extra arguments to pass to the run command"
  default = ["-p 80:8080"]
}

