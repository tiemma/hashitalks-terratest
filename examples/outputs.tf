output "sg_name" {
  value = module.sg.name
}

output "sg_id" {
  value = module.sg.id
}

output "sg_vpc_id" {
  value = module.sg.vpc_id
}

output "sg_owner_id" {
  value = module.sg.owner_id
}

output "sg_arn" {
  value = module.sg.arn
}

output "sg_description" {
  value = module.sg.description
}

output "sg_ingress" {
  value = module.sg.ingress
}

output "sg_egress" {
  value = module.sg.egress
}

output "sg_tags" {
  value = module.sg.tags
}

output "sg_used_by" {
  value = module.sg.used_by
}

output "ec2_public_ip" {
  value = module.instance.public_ip
}

output "ec2_arn" {
  value = module.instance.arn
}

output "ec2_id" {
  value = module.instance.id
}

output "ec2_instance_state" {
  value = module.instance.instance_state
}
