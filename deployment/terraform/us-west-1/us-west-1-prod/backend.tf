terraform {
  backend "s3" {
    bucket = "taskmaster-prod-state-bucket"  # Replace with your bucket name
    key    = "state/terraform.tfstate"
    region = "us-west-1"
    encrypt = true
  }
}
