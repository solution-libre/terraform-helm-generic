locals {
  namespace = (var.namespace.create) ? kubernetes_namespace.namespace.*.metadata.0.name[0] : var.namespace.name
}

resource "kubernetes_namespace" "namespace" {
  count = var.namespace.create ? 1 : 0

  metadata {
    labels = {
      name                             = var.namespace.name
      "${var.labels_prefix}/component" = "ingress"
    }

    name = var.namespace.name
  }
}

resource "helm_release" "helm_release" {
  repository = var.helm_release.repository
  name       = var.helm_release.name
  chart      = var.helm_release.chart
  timeout    = var.helm_release.timeout
  version    = var.helm_release.chart_version

  values = compact([
    var.values,
    var.helm_release.extra_values,
  ])
  namespace = var.namespace.name
}

resource "kubernetes_network_policy" "network_policy_default_deny" {
  count = var.network_policy.enabled ? 1 : 0

  metadata {
    name      = "${local.namespace}-default-deny"
    namespace = local.namespace
  }

  spec {
    pod_selector {
    }
    policy_types = ["Ingress"]
  }
}

resource "kubernetes_network_policy" "network_policy_allow_namespace" {
  count = var.network_policy.enabled ? 1 : 0

  metadata {
    name      = "${local.namespace}-allow-namespace"
    namespace = local.namespace
  }

  spec {
    pod_selector {
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            name = local.namespace
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}

resource "kubernetes_network_policy" "network_policy_allow_monitoring" {
  count = var.network_policy.enabled ? 1 : 0

  metadata {
    name      = "${local.namespace}-allow-monitoring"
    namespace = local.namespace
  }

  spec {
    pod_selector {
    }

    ingress {
      from {
        namespace_selector {
          match_labels = {
            "${var.labels_prefix}/component" = "monitoring"
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}
