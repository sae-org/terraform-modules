variable "proj_prefix" {
  description = "Prefix used when deriving a default key_name"
  type        = string
}

variable "key_name" {
  description = "Optional explicit EC2 key pair name (defaults to <proj_prefix>-key)"
  type        = string
  default     = ""
}

variable "algorithm" {
  description = "TLS key algorithm"
  type        = string
  default     = "RSA"
}

variable "rsa_bits" {
  description = "RSA key size in bits"
  type        = number
  default     = 4096
}
