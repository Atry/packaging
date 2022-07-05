terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3.1"
    }
  }
  backend "s3" {
    region         = "us-west-2"
    bucket         = "hhvm-packging-terraform-state"
    key            = "hhvm-packging/tfstate"
    dynamodb_table = "hhvm-packging-tfstate"
  }
}
module "base-network" {
  source                                      = "cn-terraform/networking/aws"
  name_prefix                                 = "nexus-${terraform.workspace}"
  vpc_cidr_block                              = "192.168.0.0/16"
  availability_zones                          = ["us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d"]
  public_subnets_cidrs_per_availability_zone  = ["192.168.0.0/19", "192.168.32.0/19", "192.168.64.0/19", "192.168.96.0/19"]
  private_subnets_cidrs_per_availability_zone = ["192.168.128.0/19", "192.168.160.0/19", "192.168.192.0/19", "192.168.224.0/19"]
  single_nat                                  = true
}

module "nexus" {
  source              = "cn-terraform/nexus/aws"
  version             = "2.0.0"
  name_prefix         = "nexus-${terraform.workspace}"
  region              = "us-west-2"
  vpc_id              = module.base-network.vpc_id
  public_subnets_ids  = module.base-network.public_subnets_ids
  private_subnets_ids = module.base-network.private_subnets_ids
  enable_s3_logs      = false
}
