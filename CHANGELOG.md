# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-configure-file { "MD024": { "allow_different_nesting": true } } -->

## [Unreleased]

### Added

- Added recommanded VSCode extentions
- Added some VSCode tasks

## [0.4.1] 2022-12-21

### Fixed

- Added missing Description and Usage section in README file
- Added missing .gitignore file

## [0.4.0] 2022-12-01

### Changed

- The input variable `helm_release.extra_values` is now a list of string instead of a string

## [0.3.0] 2022-12-01

### Added

- Add variable input for sensitive values

## [0.2.0] 2022-11-18

### Added

- Add an input variable to enable each Network Policy one by one

### Changed

- Let Helm create the namespace instead of a direct creation by Kubernetes
- Use `kubernetes.io/metadata.name` label instead of `name` to match namespace in Network Policies

### Removed

- Remove input variable `labels_prefix`

## [0.1.2] 2022-11-09

### Added

- Add `values` input variable to pass values to Helm release

### Fixed

- Fix missing interpretation of the values in the Helm chart

## [0.1.1] 2022-11-03

### Added

- Ouptut of the application version

## [0.1.0] 2022-11-01

### Added

- Terraform module creation

[Unreleased]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.4.1...develop
[0.4.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.4.0...v0.4.1
[0.4.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.3.0...v0.4.0
[0.3.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.2.0...v0.3.0
[0.2.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.1.2...v0.2.0
[0.1.2]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.1.1...v0.1.2
[0.1.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/compare/v0.1.0...v0.1.1
[0.1.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/generic/-/tags/v0.1.0
