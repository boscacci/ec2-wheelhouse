variable "instance_type" {
  type    = string
  default = "g4dn.xlarge" # Try: p2.xlarge | g4dn.xlarge | g4dn.2xlarge
}

variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "instance_ami" {
  type        = string
  default     = "ami-0520de1428645c081" # IceVision with torch 1.10
  description = "Instance AMI image to use"
}

variable "spot_price" {
  type        = string
  default     = "0.75"
  description = "Maximum hourly price to pay for spot instance"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
}

variable "aws_availability_zone" {
  type    = string
  default = "us-east-2b"
}

variable "ssh_pub_path" {
  type        = string
  default     = "~/.ssh/id_rsa.pub"
  description = "Path to public key to use to login to the server"
}

variable "spot_type" {
  type        = string
  default     = "one-time"
  description = "Spot instance type; this value only applies for spot instance type."
}

variable "spot_instance" {
  type        = string
  default     = "true"
  description = "This value is true if we want to use a spot instance instead of a regular one"
}
