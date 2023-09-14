resource "kubernetes_network_policy" "network_policy_default_deny" {
  count = var.network_policies.default_deny_enabled ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-default-deny"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {
    }
    policy_types = ["Ingress"]
  }

  depends_on = [
    helm_release.helm_release
  ]
}

resource "kubernetes_network_policy" "network_policy_allow_namespace" {
  count = var.network_policies.allow_namespace_enabled ? 1 : 0

  metadata {
    name      = "${var.namespace.name}-allow-namespace"
    namespace = var.namespace.name
  }

  spec {
    pod_selector {
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            "kubernetes.io/metadata.name" = var.namespace.name
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

resource "kubernetes_network_policy" "network_policy_allow_monitoring" {
  count = var.network_policies.allow_monitoring_enabled ? 1 : 0

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
