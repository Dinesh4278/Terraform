#Creating a EC2 instance in the VPC Subnet which is configured in the main1.tf 
resource "aws_instance" "Dev" {
  ami = var.ami
  key_name = var.keyPair
  subnet_id = aws_subnet.Dev.id
  instance_type = var.instance
  tags = {
    Name = "Developer Server"
  }
}