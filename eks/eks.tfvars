cluster_name    = "test-eks"
cluster_version = "1.32"
region          = "us-east-1"
cluster_type    = "private" # private/public
subnet_ids = [              # provide existing subnet ids
  "subnet-123",
  "subnet-321"
]
cluster_admins = [ # user.group arn to provide admin access to eks cluster
  "arn:aws:iam::accountid:user/cloud",
  "arn:aws:iam::accountid:user/devops"
]
tags = {
  Application = "EKS"
  Environment = "SBX"
}
node_groups = {
  system = { # System group is to run the control plane nodes
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 3
    min_size       = 3
    max_size       = 5
    disk_size      = 30
    labels = {
      workload = "system"
    }
  }
  apps = { # this node group is used to run the applications. 
    instance_types = ["m5.large"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 5
    min_size       = 5
    max_size       = 10
    disk_size      = 50
    labels = {
      workload = "apps"
    }
  }
}