cluster_name    = "test-eks"
cluster_version = "1.32"
region          = "us-east-1"
cluster_type    = "private" # private/public
subnet_ids = [              # provide existing subnet ids
  "subnet-0c1c11211",
  "subnet-ddd99431"
]
cluster_admins = [ # user.group arn to provide admin access to eks cluster
  "arn:aws:iam::aaccountid:user/cloud",
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
    desired_size   = 2
    min_size       = 2
    max_size       = 5
    disk_size      = 30
    labels = {
      workload = "system"
    }
  }
  apps = { # this node group is used to run the applications. 
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    desired_size   = 2
    min_size       = 2
    max_size       = 5
    disk_size      = 50
    labels = {
      workload = "apps"
    }
  }
}