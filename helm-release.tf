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

  values = compact(concat(
    [var.values],
    var.helm_release.extra_values
  ))
}
