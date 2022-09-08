terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-3"
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "elasticsearch"

  ami                    = "ami-043f1fdec42408287"
  instance_type          = "t3.micro"
  key_name               = "irfan@macpro"
  monitoring             = true
  vpc_security_group_ids = ["sg-05181b0765c3b2e0f"]
  subnet_id              = "subnet-02f78ef1484b5cd42"
  user_data              = "${file("userdata.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "test"
  }
}

