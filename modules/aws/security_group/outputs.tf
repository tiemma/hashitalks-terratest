output "name" {
  value = aws_security_group.sg.name
}

output "id" {
  value = aws_security_group.sg.id
}

output "vpc_id" {
  value = aws_security_group.sg.vpc_id
}

output "owner_id" {
  value = aws_security_group.sg.owner_id
}

output "arn" {
  value = aws_security_group.sg.arn
}

output "description" {
  value = aws_security_group.sg.description
}

output "ingress" {
  value = aws_security_group.sg.ingress
}

output "egress" {
  value = aws_security_group.sg.egress
}

output "tags" {
  value = aws_security_group.sg.tags
}

output "used_by" {
  value = var.used_by
}
