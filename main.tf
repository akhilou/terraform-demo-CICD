provider "aws" {
  region = "ap-south-1"
}
terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-${random_string.unique.result}"  # Same as the created bucket
    key    = "terraform-state-file/terraform.tfstate"  # Specify the state file location
    region = "us-west-2"
  }
}

module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = var.vpc_cidr
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  route_table_id      = module.vpc.route_table_id
  subnet_cidr1        = var.subnet_cidr1
  subnet_cidr2        = var.subnet_cidr2
  availability_zone1  = "ap-south-1a"
  availability_zone2  = "ap-south-1b"
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
  instance_id     = module.ec2.instance_id
}
