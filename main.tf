module "folders" {
  source = "./folders"
}

module "projects" {
  source = "./projects"
  project_name = "exp-prj-dev-001"
}

module "compute" {
  source = "./compute"
}

module "network" {
  source = "./network"
}

module "cloudsql" {
  source = "./cloudsql"
}