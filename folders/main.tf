# Top-level folder under an organization.
resource "google_folder" "my_folder" {
  display_name = "tf-test"
  parent       = "organizations/1234567" # your organization id
}

# subfolder
resource "google_folder" "my_sub_folder" {
  display_name = "subfolder-test"
  parent       = "folders/12346646567" # your folder id create previously
}
