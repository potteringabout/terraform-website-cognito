module "website" {
  source             = "./modules/website"

  providers = {
    aws = aws.us-east-1
  }
}