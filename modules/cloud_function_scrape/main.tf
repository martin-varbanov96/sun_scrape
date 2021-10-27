# main.tf
# here we create buckets and dump python code in. After that we add a cloud function

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

resource "google_storage_bucket" "bucket" {
  # name should be unique!
  name = "sun_bucket_1287391983712983"
}

resource "google_storage_bucket_object" "archive" {
  name   = "index.zip"
  bucket = google_storage_bucket.bucket.name
  source = "/home/martin/Documents/github/sun_scrape/bq_manager/insert_bq.zip"
}

#cloudfunctions:
# TODO: this colud be seperated to 2 modules 

# enable cloudfunctions api
# TODO: this doesn't seem to work. Investigate why it's not working
resource "google_project_service" "cloudfunctions-api" {
  project = var.project_id # Replace this with your project ID in quotes
  service = "cloudfunctions.googleapis.com"
}
resource "google_cloudfunctions_function" "function" {
  name        = "function-test"
  description = "My function"
  runtime     = "python38"

  available_memory_mb   = 128
  source_archive_bucket = google_storage_bucket.bucket.name
  source_archive_object = google_storage_bucket_object.archive.name
  trigger_http          = true
  entry_point           = "scrape_upload_to_bq"

  # does this work?
  depends_on = [
    google_project_service.cloudfunctions-api
  ]
}

# IAM entry for all users to invoke the function
resource "google_cloudfunctions_function_iam_binding" "invoker" {
  project        = google_cloudfunctions_function.function.project
  region         = google_cloudfunctions_function.function.region
  cloud_function = google_cloudfunctions_function.function.name

  role   = "roles/cloudfunctions.invoker"
#   the following wasn't working:
#   member = "allUsers"
  members = [
     "allUsers",
   ]
}