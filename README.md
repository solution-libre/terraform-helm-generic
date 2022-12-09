# Helm release generic Terraform module

<!-- markdownlint-disable-next-line MD001 -->
#### Table of Contents

1. [Description](#description)
2. [Usage](#usage)
3. [Reference](#reference)
4. [Development](#development)
5. [Contributors](#contributors)

## Description

Generic [Terraform](https://www.terraform.io/) module that allows you to deploy and configure a software on
[Kubernetes](https://kubernetes.io/) via [Helm](https://helm.sh/).

## Usage

```terraform
module "generic" {
  source  = "usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/generic/helm"
  version = "0.2.0"

  helm_release = {
    chart         = "software"
    chart_version = "1.0.0"
    name          = "software"
    repository    = "https://helm.domain.tld/software"
  }

  namespace  = {
    create = true
    name   = "software"
  }

  values = templatefile(
    "${path.module}/templates/values.yaml.tpl",
    {
      name      = "software"
      namespace = "software"
    }
  )
}
```

## Reference

See [REFERENCE.md](./REFERENCE.md).

## Development

[Solution Libre](https://www.solution-libre.fr)'s repositories are open projects,
and community contributions are essential for keeping them great.

[Fork this repo on our GitLab](https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/forks/new).

## Contributors

The list of contributors can be found at: <https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/graphs/main>.
