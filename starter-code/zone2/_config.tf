terraform {
   backend "s3" {
     bucket = "udacity-tf-tobb-west1"
     key    = "terraform/terraform.tfstate"
     region = "us-west-1"
   }
 }

 provider "aws" {
   region = "us-west-1"
   #profile = "default"
   
   default_tags {
     tags = local.tags
   }
 }
