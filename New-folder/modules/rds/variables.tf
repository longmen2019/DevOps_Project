variable "rds_vpc" {
    type = string
    default = "vpc-0d8b767df82cd9236"
  
}

variable "ec2_sg" {
    type = string
      
}

variable "subnet_ids" {
    type = list(string)
    default = [ "subnet-0c8063ff80bcde276", "subnet-0538c5db88a6be5bd" ]
      
}

variable "allocated_storage" {
    type = number
      
}

variable "db_name" {
    type = string
  
}

variable "engine" {
    type = string
  
}

variable "engine_version" {
    type = string
  
}

variable "instance_class" {
    type = string
  
}

variable "username" {
    type = string
  
}

variable "password" {
    type = string
  
}

