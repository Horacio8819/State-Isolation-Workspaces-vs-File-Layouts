data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "horacio-dfho-terraform-state-2026"
    key    = "environments/dev/terraform.tfstate"
    region = "eu-central-1"
  }
}
resource "aws_instance" "web" {
  subnet_id = data.terraform_remote_state.network.outputs.subnet_id
}
