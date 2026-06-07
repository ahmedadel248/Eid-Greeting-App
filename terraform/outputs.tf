output "instance_public_ip" {

  value = aws_instance.eid[0].public_ip

}

output "instance_public_ips" {

  value = aws_instance.eid[*].public_ip

}

output "vpc_id" {

  value = aws_vpc.main.id

}

output "elastic_ip" {

  value = aws_eip.main.public_ip

}