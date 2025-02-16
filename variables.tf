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

variable "domain_name" {
  description = "cloudwithsunil.xyz"
  default     = "cloudwithsunil.xyz"
}

variable "subdomain_name" {
  description = "www.cloudwithsunil.xyz"
  default     = "www.cloudwithsunil.xyz"
}

variable "certificate_arn" {
  description = "ARN of the ACM certificate for HTTPS listener"
  default     = "arn:aws:acm:ap-south-1:007903962438:certificate/cc05b44c-fd8c-4a34-ab2f-8ff966dccac4"
}

