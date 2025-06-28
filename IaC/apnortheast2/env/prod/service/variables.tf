variable "aws_region" {
  type        = string
  description = "The AWS region"
}

variable "region_prefix" {
  type        = string
  description = "The AWS region prefix"
}

variable "assume_role_arn" {
  type        = string
  default     = ""
  description = "The ARN of the role to assume"
}

variable "atlantis_user" {
  type        = string
  default     = "atlantis_user"
  description = "The name of the Atlantis user"
}

variable "environment" {
  type        = string
  description = "The name of the VPC"
}

variable "availability_zones" {
  type        = list(string)
  description = "The availability zones for the VPC"
}

variable "cidr_numeral_private" {
  type = map(string)
  default = {
    "0" = "80"
    "1" = "96"
    "2" = "112"
  }
  description = "The VPC CIDR numeral for private subnet (10.x.0.0/16)"
}

variable "services" {
  type = map(object({
    container_name        = string
    service_name          = string
    container_port        = number
    ecs_cpu               = number
    ecs_memory            = number
    enable_alb            = bool
    family                = string
    host_port             = number
    image_uri             = string
    log_index             = string
    log_port              = number
    port_name             = string
    dns_name              = string
    discovery_name        = string
    service_desired_count = number
  }))
  description = "Defining ECS and service settings for each service except for authorization service"
}

variable "authorization_service_config" {
  type = object({
    container_name        = string
    service_name          = string
    container_port        = number
    ecs_cpu               = number
    ecs_memory            = number
    enable_alb            = bool
    family                = string
    host_port             = number
    image_uri             = string
    log_index             = string
    log_port              = number
    port_name             = string
    dns_name              = string
    discovery_name        = string
    service_desired_count = number
  })
  description = "Defining ECS and service settings for authorization service"
}