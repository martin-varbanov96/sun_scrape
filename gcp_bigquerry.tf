# provider "google" {
#   version = "3.84.0"

#   credentials = file("/home/martin/Documents/certificates/gcp/scrape-327418-5be6e7d177e2.json")

#   project = "scrape-327418"
#   region  = "europe-central2"
#   zone    = "europe-central2-a"
# }

# resource "google_bigquery_dataset" "default" {
#   dataset_id                  = "sun_scrape_sun_data_set_id"
#   friendly_name               = "test"
#   description                 = "This is a test description"
#   location                    = "EU"
#   default_table_expiration_ms = 3600000

#   labels = {
#     env = "default"
#   }
# }