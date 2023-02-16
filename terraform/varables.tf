variable "location" {
  description = "The Azure Region where the Resources should exist"
  default     = "Australia East"
}

variable "healthchecksio_api_key" {
  description = "API Key. To keep secrets out of code first set environment variable TF_VAR_healthchecksio_api_key"
  sensitive   = true
}

variable "white_list_ip" {
  description = "IP Address to whitelist for access to the storage account"
}