variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnet1_id" {
  description = "The ID of subnet 1"
  type        = string
}

variable "subnet2_id" {
  description = "The ID of subnet 2"
  type        = string
}

variable "alb_sg_id" {
  description = "The ID of the ALB security group"
  type        = string
}

variable "certificate_arn" {
  description = "The ARN of the ACM certificate for HTTPS listener"
  type        = string
}
variable "instance_id" {
  description = "The ID of the EC2 instance"
  type        = string
}
