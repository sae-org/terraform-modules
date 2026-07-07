variable "create_private_zone" {
  type = bool 
}

variable "domain_name" {
  type    = string
  default = ""
}

variable "vpc_ids" {
  type = list(string)
}

variable "private_records" {

  type = map(object({

    name  = string
    type  = string
    value = string
    ttl   = optional(number)

  }))
}

variable "private_zone_id" {
  type = string
}