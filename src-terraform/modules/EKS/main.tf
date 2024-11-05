resource "aws_eks_cluster" "cluster_prod" {
  name     = var.eks_prod_name
  role_arn = var.eks_role_arn

  vpc_config {
    subnet_ids = var.public_subnet_ids
  }
}

resource "aws_eks_node_group" "app_nodes" {
  depends_on      = [aws_eks_cluster.cluster_prod]
  cluster_name    = aws_eks_cluster.cluster_prod.name
  node_group_name = var.eks_prod_name
  node_role_arn   = var.nodes_role_arn
  subnet_ids      = var.public_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }
}