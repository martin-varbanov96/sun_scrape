terraform {
  required_providers {
    google = {
      version = ">= 3.62"
    }
    google-beta = {
      version = ">= 3.87"
    }
    null = {
      version = ">= 2.1.0"
    }
  }
}

# [START vpc_serverless_connector_enable_api]
# TODO: the following error comes as the api is already enabled but it can be disabled
# because it has been disabled in the past 30 days
# │ Error: Error creating Connector: googleapi: Error 409: Requested entity already exists
# │ 
# │   with module.sun_vpc_connector.module.serverless-connector.google_vpc_access_connector.connector_beta["central-serverless"],
# │   on .terraform/modules/sun_vpc_connector.serverless-connector/modules/vpc-serverless-connector-beta/main.tf line 19, in resource "google_vpc_access_connector" "connector_beta":
# │   19: resource "google_vpc_access_connector" "connector_beta" {
# │ 
# ╵
resource "google_project_service" "vpcaccess-api" {
  project = var.project_id # Replace this with your project ID in quotes
  service = "vpcaccess.googleapis.com"
}
# [END vpc_serverless_connector_enable_api]

# [START vpc_serverless_connector]
module "test-vpc-module" {
  source       = "terraform-google-modules/network/google"
  version      = "~> 3.3.0"
  project_id   = var.project_id # Replace this with your project ID in quotes
  network_name = "sun-serverless-network"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "serverless-subnet"
      subnet_ip     = "10.10.10.0/28"
      subnet_region = "europe-west2"
    }
  ]
}

# module "serverless-connector" {
#   source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
#   project_id = var.project_id
#   vpc_connectors = [{
#     name        = "central-serverles"
#     region      = "europe-west2"
#     subnet_name = module.test-vpc-module.subnets["europe-west2/serverless-subnet"].name
#     host_project_id = var.project_id # Specify a host_project_id for shared VPC

#     # type should be in Possible values are: [f1-micro, e2-micro, e2-standard-4]
#     machine_type  = "f1-micro"
    
#     min_instances = 2
#     max_instances = 7
#     }
#     # Uncomment to specify an ip_cidr_range
#     #   , {
#     #     name          = "central-serverless2"
#     #     region        = "us-central1"
#     #     network       = module.test-vpc-module.network_name
#     #     ip_cidr_range = "10.10.11.0/28"
#     #     subnet_name   = null
#     #     machine_type  = "e2-standard-4"
#     #     min_instances = 2
#     #   max_instances = 7 }
#   ]
#   depends_on = [
#     google_project_service.vpcaccess-api
#   ]
# }
# [END vpc_serverless_connector]

# gcloud compute networks vpc-access connectors create gcloud-connector \
# --region europe-west2 \
# --subnet serverless-subnet \
# # If you are not using Shared VPC, omit the following line.
# --subnet-project scrape-327418 \
# # Optional: specify minimum and maximum instance values between 2 and 10, default is 2 min, 10 max.
# --min-instances 2 \
# --max-instances 7 \
# # Optional: specify machine type, default is e2-micro
# --machine-type f1-micro

module "serverless-connector" {
  source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  project_id = var.project_id
  vpc_connectors = [{
    name        = "central-serverless"
    region      = "europe-west2"
    subnet_name = module.test-vpc-module.subnets["europe-west2/serverless-subnet"].name
    # host_project_id = var.host_project_id # Specify a host_project_id for shared VPC
    machine_type  = "f1-micro"
    min_instances = 2
    max_instances = 7
    }
    # Uncomment to specify an ip_cidr_range
    #   , {
    #     name          = "central-serverless2"
    #     region        = "us-central1"
    #     network       = module.test-vpc-module.network_name
    #     ip_cidr_range = "10.10.11.0/28"
    #     subnet_name   = null
    #     machine_type  = "e2-standard-4"
    #     min_instances = 2
    #   max_instances = 7 }
  ]
  depends_on = [
    google_project_service.vpcaccess-api
  ]
}


