provider "google" {
  version = "3.84.0"

  credentials = file("scrape-327418-4195e86a62d2.json")

  project = var.project_id
  region  = "europe-central2"
  zone    = "europe-central2-a"
}

provider "google-beta" {
  version = ">= 3.62"
  credentials = file("scrape-327418-4195e86a62d2.json")
  project = var.project_id
  region  = "europe-central2"
  zone    = "europe-central2-a"
}

# creating a bucket object
# resource "google_storage_bucket_object" "picture" {
#   name   = "butterfly01"
#   source = "/home/martin/Pictures/Screenshot_20200310_163103.png"
#   bucket = "sun_scrape_bucket"
# }

# This will create a bigquery dataset
# NOTE: there must be a service account with editor option available
resource "google_bigquery_dataset" "default" {
  dataset_id                  = "sun_scrape_sun_data_set_id"
  friendly_name               = "test"
  description                 = "This is a test description"
  location                    = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

# in table_id put the name of the table
resource "google_bigquery_table" "bq_table_resource" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "bar"

  time_partitioning {
    type = "DAY"
  }

  labels = {
    env = "default"
  }

  schema = <<EOF
[
  {
    "name": "permalink",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "The Permalink"
  },
  {
    "name": "state",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "State where the head office is located"
  }
]
EOF

    # the following line fixes the following error
    # Error: cannot destroy instance without setting deletion_protection=false and running `terraform apply`
    deletion_protection = false
}

# creating a vpc network
resource "google_compute_network" "vpc_network" {
  project                 = "scrape-327418"
  name                    = "sun-scrape-vpc-network"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_project_service" "vpcaccess-api" {
  project = var.project_id
  service = "vpcaccess.googleapis.com"
}


module "sun_vpc_connector" {
  source = "./modules/vpc_connector"
  project_id = var.project_id
}

module "redis_module"  {
  source = "./modules/redis_module"
}
