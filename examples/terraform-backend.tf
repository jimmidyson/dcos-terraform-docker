terraform {
  backend "gcs" {
    bucket  = "my-bucket"
    prefix  = "testing/state"
    project = "my-project"
  }
}
