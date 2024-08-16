resource "aws_eks_cluster" "eks-cluster" {
  name     = "sporter-eks-cluster"
  role_arn = "arn:aws:iam::764000881841:role/sporter-eks-role"

  vpc_config {
    subnet_ids = [var.subnet1-id, var.subnet1-id]
  }

  access_config {
    authentication_mode                         = "CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }  
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name    = aws_eks_cluster.eks-cluster.name
  node_group_name = "sporter-node-group"
  node_role_arn   = aws_iam_role.eks-node-group-role.arn
  subnet_ids      = [var.subnet1-id, var.subnet1-id]

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
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,    
    aws_eks_cluster.eks-cluster,
  ]
}


output "endpoint" {
  value = aws_eks_cluster.eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.eks-cluster.certificate_authority[0].data
}