variable "domain_name" {
  description = "The domain name"
  type        = string
}

variable "subdomain_name" {
  description = "The subdomain name"
  type        = string
}

variable "alb_dns_name" {
  description = "The DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "The Zone ID of the ALB"
  type        = string
}

