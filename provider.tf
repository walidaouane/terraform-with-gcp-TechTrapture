provider "google" {
  credentials = file("key.json")
  project     = "exp-prj-dev-001"
}