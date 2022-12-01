resource "helm_release" "helm_release" {
  name       = var.helm_release.name
  chart      = var.helm_release.chart
  repository = var.helm_release.repository
  timeout    = var.helm_release.timeout
  version    = var.helm_release.chart_version

  create_namespace = var.namespace.create
  namespace        = var.namespace.name

  dynamic "set_sensitive" {
    for_each = nonsensitive(var.sensitive_values)
    content {
      name  = set_sensitive.key
      value = set_sensitive.value
    }
  }

  values = compact([
    var.values,
    var.helm_release.extra_values
  ])
}
