# Root/apex domain for the hosted zone (e.g., "example.com")
variable "domain_name" {
  type    = string
  default = ""
}

# Map of subdomain => list of record objects (we consume the first item)
# Using 'any' for flexibility; see comment above for expected shape.
variable "r53_records" {
  type    = any
  default = []
}

# Whether to create the hosted zone in this module
variable "create_domain" {
  type = bool
}
