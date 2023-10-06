/**
 * Copyright (C) 2023 Solution Libre <contact@solution-libre.fr>
 * 
 * This file is part of Helm release generic Terraform module.
 * 
 * Helm release generic Terraform module is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Helm release generic Terraform module is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Helm release generic Terraform module.  If not, see <https://www.gnu.org/licenses/>.
 */

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
    egress = optional(object({
      allow = optional(object({
        within_namespace = optional(bool, false) # Allow egress traffic within the namespace
      }), {})
      default = optional(object({
        allow_all = optional(bool, false) # By default, allow all egress traffic
        deny_all  = optional(bool, false) # By default, deny all egress traffic
      }), {})
    }), {})
    ingress = optional(object({
      allow = optional(object({
        monitoring_namespace = optional(bool, false) # Allow ingress traffic from the namespace named monitoring
        within_namespace     = optional(bool, false) # Allow ingress traffic within the namespace
      }), {})
      default = optional(object({
        allow_all = optional(bool, false) # By default, allow all ingress traffic
        deny_all  = optional(bool, false) # By default, deny all ingress traffic
      }), {})
    }), {})
  })

  validation {
    condition     = !alltrue([var.network_policies.egress.default.allow_all, var.network_policies.egress.default.deny_all])
    error_message = "Both `egress.default.allow_all` and `egress.default.deny_all` are set to true (but are exclusive)."
  }

  validation {
    condition     = !alltrue([var.network_policies.ingress.default.allow_all, var.network_policies.ingress.default.deny_all])
    error_message = "Both `ingress.default.allow_all` and `ingress.default.deny_all` are set to true (but are exclusive)."
  }
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
