output "namespace" {
  description = "The namespace"
  value       = local.namespace
}

output "app_version" {
  description = "Application version"
  value       = helm_release.helm_release.metadata.0.app_version
}