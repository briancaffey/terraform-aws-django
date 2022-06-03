# Changelog


## [0.9.2](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.1...v0.9.2) (2022-06-03)


### Bug Fixes

* **ecs:** fix ecs service names to all use dashes instead of underscores ([021fe6e](https://github.com/briancaffey/terraform-aws-django/commit/021fe6e46fdb3d9b2e41a974839152c66acca4a2))

## [0.9.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.0...v0.9.1) (2022-06-03)


### Bug Fixes

* **management-command:** add private subnets variable to management command module and add network configuration to output command ([3d36649](https://github.com/briancaffey/terraform-aws-django/commit/3d366495d184d4e0e6afbcef158942814511e10b))
* **vars:** remove unused tf variable ecs_cluster_name ([96914f9](https://github.com/briancaffey/terraform-aws-django/commit/96914f95b7a0a8b96edf5d740aff5d0ec0f9360e))

## [0.9.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.8.1...v0.9.0) (2022-05-26)


### Features

* **domain name:** replace zone name and record name with domain name, remove frontend_url, add postgres name env var, domain name env var ([c95ac70](https://github.com/briancaffey/terraform-aws-django/commit/c95ac704d717544cec7773f88c39ce31be30967a))

### [0.8.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.8.0...v0.8.1) (2022-05-24)


### Bug Fixes

* **fargate:** removed launch_type since capacity_provider_strategy is specified ([77eba10](https://github.com/briancaffey/terraform-aws-django/commit/77eba10eae2721602cc873293e87480f0c9c0279))

## [0.8.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.7.0...v0.8.0) (2022-05-24)


### Features

* **docs:** update readme ([ed4455c](https://github.com/briancaffey/terraform-aws-django/commit/ed4455cbca7264a1d4d5115d3a997b71af43bea5))
* **docs:** update readme with links ([8fea9ff](https://github.com/briancaffey/terraform-aws-django/commit/8fea9ffb2ce5ac1f402840b153130840a7e5cf1d))
* **fargate spot:** add capacity provider strategy for each service ([403d268](https://github.com/briancaffey/terraform-aws-django/commit/403d26863e609a27c4eddee257e4518528b5c372))
* **fargate:** use fargate launch type for management command module ([8a247e6](https://github.com/briancaffey/terraform-aws-django/commit/8a247e674d2ae002bf696fcedfa5cc5847c4a24e))

## [0.7.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.6.0...v0.7.0) (2022-05-23)


### Features

* **fargate spot:** add fargate spot capacity provider ([f3c2257](https://github.com/briancaffey/terraform-aws-django/commit/f3c2257d23ef843412e24e41224515f9d518a549))

### [0.6.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.6.0...v0.6.1) (2022-04-17)

### Bug Fixes

* **ad-hoc:** fix inputs and outputs for ad hoc environments ([fe4f5c4](https://github.com/briancaffey/terraform-aws-django/commit/fe4f5c420e12a588909a15b35e703178c5fe662f))

## [0.6.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.5.0...v0.6.0) (2022-04-17)


### Features

* **refactor:** refactored root level config into ad-hoc config ([#17](https://github.com/briancaffey/terraform-aws-django/issues/17)) ([01e96db](https://github.com/briancaffey/terraform-aws-django/commit/01e96dba8b73bd353e0fb4e1dbd36ed5e3057ae9))

## [0.5.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.4.0...v0.5.0) (2022-03-26)


### Features

* **iam:** add separate submodule for IAM 13 ([#14](https://github.com/briancaffey/terraform-aws-django/issues/14)) ([935cb0c](https://github.com/briancaffey/terraform-aws-django/commit/935cb0ce0c0e2b0fcec8e1bdb4de7a94d800faf3))

## [0.4.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.3.1...v0.4.0) (2022-03-16)


### Features

* **updates:** add settings for speeding up service updates ([#11](https://github.com/briancaffey/terraform-aws-django/issues/11)) ([61c4538](https://github.com/briancaffey/terraform-aws-django/commit/61c45383a522f683df561997f334efd68009ead5))

### [0.3.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.3.0...v0.3.1) (2022-03-14)


### Bug Fixes

* **health-checks:** change interval default to be greater than timeout default value ([1ad0e87](https://github.com/briancaffey/terraform-aws-django/commit/1ad0e878dfa6cc6dc43eb8122725be83677cb5b9))

## [0.3.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.2.0...v0.3.0) (2022-03-14)


### Features

* **health-checks:** update default health check values for web module ([9242d21](https://github.com/briancaffey/terraform-aws-django/commit/9242d216144ba0cf3a90f5617f3f332b34259722))

## [0.2.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.1.1...v0.2.0) (2022-03-14)


### Features

* **outputs:** add outputs for web module ([#6](https://github.com/briancaffey/terraform-aws-django/issues/6)) ([15e248d](https://github.com/briancaffey/terraform-aws-django/commit/15e248d6428f5b02bbe7ddf7b661b7fe317e2d74))

### [0.1.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.1.0...v0.1.1) (2022-03-12)


### Bug Fixes

* **logging:** add script for fetching logs from management command tasks ([#3](https://github.com/briancaffey/terraform-aws-django/issues/3)) ([fcb8f67](https://github.com/briancaffey/terraform-aws-django/commit/fcb8f6726d4849e102887a5fe73ed2995b92fb11))

## [0.1.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.0.6...v0.1.0) (2022-03-12)


### Features

* **example:** update simple example readme ([a43133c](https://github.com/briancaffey/terraform-aws-django/commit/a43133c03a2c2af5bb7e0ed799c18781907c83b5))
