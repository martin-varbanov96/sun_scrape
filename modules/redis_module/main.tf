# main.tf
# redis  module

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

resource "google_redis_instance" "redis_instance"{
  name           = "ha-memory-cache"
  tier           = "STANDARD_HA"
  memory_size_gb = 1

  location_id             = "europe-west2-a"
  alternative_location_id = "europe-west2-b"

# │ Error: Reference to undeclared resource
# TODO: uncomment and fix this issue:
#   authorized_network = data.google_compute_network.redis-network.id

  redis_version     = "REDIS_4_0"
  display_name      = "Terraform Test Instance"
  reserved_ip_range = "192.168.0.0/29"

  labels = {
    my_key    = "my_val"
    other_key = "other_val"
  }
}