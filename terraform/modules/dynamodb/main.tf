module "ddb_table_clips" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "4.0.0"

  name        = "clips-${var.stage}"
  hash_key    = "user_id"
  range_key   = "clip_id"
  table_class = "STANDARD"

  attributes = [
    {
      name = "user_id"
      type = "S"
    },
    {
      name = "clip_id"
      type = "S"
    }
  ]
}