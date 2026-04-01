variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "ap-southeast-1"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "ami_id" {
  type    = string
  default = "ami-05c64f7b4062b0a21"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "EC2_USER" {
  type    = string
  default = "ec2-user"
}

variable "PUBLIC_KEY_PATH" {
  type    = string
  default = "../ap_southeast_1_key_pair.pub"
}

variable "PRIVATE_KEY_PATH" {
  type    = string
  default = "../ap_southeast_1_key_pair"
}

variable "availability_zones" {
  type    = list(string)
  default = ["ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1c"]
}

variable "volume_size" {
  type = number
}

variable "db_name" {
  type    = string
  default = "db"
}

variable "db_username" {
  type    = string
  default = "admin"
}

variable "db_engine" {}

variable "db_engine_version" {}

variable "db_storage_size" {}
