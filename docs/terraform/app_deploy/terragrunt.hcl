locals {
  subconfig   = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  project_id  = local.subconfig.inputs.project_id
}

inputs = {
  project_id  = local.project_id
  doit_easily_image = "europe-west2-docker.pkg.dev/xiatech-shared-prod/xiatech-images/doit-easily:1.0"
  secret_version = "1"
  cloudrun_location = "europe-west2"
  is_codelab = false
  log_level = "info"
  audience = "marketplace-api.xiatech.io"
  ssl = true
  domain = "marketplace-api.xiatech.io"
  lb_name = "xiatechpartner-load-balancer"
  enable_logging = true
  log_sample_rate = 1
  brand_name = "Xiatech - Marketplace"
  project_number = 520245502579
  brand_support_email = "circleci-deployment@xiatech-shared-prod.iam.gserviceaccount.com"
  iap_client_display_name = "Xiatech - Marketplace"
  managed_zone_name = "xiatech-io"
  managed_zone_project = "xiatech-shared-prod"
  external_ip_name = "xiatechpartner-public-ip"
}

include {
  path = find_in_parent_folders()
}