provider "google-beta" {
  project = var.project_id
}

data "google_service_account" "doit-easily" {
  account_id = "doit-easily"
  project = var.project_id
}

#get an access token for the doit-easily SA
data "google_service_account_access_token" "prod_token" {
  # target_service_account = local.service_account_email
  target_service_account = data.google_service_account.doit-easily.email
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "1200s"
}

#this provider is used to apply resources as the doit-easily SA
provider "google" {
  alias        = "prod_impersonation"
  access_token = data.google_service_account_access_token.prod_token.access_token
}