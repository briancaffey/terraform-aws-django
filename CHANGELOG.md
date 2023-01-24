# Changelog


## [0.23.2](https://github.com/briancaffey/terraform-aws-django/compare/v0.23.1...v0.23.2) (2023-01-24)


### Bug Fixes

* Give unique alarm_name to avoid collision when default and gunicorn both create the same alarm name. ([#61](https://github.com/briancaffey/terraform-aws-django/issues/61)) ([3a61b6a](https://github.com/briancaffey/terraform-aws-django/commit/3a61b6aa1a2e923d31550dd55c088e851e06b897))

## [0.23.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.23.0...v0.23.1) (2023-01-24)


### Bug Fixes

* Set auto_minor_version_upgrade = false (so state does not get changed outside of terraform) ([#62](https://github.com/briancaffey/terraform-aws-django/issues/62)) ([df451f1](https://github.com/briancaffey/terraform-aws-django/commit/df451f1d706c43456092f650722f74c1b1a359b0))

## [0.23.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.22.1...v0.23.0) (2023-01-21)


### Features

* Change default instance type from t2.micro to t3.micro ([#56](https://github.com/briancaffey/terraform-aws-django/issues/56)) ([8d81226](https://github.com/briancaffey/terraform-aws-django/commit/8d812267bd0d3ff830d56778ae20b030daad9733))

## [0.22.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.22.0...v0.22.1) (2023-01-21)


### Bug Fixes

* **services:** Frontend (web-ui) using incorrect variables for cpu/memory ([#54](https://github.com/briancaffey/terraform-aws-django/issues/54)) ([e0c8a6a](https://github.com/briancaffey/terraform-aws-django/commit/e0c8a6af64d4280abeb329c577e0330208264a11))

## [0.22.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.21.1...v0.22.0) (2023-01-06)


### Features

* **alb:** rename lb dir to alb ([3f55f98](https://github.com/briancaffey/terraform-aws-django/commit/3f55f98c168238e67ec494382bc62503da34f5da))
* **cluster:** move ecs cluster files to new directory under ecs ([2d76924](https://github.com/briancaffey/terraform-aws-django/commit/2d76924c3b01621946b063f8a806ee294d1db1e1))
* **prod:** refactor prod infra and ensure that base and app prod envs work deploying locally ([aa93862](https://github.com/briancaffey/terraform-aws-django/commit/aa93862327aa4d5d1e8efd47112d23e7ae878ad5))
* **refactor:** refactor ecs service modules and log group and log stream names ([5b18264](https://github.com/briancaffey/terraform-aws-django/commit/5b18264d5a85259d78fa0aa1909c228c4554630a))
* **services:** refactor ecs services into a new directory in internal modules dir ([9b397e0](https://github.com/briancaffey/terraform-aws-django/commit/9b397e0ad7df0ed7c9004fbd7c0bde86ee95a5d0))


### Bug Fixes

* **bastion:** remove unused var ([1e39a31](https://github.com/briancaffey/terraform-aws-django/commit/1e39a3187dcc4c7daf92ea53fb11bfc5f21ae9b2))
* **bastion:** remove unused var from prod bastion ([aa15a27](https://github.com/briancaffey/terraform-aws-django/commit/aa15a279e482e5d93fc5c01c35f71127969fd3b1))

## [0.21.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.21.0...v0.21.1) (2023-01-02)


### Bug Fixes

* **sg:** allow app sg inbound and outbound traffic to itself ([0766b1b](https://github.com/briancaffey/terraform-aws-django/commit/0766b1bb321ea69b1e944593b98c25f5e7f4cc71))

## [0.21.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.20.3...v0.21.0) (2023-01-02)


### Features

* **refactor:** major refactor of ad hoc environment modules ([2d95d0b](https://github.com/briancaffey/terraform-aws-django/commit/2d95d0bd96ab9020dd8a7808b24a11385b36176c))

## [0.20.3](https://github.com/briancaffey/terraform-aws-django/compare/v0.20.2...v0.20.3) (2022-09-12)


### Bug Fixes

* **autoscaling:** change parameters of autoscaling modules ([4d9e044](https://github.com/briancaffey/terraform-aws-django/commit/4d9e0445df13a98af85754a8de871fc812af8377))

## [0.20.2](https://github.com/briancaffey/terraform-aws-django/compare/v0.20.1...v0.20.2) (2022-09-11)


### Bug Fixes

* **autoscaling:** add depends on to autoscaling modules for api and celery worker ([07bb5aa](https://github.com/briancaffey/terraform-aws-django/commit/07bb5aa5307a1cc0bedd5cb8ae7fd6bd4a2b6766))

## [0.20.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.20.0...v0.20.1) (2022-09-11)


### Bug Fixes

* **bastion:** fix bastion host module variables in prod base ([b2d0001](https://github.com/briancaffey/terraform-aws-django/commit/b2d00011686a488ecea6bc41dc240c3d93ece40e))

## [0.20.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.19.0...v0.20.0) (2022-09-11)


### Features

* **autoscaling:** add reusable module for autoscaling and modules for api and celery worker autoscaling [#46](https://github.com/briancaffey/terraform-aws-django/issues/46) ([fc0787c](https://github.com/briancaffey/terraform-aws-django/commit/fc0787ccb9f62a2424a76a9c3b568fc4340ffc6c))

## [0.19.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.18.1...v0.19.0) (2022-08-05)


### Features

* **cloud init:** enable socat service and start it in user data script ([8792180](https://github.com/briancaffey/terraform-aws-django/commit/8792180c0c3a2c0351260466b881e05e3f9be790))


### Bug Fixes

* update bastion user data ([879767d](https://github.com/briancaffey/terraform-aws-django/commit/879767dc225749d1bb11a31121b1f5c9fa11d9ff))

## [0.18.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.18.0...v0.18.1) (2022-07-31)


### Bug Fixes

* change public to private for subnet variable ([6a69fba](https://github.com/briancaffey/terraform-aws-django/commit/6a69fbaa1f9f597b8e480d9fce6de977a6060902))
* remove ssh command output ([f0282f8](https://github.com/briancaffey/terraform-aws-django/commit/f0282f8b77a295c4b18d2cf712c197a9a00b8078))

## [0.18.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.17.0...v0.18.0) (2022-07-31)


### Features

* remove key pair ([a90aa2b](https://github.com/briancaffey/terraform-aws-django/commit/a90aa2bd8698a2373b8c1365b2945393ed9796e6))

## [0.17.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.16.1...v0.17.0) (2022-07-31)


### Features

* **bastion:** update bastion host with role and changed subnets ([c768d1d](https://github.com/briancaffey/terraform-aws-django/commit/c768d1de56c54563a349b35233e5c7b1d82f777e))


### Bug Fixes

* **fmt:** format terraform code ([6f32b48](https://github.com/briancaffey/terraform-aws-django/commit/6f32b483abfbb6983137d5dd4155ac6c0b8c540f))

## [0.16.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.16.0...v0.16.1) (2022-07-05)


### Bug Fixes

* **fmt:** format terraform code ([1999f67](https://github.com/briancaffey/terraform-aws-django/commit/1999f67fda24d7eccd108569b3cb9a3b13870886))

## [0.16.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.15.2...v0.16.0) (2022-07-05)


### Features

* **s3:** add s3 module to prod app module ([ba8a460](https://github.com/briancaffey/terraform-aws-django/commit/ba8a46056652a015154afba58542f71879485574))

## [0.15.2](https://github.com/briancaffey/terraform-aws-django/compare/v0.15.1...v0.15.2) (2022-07-05)


### Bug Fixes

* **iam:** fix s3 permissions for s3 access use arn format in resource for s3 policy ([46530d0](https://github.com/briancaffey/terraform-aws-django/commit/46530d00c08ce0942eba792fd3ee6a520c0ff299))

## [0.15.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.15.0...v0.15.1) (2022-07-05)


### Bug Fixes

* **iam:** fix iam permissions for collectstatic ([9450b22](https://github.com/briancaffey/terraform-aws-django/commit/9450b22e0530760931743989f9e9a7b743b5e64c))
* **iam:** fix s3 permissions for s3 access ([a37877c](https://github.com/briancaffey/terraform-aws-django/commit/a37877c4e4f1c701fe8f2db861012d66ea932b3e))

## [0.15.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.14.0...v0.15.0) (2022-07-04)


### Features

* **backend_update:** add backend update command module to prod and ad hoc modules and associated outputs ([b3ce9a3](https://github.com/briancaffey/terraform-aws-django/commit/b3ce9a35c3d2e3367ec0f8777411f01829660b98))

## [0.14.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.13.0...v0.14.0) (2022-07-04)


### Features

* **ad hoc:** move ad hoc app module to nested folder ([03b37ec](https://github.com/briancaffey/terraform-aws-django/commit/03b37ec0c17c199f0e3eac1119ac855c08c9c7a7))

## [0.12.3](https://github.com/briancaffey/terraform-aws-django/compare/v0.12.2...v0.12.3) (2022-07-04)


### Bug Fixes

* **fargate:** remove weight for fargate spot on all production modules ([57725a8](https://github.com/briancaffey/terraform-aws-django/commit/57725a8bf798d903d1b93bd14648ce6562de26e6))
* **lb:** remove hard-coded name from lb sg ([bc1e2ca](https://github.com/briancaffey/terraform-aws-django/commit/bc1e2cab020b84363206d8e7a6436cef9dd7f1c5))

## [0.12.2](https://github.com/briancaffey/terraform-aws-django/compare/v0.12.1...v0.12.2) (2022-07-04)


### Bug Fixes

* **tf:** do not use fargate spot for production module ([79675cf](https://github.com/briancaffey/terraform-aws-django/commit/79675cf92bf61a74cb9dbaa5c6dd565a50927652))

## [0.12.1](https://github.com/briancaffey/terraform-aws-django/compare/v0.12.0...v0.12.1) (2022-07-03)


### Bug Fixes

* **frontend_url:** remove frontend_url since it is not needed ([fa1052d](https://github.com/briancaffey/terraform-aws-django/commit/fa1052d4ba1180c81776254775fdaec98b0a6cec))

## [0.12.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.11.0...v0.12.0) (2022-07-02)


### Features

* **production:** add modules and examples for production environments ([7eb0ab9](https://github.com/briancaffey/terraform-aws-django/commit/7eb0ab95595445eb6c80c4b150edc992ade1b485))

## [0.11.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.10.0...v0.11.0) (2022-06-11)


### Features

* **exec:** add enable_execute_command to service in web module ([cd882c1](https://github.com/briancaffey/terraform-aws-django/commit/cd882c11fa28fe68479a21e7b111cfce20c6dc6b))
* **exec:** add output for ecs exec ([b5aa8bc](https://github.com/briancaffey/terraform-aws-django/commit/b5aa8bcb25a77c96e92e660c7ca9b1824a1da218))

## [0.10.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.6...v0.10.0) (2022-06-11)


### Features

* **services:** add lifecycle settings to ecs services to ignore changes for task_definition and desired count ([0f4ad7f](https://github.com/briancaffey/terraform-aws-django/commit/0f4ad7f8136814ba8c132981f6d3923bc8218dad))

## [0.9.6](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.5...v0.9.6) (2022-06-03)


### Bug Fixes

* **listener-rules:** add host_header on web module ([63bb16c](https://github.com/briancaffey/terraform-aws-django/commit/63bb16c73fb557fd22ff3f3396968c9cb44b71f0))
* **listener-rules:** fix depends_on ([717fea7](https://github.com/briancaffey/terraform-aws-django/commit/717fea7215fcefd87cdfaa6105cf3a3f543bb59f))

## [0.9.5](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.4...v0.9.5) (2022-06-03)


### Bug Fixes

* **listener-rules:** remove priority setting and add depends_on so that priorities set explicitly ([7bde6f0](https://github.com/briancaffey/terraform-aws-django/commit/7bde6f044999d10b7f6c010f0a220985bfc31d8c))

## [0.9.4](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.3...v0.9.4) (2022-06-03)


### Bug Fixes

* **redis:** fix typo in redis service host ([d7cd2c2](https://github.com/briancaffey/terraform-aws-django/commit/d7cd2c2fffadd59039f9647613e18b642394fdaa))

## [0.9.3](https://github.com/briancaffey/terraform-aws-django/compare/v0.9.2...v0.9.3) (2022-06-03)


### Bug Fixes

* **redis:** use shared namespace for redis host address ([f171860](https://github.com/briancaffey/terraform-aws-django/commit/f171860fa0cbdcaf2bba54ddf7f1509160fd0d87))

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
