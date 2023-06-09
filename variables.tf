variable "helm_release" {
  description = "Helm release configuration"
  type = object({
    chart         = string
    chart_version = string
    extra_values  = optional(list(string), [])
    name          = string
    repository    = string
    timeout       = optional(number, 900)
  })
}

variable "namespace" {
  description = "Namespace configuration"
  type = object({
    create = optional(bool, true)
    name   = string
  })
}

variable "network_policies" {
  default     = {}
  description = "Default network policies configuration"
  type = object({
    allow_monitoring_enabled = optional(bool, false)
    allow_namespace_enabled  = optional(bool, true)
    default_deny_enabled     = optional(bool, true)
  })
}

variable "sensitive_values" {
  default     = {}
  description = "Helm release sensitive values"
  sensitive   = true
  type        = map(string)
}

variable "values" {
  default     = ""
  description = "Helm release values"
  type        = string
}
