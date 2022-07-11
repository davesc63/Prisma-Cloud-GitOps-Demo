module "eks" {
  # source          = "terraform-aws-modules/eks/aws"
  source = "github.com/davesc63/terraform-aws-eks"
  # version         = "18.23.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.22"
  subnet_ids      = module.vpc.private_subnets

  vpc_id = module.vpc.vpc_id

  #   self_managed_node_group_defaults = {
  #     root_volume_type = "gp2"
  #   }

  #   self_managed_node_groups = {
  #     worker_group = {
  #       name                          = "node-group-1"
  #       instance_type                 = "t2.micro"
  #       additional_userdata           = "echo foo bar"
  #       additional_security_group_ids = [aws_security_group.node_group_mgmt_one.id]
  #       min_size                      = 1
  #       max_size                      = 5
  #       desired_size                  = 2
  #       bootstrap_extra_args          = "--kubelet-extra-args '--node-labels=node.kubernetes.io/lifecycle=spot'"

  #       block_device_mappings = {
  #         xvda = {
  #           device_name = "/dev/xvda"
  #           ebs = {
  #             delete_on_termination = true
  #             encrypted             = false
  #             volume_size           = 100
  #             volume_type           = "gp2"
  #           }
  #         }
  #   } } }





  eks_managed_node_groups = {
    node_group = {
      name         = "gitops"
      min_size     = 1
      max_size     = 5
      desired_size = 1

      #capacity_type  = "SPOT"
      ami_type       = "AL2_ARM_64"
      instance_types = ["t4g.small"]
      # X86 config: t2.micro / AL2_x86_64
      # ARM64 config: t4g.small / AL2_ARM_64


      update_config = {
        max_unavailable_percentage = 50
      }

      labels = {
        Environment = "test"
        GithubRepo  = "Prisma-Cloud-GitOps-Demo"
      }

      #   taints = [
      #     {
      #       key    = "dedicated"
      #       value  = "dvwa"
      #       effect = "NO_SCHEDULE"
      #     }
      #   ]








      #   tags = {
      #     ExtraTag = "example"
      #   }
    }
  }



}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}


# module "eks_example_self_managed_node_group" {
#   source  = "terraform-aws-modules/eks/aws//examples/self_managed_node_group"
#   version = "18.23.0"
# }

