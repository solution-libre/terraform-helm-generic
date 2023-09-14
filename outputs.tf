output "namespace" {
  description = "The namespace"
  value       = var.namespace.name
}

output "version" {
  description = "Application version"
  value       = helm_release.helm_release.metadata.0.app_version
}
