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

moved {
  from = kubernetes_network_policy.network_policy_default_deny[0]
  to   = kubernetes_network_policy.default_deny_all[0]
}

resource "kubernetes_network_policy" "default_allow_all" {
  count = anytrue([
    var.network_policies.egress.default.allow_all,
    var.network_policies.ingress.default.allow_all
  ]) ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-default-allow-all"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {}
    dynamic "egress" {
      for_each = (var.network_policies.egress.default.allow_all) ? [1] : []
      content {}
    }
    dynamic "ingress" {
      for_each = (var.network_policies.ingress.default.allow_all) ? [1] : []
      content {}
    }
    egress {


    }
    policy_types = compact(
      [
        var.network_policies.egress.default.allow_all ? "Egress" : "",
        var.network_policies.ingress.default.allow_all ? "Ingress" : ""
      ]
    )
  }

  depends_on = [
    helm_release.helm_release
  ]
}

resource "kubernetes_network_policy" "default_deny_all" {
  count = anytrue([
    var.network_policies.egress.default.deny_all,
    var.network_policies.ingress.default.deny_all
  ]) ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-default-deny-all"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {
    }
    policy_types = compact(
      [
        var.network_policies.egress.default.deny_all ? "Egress" : "",
        var.network_policies.ingress.default.deny_all ? "Ingress" : ""
      ]
    )
  }

  depends_on = [
    helm_release.helm_release
  ]
}

moved {
  from = kubernetes_network_policy.network_policy_allow_namespace[0]
  to   = kubernetes_network_policy.allow_within_namespace[0]
}

resource "kubernetes_network_policy" "allow_within_namespace" {
  count = anytrue([
    var.network_policies.egress.allow.within_namespace,
    var.network_policies.ingress.allow.within_namespace
  ]) ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-allow-namespace"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {
    }

    dynamic "egress" {
      for_each = (var.network_policies.egress.allow.within_namespace) ? [1] : []
      content {
        to {
          namespace_selector {
            match_labels = {
              "kubernetes.io/metadata.name" = var.namespace.name
            }
          }
        }
      }
    }

    dynamic "ingress" {
      for_each = (var.network_policies.ingress.allow.within_namespace) ? [1] : []
      content {
        from {
          namespace_selector {
            match_labels = {
              "kubernetes.io/metadata.name" = var.namespace.name
            }
          }
        }
      }
    }

    policy_types = compact(
      [
        var.network_policies.egress.allow.within_namespace ? "Egress" : "",
        var.network_policies.ingress.allow.within_namespace ? "Ingress" : ""
      ]
    )
  }

  depends_on = [
    helm_release.helm_release
  ]
}

moved {
  from = kubernetes_network_policy.network_policy_allow_monitoring[0]
  to   = kubernetes_network_policy.allow_monitoring_namespace[0]
}

resource "kubernetes_network_policy" "allow_monitoring_namespace" {
  count = var.network_policies.ingress.allow.monitoring_namespace ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-allow-monitoring"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            "kubernetes.io/metadata.name" = "monitoring"
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }

  depends_on = [
    helm_release.helm_release
  ]
}
