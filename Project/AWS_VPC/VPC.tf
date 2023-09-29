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

# Create VPC

resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
}

# Create Subnet

resource "aws_subnet" "demo_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.10.1.0/24"

  tags = {
    Name = "demo_subnet"
  }
}

# Create Internet gateway

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "demo_igw"
  }
}

# Create a route table

resource "aws_route_table" "demo_rt" {
    vpc_id = aws_vpc.demo_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.demo_igw.id
    }
    tags = {
      Name = "demo_rt"
    }
}

# Associate subnet-01 with route table
resource "aws_route_table_association" "demo-rta-public-subent-1" {
    subnet_id = aws_subnet.demo_subent_01.id
    route_table_id = aws_route_table.dpw-public-rt.id
}

# Associate subnet-02 with route table
resource "aws_route_table_association" "demo-rta-public-subent-2" {
    subnet_id = aws_subnet.dpw-public_subent_02.id
    route_table_id = aws_route_table.dpw-public-rt.id
}

    module "sgs" {
      source = "../sg_eks"
      vpc_id     =     aws_vpc.dpw-vpc.id
 }

 module "eks" {
       source = "../eks"
        vpc_id     =     aws_vpc.dpw-vpc.id
        subnet_ids = [aws_subnet.dpw-public_subent_01.id,aws_subnet.dpw-public_subent_02.id]
        sg_ids = module.sgs.security_group_public
  }








