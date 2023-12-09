
module "project_alb" {
   source             = "./modules/alb"
   ec2                = module.project_ec2.aws_instance
   ec2_sg             = module.project_ec2.ec2_sg
   subnet_id          = data.terraform_remote_state.vpc.outputs.public_subnet_ids
   vpc_id             = data.terraform_remote_state.vpc.outputs.vpc_id
 }
