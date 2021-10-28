provider "google" {
  version = "3.84.0"

  credentials = file("/home/martin/Documents/certificates/gcp/static-emblem-327016-ce88b7e70600.json")

  project = var.project_id
  region  = "europe-west2"
  zone    = "europe-west2-a"
}

provider "google-beta" {
  version = ">= 3.87"
  credentials = file("/home/martin/Documents/certificates/gcp/static-emblem-327016-ce88b7e70600.json")
  project = var.project_id
  region  = "europe-west2"
  zone    = "europe-west2-a"
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
    "name": "read_count",
    "type": "INT64",
    "mode": "NULLABLE",
    "description": "Number of times the article has been read"
  },
  {
    "name": "title",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "title of the article"
  },
  {
    "name": "section",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "type of news category"
  },
  {
    "name": "article_link",
    "type": "STRING",
    "mode": "NULLABLE",
    "description": "link to article"
  }
]
EOF

    # the following line fixes the following error
    # Error: cannot destroy instance without setting deletion_protection=false and running `terraform apply`
    deletion_protection = false
}

# # creating a vpc network
# resource "google_compute_network" "vpc_network" {
#   project                 = "scrape-327418"
#   name                    = "sun-scrape-vpc-network"
#   auto_create_subnetworks = true
#   mtu                     = 1460
# }

# resource "google_project_service" "vpcaccess-api" {
#   project = var.project_id
#   service = "vpcaccess.googleapis.com"
# }


module "sun_vpc_connector" {
  source = "./modules/vpc_connector"
  project_id = var.project_id
}

module "redis_module"  {
  source = "./modules/redis_module"
}

# pubsub_topic module
module "pubsub_topic" {
  source = "./modules/pubsub_topic"
  # project_id = var.project_id
}

# bucket and cloud function
module "cloud_function_scrape" {
  source = "./modules/cloud_function_scrape"
  project_id = var.project_id
}