variable "region" {
  type    = string
  default = "us-east-1"
}

variable "vpccidr"{
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidrs"{
  type = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "azs"{
  type = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "cluster_name" {
  type = string
  description = "describe your variable"
  default = "EKS_CLOUD"
}

variable "node_group_name" {
  type = string
  default = "Node-cloud"
}

variable "eks_iam_rolename" {
  type = string
  default = "eks-cluster-cloud"
}

variable "eks_nodegroup_iam_rolename" {
  type = string
  default = "eks-node-group-cloud"
}