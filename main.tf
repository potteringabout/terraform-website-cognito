module "website" {
  source             = "./modules/website"

  providers = {
    aws = aws
    aws.us-east-1 = aws.us_east_1
  }
}