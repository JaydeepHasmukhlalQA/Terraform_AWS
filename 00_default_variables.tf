variable "instance" {
  default = "t2.micro"
}

variable "mongo_script" {
  default = ["scripts/mongo.sh"]
}

variable "api_script" {
  default = ["scripts/api.sh"]
}
