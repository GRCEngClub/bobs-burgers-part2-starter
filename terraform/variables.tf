variable "region" {
  type    = string
  default = "us-east-1"
}

variable "bucket_name" {
  description = "Globally unique bucket name. Pick your own."
  type        = string
}

variable "sync_user_name" {
  type    = string
  default = "gene-sync"
}
