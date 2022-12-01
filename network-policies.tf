resource "kubernetes_network_policy" "network_policy_default_deny" {
  count = var.network_policies.default_deny_enabled ? 1 : 0

  metadata {
    name      = "${helm_release.helm_release.metadata.0.namespace}-default-deny"
    namespace = helm_release.helm_release.metadata.0.namespace
  }

  spec {
    pod_selector {
    }
    policy_types = ["Ingress"]
  }
}

resource "kubernetes_network_policy" "network_policy_allow_namespace" {
  count = var.network_policies.allow_namespace_enabled ? 1 : 0

  metadata {
    name      = "${helm_release.helm_release.metadata.0.namespace}-allow-namespace"
    namespace = helm_release.helm_release.metadata.0.namespace
  }

  spec {
    pod_selector {
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            "kubernetes.io/metadata.name" = helm_release.helm_release.metadata.0.namespace
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}

resource "kubernetes_network_policy" "network_policy_allow_monitoring" {
  count = var.network_policies.allow_monitoring_enabled ? 1 : 0

  metadata {
    name      = "${helm_release.helm_release.metadata.0.namespace}-allow-monitoring"
    namespace = helm_release.helm_release.metadata.0.namespace
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
}
