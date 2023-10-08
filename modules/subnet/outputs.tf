output "first_pub_id" {
    value = aws_subnet.terraform_subnet[0].id
  
}

output "first_pri_id" {
    value = aws_subnet.terraform_subnet[1].id
  
}

output "second_pri_id" {
    value = aws_subnet.terraform_subnet[2].id
  
}

output "second_pub_id" {
    value = aws_subnet.terraform_subnet[3].id
  
}