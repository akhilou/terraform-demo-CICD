variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "subnet_cidr1" {
  default = "10.0.1.0/24"
}

variable "subnet_cidr2" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami" {
  default = "ami-00bb6a80f01f03502"
}

