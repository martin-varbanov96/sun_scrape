terraform {
  required_providers {
    google = {
      version = ">= 3.62"
    }
    google-beta = {
      version = ">= 3.62"
    }
    null = {
      version = ">= 2.1.0"
    }
  }
}

# [START vpc_serverless_connector_enable_api]
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
  network_name = "my-serverless-network"
  mtu          = 1460

  subnets = [
    {
      subnet_name   = "serverless-subnet"
      subnet_ip     = "10.10.10.0/28"
      subnet_region = "europe-central2"
    }
  ]
}

module "serverless-connector" {
  source     = "terraform-google-modules/network/google//modules/vpc-serverless-connector-beta"
  project_id = var.project_id
  vpc_connectors = [{
    name        = "central-serverless"
    region      = "europe-central2"
    subnet_name = module.test-vpc-module.subnets["europe-central2/serverless-subnet"].name
    # host_project_id = var.host_project_id # Specify a host_project_id for shared VPC

    # type should be in Possible values are: [f1-micro, e2-micro, e2-standard-4]
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
# [END vpc_serverless_connector]
