variable "region" {
#  type = string
}

variable "cluster_name" {
#  type = string
#  description = "describe your variable"
#  default = "EKS_CLOUD"
}

variable "subnet_ids" {
#  type = string
#  description = "describe your variable"
#  default = module.vpc.subnet_id
}

variable "node_group_name" {
#  type = string
#  default = "Node-cloud"
}

variable "eks_iam_rolename" {
#  type = string
#  default = "eks-cluster-cloud"
}

variable "eks_nodegroup_iam_rolename" {
#  type = string
#  default = "eks-node-group-cloud"
}