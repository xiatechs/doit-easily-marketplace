locals {
  subconfig   = read_terragrunt_config(find_in_parent_folders("terragrunt.hcl"))
  project_id = local.subconfig.inputs.project_id
}

inputs = {
  project_id  = local.project_id
}

include {
  path = find_in_parent_folders()
}