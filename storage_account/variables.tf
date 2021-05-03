variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "account_kind" {
  type    = string
  default = "StorageV2"
}

variable "account_tier" {
  type = string
}

variable "account_replication_type" {
  type = string
}

variable "blob_properties_delete_retention_policy_days" {
  type        = number
  description = "Enable soft delete policy and specify the number of days that the blob should be retained"
  default     = null
}

variable "min_tls_version" {
  type    = string
  default = "TLS1_2"
}

variable "enable_https_traffic_only" {
  type    = bool
  default = true
}

# Note: If specifying network_rules, one of either ip_rules or virtual_network_subnet_ids must be specified
# and default_action must be set to Deny.

variable "network_rules" {
  type = object({
    default_action             = string # Valid option Deny Allow
    bypass                     = set(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
}

variable "enable_versioning" {
  type        = bool
  description = "Enable versioning in the blob storage account."
  default     = false
}

variable "lock" {
  type = object({
    name       = string
    lock_level = string
    notes      = string
  })
  default = null
}

variable "advanced_threat_protection" {
  type    = string
  default = false
}
