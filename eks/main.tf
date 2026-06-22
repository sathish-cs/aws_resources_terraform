module "eks" {
  source                  = "./modules/eks"
  cluster_name            = var.cluster_name
  cluster_version         = var.cluster_version
  cluster_type            = var.cluster_type
  subnet_ids              = var.subnet_ids
  tags                    = var.tags
  node_groups             = var.node_groups
  cluster_admins          = var.cluster_admins
  endpoint_private_access = var.endpoint_private_access
}