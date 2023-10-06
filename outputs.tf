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

output "namespace" {
  description = "The namespace"
  value       = var.namespace.name
}

output "version" {
  description = "Application version"
  value       = helm_release.helm_release.metadata.0.app_version
}
