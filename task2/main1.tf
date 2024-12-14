//Creation of VPC, Subnet, Internet Gateway, Route Table, Security Table

#Creation of VPC
resource "aws_vpc" "Dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Dev VPC"
  }
}

#Creation of Internet Gateway and attach to VPC
resource "aws_internet_gateway" "Dev" {
  vpc_id = aws_vpc.Dev.id
  tags = {
    Name = "Internet Gateway"
  }
}

#Creation of subnet
resource "aws_subnet" "Dev"{
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.Dev.id
    map_public_ip_on_launch = true
    tags = {
      Name = "Dev1 Subnet"
    }
}  

#Creation of Route Table and provide path to IG and RT

resource "aws_route_table" "Dev" {
    vpc_id = aws_vpc.Dev.id
    tags = {
      Name = "Dev-Route Table"
    }
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Dev.id
    }
}

#Associate Route Table to Subnet
resource "aws_route_table_association" "Dev" {
  route_table_id = aws_route_table.Dev.id
  subnet_id = aws_subnet.Dev.id
}

#Creation of Security Group
resource "aws_security_group" "allow_tls" {
  name = "allow_tls"
  vpc_id = aws_vpc.Dev.id
  tags = {
    Name = "Dev_SG"
  }
  ingress {
    description = "TLS from VPC"
    from_port = 80          #Port 80 is used for network communication
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "TLS from VPC"
    from_port = 22          #Port 22 is used for SSH connection 
    to_port = 22
    protocol = "TCP"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  egress {              #egress is used for outgoing traffic
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
}