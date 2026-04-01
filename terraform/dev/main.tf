
module "app" {
  source = "../module"

  aws_access_key	= ""
  aws_secret_key	= ""
  volume_size       = "16"
  db_name           = "mydb"
  db_username       = "dat"
  db_engine         = "postgres"
  db_engine_version = "11.5"
  db_storage_size   = 20

}
