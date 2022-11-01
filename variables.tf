variable "helm_release" {
  description = "Helm release customization"
  type = object({
    extra_values  = optional(string)
    name          = string
    chart         = string
    chart_version = string
    repository    = string
    timeout       = optional(number, 900)
  })
}

variable "labels_prefix" {
  default     = "solution-libre.fr"
  description = "Custom label prefix used for network policy namespace matching"
  type        = string
}

variable "namespace" {
  description = "Namespace customization"
  type = object({
    create = optional(bool, true)
    name   = string
  })
}

variable "network_policy" {
  default = {
    enabled = true
  }
  description = "Network policy customization"
  type = object({
    enabled = optional(bool, true)
  })
}
