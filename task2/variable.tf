variable "ami" {
  description = "Amazon-linux ami in ap-south-1"
  type = string
  default = "ami-0614680123427b75e"
}

variable "keyPair" {
    description = "Key Pair for the EC2 Instance"
    type = string
    default = "new_dinesh"
}

variable "instance" {
  description = "Instance Id for the EC2 Server"
  type = string
  default = "t2.micro"
}