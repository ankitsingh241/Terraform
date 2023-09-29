terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA3BBTOGZRCZJNYWEE"
  secret_key = "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"
}

resource "aws_instance" "s1" {
  ami           = "ami-05afd67c4a44cc983"
  instance_type = "t2.micro"

  tags = {
    Name = "server1"
  }
}



