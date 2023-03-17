
######

# Only need to uncomment the s3 module if running for the first time to create the s3 bucket to store the state file. Also only needed if you want to create the bucket in the same terraform file as the one the creates instance resources. 

# module "test_s3_statefile_storage" {
#   source = "./modules/s3_statefile_storage"
#   namespace = var.namespace
#   aws_region = var.aws_region
# }

######

module "test_networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

module "test_ssh-key" {
  source    = "./modules/ssh-key"
  namespace = var.namespace
}

module "test_ec2" {
  count = 3
  source     = "./modules/ec2"
  namespace  = var.namespace
  aws_instance_type = var.aws_instance_type
  aws_ami_type = var.aws_ami_type
  enviornment_tag = var.enviornment_tag
  vpc        = module.test_networking.vpc
  sg_pub_id  = module.test_networking.sg_pub_id
  sg_priv_id = module.test_networking.sg_priv_id
  key_name   = module.test_ssh-key.key_name
  instance_name = "TEST-${count.index + 1}"

}

module "test_ec2_ansible" {
  # count = 1
  source     = "./modules/ec2_ansible"
  namespace  = var.namespace
  aws_instance_type = var.aws_instance_type
  aws_ami_type = var.aws_ami_type
  enviornment_tag = var.enviornment_tag
  vpc        = module.test_networking.vpc
  sg_pub_id  = module.test_networking.sg_pub_id
  sg_priv_id = module.test_networking.sg_priv_id
  key_name   = module.test_ssh-key.key_name
  instance_name = "TEST-1"

}