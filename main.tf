terraform {
  required_version = ">=0.13"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.51.0, < 5.0"
    }
  }
}

module "setup" {
    source      = "./docs/terraform/setup"
    project_id  = var.project_id
}

module "app" {
    source      = "./docs/terraform/app_setup"
    project_id  = var.project_id
    depends_on  = [module.setup]
}