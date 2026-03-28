provider "aws" {
  region = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket = "horacio-dfho-terraform-state-2026"
    key    = "challenge-d7/terraform.tfstate"
    region = "eu-central-1"
  }
}

variable "instance_type" {
  description = "EC2 instance type per environment"
  type        = map(string)
  default = {
    dev        = "t3.micro"
    staging    = "t3.small"
    production = "t3.small"
  }
}

resource "aws_instance" "web" {
  ami           = "ami-0cf4768e2f1e520c5"
  instance_type = var.instance_type[terraform.workspace]

  tags = {
    Name        = "web-${terraform.workspace}"
    Environment = terraform.workspace
  }
}