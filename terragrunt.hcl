locals {
  region = get_env("REGION")
  project_id = get_env("GCP_PROJECT_ID")
}

inputs = {
  region      = local.region
  project_id  = local.project_id
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
    provider "google" {
      region  = "${local.region}"
      project = "${local.project_id}"
    }
    provider "google" {
      alias   = "xiatech-shared-prod"
      region  = "eu-west-2"
      project = "xiatech-shared-prod"
    }
  EOF
}

remote_state {
  backend = "gcs"
  config = {
    project  = "xiatech-shared-prod"
    bucket   = "xiatech-global-terraform-state"
    prefix   = "terraform/${local.project_id}/terraform.tfstate"
    location = "europe-west2"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

terraform {
  before_hook "before_hook" {
    commands = ["apply", "plan"]
    execute  = ["echo", "-e", "\\033[0;34mRunning Terraform on ${path_relative_to_include()} \\033[0m"]
  }
  after_hook "after_hook" {
    commands     = ["apply", "plan"]
    execute      = ["echo", "-e", "\\033[0;34mFinished Terraform for ${path_relative_to_include()}\\033[0m"]
    run_on_error = true
  }
  extra_arguments "init-backend" {
    commands = [
      "init"
    ]
    arguments = [
      "-input=false",
      "-reconfigure"
    ]
  }
  extra_arguments "plan" {
    commands = [
      "plan"
    ]
    arguments = [
      "-input=false"
    ]
  }
  extra_arguments "apply" {
    commands = [
      "apply",
      "destroy"
    ]
    arguments = [
      "-auto-approve",
      "-input=false"
    ]
  }
}