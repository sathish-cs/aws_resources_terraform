resource "aws_eks_cluster" "eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_role.arn
  version  = var.cluster_version
  tags     = var.tags
  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access # Pass true to private only cluster
    endpoint_public_access = (
      var.cluster_type == "public"
    )
  }
  access_config {
    authentication_mode                         = "API" # disable providing  admin access for the user/role who deploy eks
    bootstrap_cluster_creator_admin_permissions = false
  }
  depends_on = [
    aws_iam_role_policy_attachment.cluster
  ]
}

resource "aws_eks_node_group" "nodegroup" {
  for_each        = var.node_groups
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = each.key
  node_role_arn   = aws_iam_role.node_role.arn
  subnet_ids      = var.subnet_ids
  instance_types  = each.value.instance_types
  capacity_type   = each.value.capacity_type
  disk_size       = each.value.disk_size
  labels          = each.value.labels
  scaling_config {
    desired_size = each.value.desired_size
    min_size     = each.value.min_size
    max_size     = each.value.max_size
  }
  depends_on = [
    aws_iam_role_policy_attachment.worker,
    aws_iam_role_policy_attachment.cni,
    aws_iam_role_policy_attachment.ecr
  ]
}

# Below resource is used to give admin access to the User/Group passed through var.cluster_admins

resource "aws_eks_access_entry" "admin" {
  for_each      = toset(var.cluster_admins)
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = each.value
  type          = "STANDARD"
}
resource "aws_eks_access_policy_association" "admin" {
  for_each      = toset(var.cluster_admins)
  cluster_name  = aws_eks_cluster.eks.name
  principal_arn = each.value
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  access_scope {
    type = "cluster"
  }
}

resource "aws_eks_addon" "addons" {
  for_each = toset([
    "vpc-cni",
    "coredns",
    "kube-proxy",
    "eks-pod-identity-agent"
  ])
  cluster_name                = aws_eks_cluster.eks.name
  addon_name                  = each.value
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
  depends_on = [
    aws_eks_cluster.eks
  ]
}