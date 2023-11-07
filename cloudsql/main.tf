# SQL database instance
resource "google_sql_database_instance" "main" {
  name             = "main-instance"
  database_version = "POSTGRES_15"
  region           = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}

# Create a new database
resource "google_sql_database" "database_deletion_policy" {
  name     = "my-database"
  instance = google_sql_database_instance.main.name
  #deletion_policy = "ABANDON"
}