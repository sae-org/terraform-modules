variable "oidc_url" {
  description = "URL of the OIDC provider"
  type        = string      
}

variable "client_id_list" {
  description = "List of client IDs (audiences) for the OIDC provider"
  type        = list(string)    
}