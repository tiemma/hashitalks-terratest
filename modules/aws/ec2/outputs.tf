
output "public_ip" {
  value = aws_instance.web.public_ip
}

output "arn" {
  value = aws_instance.web.arn
}

output "id" {
  value = aws_instance.web.id
}

output "key_name" {
  value = aws_instance.web.key_name
}

output "instance_state" {
  value = aws_instance.web.instance_state
} 
