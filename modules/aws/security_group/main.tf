locals {
  name = length(var.name) > 0 ? var.name : random_string.name.result
  used_by = join(", ", var.used_by)
  tags = merge(var.tags, {"used_by": local.used_by, "managed_by": "terraform"})
}

resource "random_string" "name" {
  length = 10
  upper = false
  special = false
}

resource "aws_security_group" "sg" {
  name = local.name
  description = format("Security group for the %s resource", local.used_by)
  vpc_id = var.vpc_id
  tags = local.tags 
  dynamic "ingress" {
    for_each = var.ingress == null ? [] : var.ingress
    content {
      cidr_blocks = contains(keys(ingress.value), "cidr_blocks") ? ingress.value.cidr_blocks : null
      ipv6_cidr_blocks = contains(keys(ingress.value), "ipv6_cidr_blocks") ? ingress.value.ipv6_cidr_blocks : null
      prefix_list_ids = contains(keys(ingress.value), "prefix_list_ids") ? ingress.value.prefix_list_ids : null
      from_port = lookup(ingress.value, "from_port", 0)
      protocol = lookup(ingress.value, "protocol", "tcp")
      security_groups = contains(keys(ingress.value), "security_groups") ? ingress.value.security_groups : null
      self = lookup(ingress.value, "self", false)
      to_port = lookup(ingress.value, "to_port", 0)
      description = format("Ingress rule for the %s security group", local.name)
    }
  }
  
  dynamic "egress" {
    for_each = var.egress == null ? [] : var.egress 
    content {
      cidr_blocks = contains(keys(egress.value), "cidr_blocks") ?  egress.value.cidr_blocks : null 
      ipv6_cidr_blocks = contains(keys(egress.value), "ipv6_cidr_blocks") ? egress.value.ipv6_cidr_blocks : null
      prefix_list_ids = contains(keys(egress.value), "prefix_list_ids") ? egress.value.prefix_list_ids : null
      from_port = lookup(egress.value, "from_port", 0)
      protocol = lookup(egress.value, "protocol", "tcp")
      security_groups = contains(keys(egress.value), "security_groups") ? egress.value.security_groups : null
      self = lookup(egress.value, "self", false)
      to_port = lookup(egress.value, "to_port", 0)
      description = format("Egress rule for the %s security group", local.name)
    }
  }
}
