output "namespace" {
  description = "The namespace"
  value       = helm_release.helm_release.metadata.0.namespace
}

output "version" {
  description = "Application version"
  value       = helm_release.helm_release.metadata.0.app_version
}
