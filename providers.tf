terraform {
  backend "s3" {
    bucket = "gov-terraform"
    key    = "tfstate"
    region = "ap-southeast-2"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.17.1"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.2.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.2.3"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.11.0"
    }
  }

  required_version = ">= 0.14"
}
