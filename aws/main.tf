provider "aws" {
  region = "us-east-1" 
  #access_key = "your_access_key"
  #secret_key = "your_secret_key"
}

resource "aws_budgets_budget" "entire_account" {
    name    = "budget-account-monthly"
    budget_type       = "COST"
    limit_amount      = "10.00"
    limit_unit        = "USD"
    time_period_end   = "2087-06-15_00:00"
    time_period_start = "2024-02-01_00:00"
    time_unit         = "MONTHLY"


  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["sporter.itpro@gmail.com"]
  }
}

resource "godaddy_domain_record" "sporter-info" {
    domain = "sporter.info"
    record {
        name = "www"
        type = "CNAME"
        data = "main.d3i6jv5757vx1b.amplifyapp.com"
    }
}

resource "aws_eks_cluster" "eks-cluster" {
  name     = "sporter-eks-cluster"
  role_arn = "arn:aws:iam::764000881841:role/sporter-eks-role"

  vpc_config {
    subnet_ids = ["subnet-0afc5cb91bfb18d6f", "subnet-0ffba1c7c2c9c8a18"]
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }  
}

resource "aws_iam_role" "eks-node-group-role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "sporter-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "sporter-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks-node-group-role.name
}

resource "aws_iam_role_policy_attachment" "sporter-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks-node-group-role.name
}



resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "sporter-node-group"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn
  subnet_ids      = ["subnet-0afc5cb91bfb18d6f", "subnet-0ffba1c7c2c9c8a18"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.sporter-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.sporter-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.sporter-AmazonEC2ContainerRegistryReadOnly,
    aws_eks_cluster.eks-cluster,
  ]
}


output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}