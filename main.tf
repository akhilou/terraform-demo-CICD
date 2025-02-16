provider "aws" {
  region = "ap-south-1"
}

terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-sunil7756"
    key    = "terraform/terraform.tfstate"
    region = "ap-south-1"
  }
}

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

module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
}

module "subnets" {
  source          = "./modules/subnets"
  vpc_id          = module.vpc.vpc_id
  route_table_id  = module.vpc.route_table_id
  subnet_cidr1    = var.subnet_cidr1
  subnet_cidr2    = var.subnet_cidr2
  availability_zone1 = "ap-south-1a"
  availability_zone2 = "ap-south-1b"
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source        = "./modules/ec2"
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = module.subnets.subnet1_id
  web_sg_id     = module.security_groups.web_sg_id
}

module "alb" {
  source          = "./modules/alb"
  vpc_id          = module.vpc.vpc_id
  subnet1_id      = module.subnets.subnet1_id
  subnet2_id      = module.subnets.subnet2_id
  alb_sg_id       = module.security_groups.web_sg_id
  certificate_arn = var.certificate_arn
}

module "route53" {
  source          = "./modules/route53"
  domain_name     = var.domain_name
  subdomain_name  = var.subdomain_name
  alb_dns_name    = module.alb.alb_dns_name
  alb_zone_id     = data.aws_route53_zone.main.zone_id
}
