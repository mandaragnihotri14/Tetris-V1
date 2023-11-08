
module "vpc" {
  source              = "./modules/VPC"
  region              = var.region
  vpccidr             = var.vpccidr
  public_subnet_cidrs = var.public_subnet_cidrs
  azs                 = var.azs
}

#get vpc data
#data "aws_vpc" "main" {
#  default = true
#}

#get public subnets for cluster
#data "aws_subnets" "public" {
#  filter {
#    name   = "vpc-id"
#    values = [data.aws_vpc.main.id]
#  }
#}

module "eks" {
  source = "./modules/EKS"
  region = var.region
  cluster_name = var.cluster_name
  subnet_ids = module.vpc.subnet_id
  node_group_name = var.node_group_name
  eks_iam_rolename = var.eks_iam_rolename
  eks_nodegroup_iam_rolename = var.eks_nodegroup_iam_rolename
}

