module "efs" {
  source = "../../"

  environment = var.environment
  project     = var.project

  subnet_ids = module.vpc.private_subnets
  vpc_id     = module.vpc.vpc_id

  transition_to_ia = "AFTER_7_DAYS"

  tags = {
    Project = "test"
  }
}

