terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {   // TODO move to higher layer?
  credentials = file("~/.gc/cloud-computing-pre-5df7ea9a7c2c.json")

  project = "qrcode-374515"
  region  = "europe-west3"
  zone    = "europe-west3-a"
}

resource "google_storage_bucket" "static-site" {
  name          = "qrcode-tenant-logo"
  location      = "europe-west3"
  storage_class = "REGIONAL"
  force_destroy = true
}
