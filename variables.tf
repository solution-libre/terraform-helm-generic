variable "helm_release" {
  description = "Helm release customization"
  type = object({
    extra_values  = optional(list(string), [])
    name          = string
    chart         = string
    chart_version = string
    repository    = string
    timeout       = optional(number, 900)
  })
}

variable "namespace" {
  description = "Namespace customization"
  type = object({
    create = optional(bool, true)
    name   = string
  })
}

variable "network_policies" {
  default     = {}
  description = "Default network policies customization"
  type = object({
    allow_namespace_enabled  = optional(bool, true)
    allow_monitoring_enabled = optional(bool, false)
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
