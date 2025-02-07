# Changelog


## [0.25.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.24.0...v0.25.0) (2025-02-07)


### Features

* **app:** add nvidia api key variable to app stack ([46df011](https://github.com/briancaffey/terraform-aws-django/commit/46df011a6825eb1d4ebfa70488fdebe94dd66e6e))
* **compose:** update ec2 user data script to support docker compose ([0db8be5](https://github.com/briancaffey/terraform-aws-django/commit/0db8be5c65c61ed5582640c6af95e71cd7292b8f))
* **compose:** update ec2 user data script to support docker compose ([448f4a3](https://github.com/briancaffey/terraform-aws-django/commit/448f4a3d9a4d4fec5bdebccaf4c5a6ec60c9582f))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([65f9ca7](https://github.com/briancaffey/terraform-aws-django/commit/65f9ca73eac1f4062f67187eed84e7d1d85c4489))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([49783fa](https://github.com/briancaffey/terraform-aws-django/commit/49783fa866068e23619982260a5c8a23b01011d7))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([26925c9](https://github.com/briancaffey/terraform-aws-django/commit/26925c983ee4d6c7eca2457f309742da96ea857a))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([5eec414](https://github.com/briancaffey/terraform-aws-django/commit/5eec4148a6b2548a73d371d87656c2ea5b66c948))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([5e1e67a](https://github.com/briancaffey/terraform-aws-django/commit/5e1e67a9375143bd0b5152c529f80f5b2254ee9c))
* **docker-compose-ec2:** wip add config for running application on ec2 with docker compose ([58aa968](https://github.com/briancaffey/terraform-aws-django/commit/58aa9680572db6fefa6bc51497ab0c3b3f944d3c))
* **ec2:** update docker compose ec2 config ([302dc91](https://github.com/briancaffey/terraform-aws-django/commit/302dc91cc5b4d3863b3a2cdbb12895f5d68b69bf))
* **env-vars:** update env vars ([a5334b3](https://github.com/briancaffey/terraform-aws-django/commit/a5334b36788b5fe30cc24aed4b5734936b58a417))
* **git:** gitignore ([506d0fc](https://github.com/briancaffey/terraform-aws-django/commit/506d0fcf957d55d5f886e4b7ebac247eee913747))
* **modules:** remove ad-hoc nomenclature ([6cff23d](https://github.com/briancaffey/terraform-aws-django/commit/6cff23da75824da4d80bb42c11a9af9e5c2d7216))
* **ses:** add ses module to ecs base module ([c5d4518](https://github.com/briancaffey/terraform-aws-django/commit/c5d45187526e0e82e584c1b1dc2db6fc155837a2))
* **vpc-endpoints:** add vpc endpoint for ecr ([896b73a](https://github.com/briancaffey/terraform-aws-django/commit/896b73aa62b65567d44547e1fb2c21f6da5d7d92))
* **vpc-endpoints:** add vpc endpoint for ecr ([d540c08](https://github.com/briancaffey/terraform-aws-django/commit/d540c08de3bd0ac85094d6c4d919f1040408bdba))


### Bug Fixes

* **ad-hoc:** fixes for ad-hoc modules, rds password, elasticache, others ([56f4401](https://github.com/briancaffey/terraform-aws-django/commit/56f4401f802f525c73402738a5b8ff7403e20775))
* **app:** add rds secret name to env vars ([93a2058](https://github.com/briancaffey/terraform-aws-django/commit/93a2058beb5806dac6e3649eef7ec62bfb998ec9))
* **ec2:** fixes for docker compose on ec2 ([3e0071b](https://github.com/briancaffey/terraform-aws-django/commit/3e0071bbd5a97f3da10befaa3a4d9b3a28f26fe7))
* **fmt:** run terraform fmt to format terraform code ([d823a73](https://github.com/briancaffey/terraform-aws-django/commit/d823a733c74610a7e6e706994c90d12e8f7b87f3))
* **iam:** add ecr to iam role for ecs ([0b8fcdd](https://github.com/briancaffey/terraform-aws-django/commit/0b8fcdd1b79da9ba6c2520051dd928f334e1f9dc))
* **iam:** add secretsmanager DescribeSecret to iam ([9ce4d32](https://github.com/briancaffey/terraform-aws-django/commit/9ce4d326e575cae15957643e07720096794185d3))
* **lint:** format tf code ([0a33fcf](https://github.com/briancaffey/terraform-aws-django/commit/0a33fcf8fbd708b5eb0d72da0c03815b58a49a76))
* **s3:** add BucketOwnerEnforced to assets bucket ([64624cd](https://github.com/briancaffey/terraform-aws-django/commit/64624cdc9b78019b62c33396d5de300b5481c518))
* **s3:** update s3 bucket settings ([35bb249](https://github.com/briancaffey/terraform-aws-django/commit/35bb2496253a78d87a5df602df41b86f965dd418))
* **secrets:** add random suffix to rds secret ([0deec3f](https://github.com/briancaffey/terraform-aws-django/commit/0deec3f4f07fa94ab2d7b1eef997449450230bb7))
* **ses:** fix s3 vpc endpoint ([eed9bba](https://github.com/briancaffey/terraform-aws-django/commit/eed9bba76d2c3d27fab6de601744de3f1327d5ad))
* **ses:** fix s3 vpc endpoint ([ca11481](https://github.com/briancaffey/terraform-aws-django/commit/ca11481143f220b4d4ad3061480d1c60500b6f16))
* **ses:** fix s3 vpc endpoint ([f38321a](https://github.com/briancaffey/terraform-aws-django/commit/f38321aea4d5c8806c590ed558b36d1fd8cc5bf7))
* **ses:** fix s3 vpc endpoint ([a861025](https://github.com/briancaffey/terraform-aws-django/commit/a8610255fdaeed121faa93a93d5a8cf333d7a532))
* **ses:** fix s3 vpc endpoint ([cbbf3e2](https://github.com/briancaffey/terraform-aws-django/commit/cbbf3e2c95aa9337498e330473aea6b5bfc11bf1))
* **ses:** fix s3 vpc endpoint ([eab38ee](https://github.com/briancaffey/terraform-aws-django/commit/eab38eea4b35968f70da31ae7e68dfe184c7af5b))
* **ses:** fix zone id reference in ses module ([35ce248](https://github.com/briancaffey/terraform-aws-django/commit/35ce2482647ed0b6f6c67675a679b191f1f85e3d))
* **sg:** debuggin sg rule issue ([f80e9c5](https://github.com/briancaffey/terraform-aws-django/commit/f80e9c5a64e47f4253652d68cdb94a787c9cf694))
* **sg:** debuggin sg rule issue ([6a1b2cb](https://github.com/briancaffey/terraform-aws-django/commit/6a1b2cb456a2b01360973259e61b1a0b07b3c84e))
* **sg:** debuggin sg rule issue ([cbca2e2](https://github.com/briancaffey/terraform-aws-django/commit/cbca2e2cdf53b05df2d1ab9e216c07921c0102e5))
* **sg:** debuggin sg rule issue ([2ff0d77](https://github.com/briancaffey/terraform-aws-django/commit/2ff0d77d3db4568252891493a02cf0c4fcd20587))
* **sg:** debuggin sg rule issue ([bb639e1](https://github.com/briancaffey/terraform-aws-django/commit/bb639e14ebd694ef53f9dba12a6a609f1c5018a7))
* **sg:** debuggin sg rule issue ([dc0442e](https://github.com/briancaffey/terraform-aws-django/commit/dc0442ecaa13a73c4724fa27deac497d62a27f3a))
* **sg:** debuggin sg rule issue ([7603d0f](https://github.com/briancaffey/terraform-aws-django/commit/7603d0f128390b94a9aaa4663eefd3c484a0ef2b))
* **sg:** debuggin sg rule issue ([197a464](https://github.com/briancaffey/terraform-aws-django/commit/197a46450bf25e9b2a33836122d72ff4b6010f23))
* **sg:** debuggin sg rule issue ([a853fa2](https://github.com/briancaffey/terraform-aws-django/commit/a853fa2e265bd81e668ea1a718b5f474e7bf519b))
* **sg:** debuggin sg rule issue ([01ccabc](https://github.com/briancaffey/terraform-aws-django/commit/01ccabc1fc25b89c54bc1692c8f25fc992864918))
* **sg:** debuggin sg rule issue ([b2084ea](https://github.com/briancaffey/terraform-aws-django/commit/b2084ea9269ad95c091cf6bc1351cc6f51b08f9f))
* **sg:** debuggin sg rule issue ([1afcb79](https://github.com/briancaffey/terraform-aws-django/commit/1afcb798455eccda99ad473c4fec573fac523091))
* **sg:** final fix for ecr access in ecs task ([4f3b091](https://github.com/briancaffey/terraform-aws-django/commit/4f3b09148dffdd5057cd72ee9c50772e2fb7aead))
* **sg:** final fix for ecr access in ecs task ([528a7e0](https://github.com/briancaffey/terraform-aws-django/commit/528a7e03bd6051c12f8cda9adcae234adb5cdd1a))
* **sg:** fix app agress cidr range ([c072063](https://github.com/briancaffey/terraform-aws-django/commit/c072063a43aba0939826f0f95e15733c02edae66))
* **sg:** fix cycle in sg module ([0940c02](https://github.com/briancaffey/terraform-aws-django/commit/0940c028160e5a112dfca4225dad4b778aebfd60))
* **sg:** fix cycle in sg module ([66ac118](https://github.com/briancaffey/terraform-aws-django/commit/66ac1181a4f29531f57ae4927e01a5d03d28866e))
* **sg:** fix cycle in sg module ([d119951](https://github.com/briancaffey/terraform-aws-django/commit/d1199514413a7dedb0d804c86864bb4895c9cfa9))
* **sg:** fix cycle in sg module ([16280de](https://github.com/briancaffey/terraform-aws-django/commit/16280de3343c078fa31b45d953854f497faf3cc5))
* **sg:** fix cycle in sg module ([6c9f735](https://github.com/briancaffey/terraform-aws-django/commit/6c9f735bd9e6337da9525762c7f30ca6cf700a53))
* **sg:** fix security group settings ([c7218fd](https://github.com/briancaffey/terraform-aws-django/commit/c7218fd5924860d517e41aa608423b260718d389))
* **sg:** fix vpc endpoint config ([b11c98e](https://github.com/briancaffey/terraform-aws-django/commit/b11c98e581821d8fcb8d16d5e6b7c27354220e57))
* **sg:** remove duplicate security group for ecs module ([c7a103f](https://github.com/briancaffey/terraform-aws-django/commit/c7a103ff337dbebc10f0b8058ee65296e534d6d0))
* **typo:** fix input typo for s3 vpc endpoint ([f179077](https://github.com/briancaffey/terraform-aws-django/commit/f179077250ea22170ead959c0142e3ba482e1bca))
* **typo:** fix typo in iam role ([44d9238](https://github.com/briancaffey/terraform-aws-django/commit/44d9238d9a641a18374f02c64eca31ff9abd4f7d))
* **typo:** fix typo in iam role ([7023bd6](https://github.com/briancaffey/terraform-aws-django/commit/7023bd680e481966c42925795fd54e3b259f31d9))
* **typo:** tcp not tpc ([2550f67](https://github.com/briancaffey/terraform-aws-django/commit/2550f67d566b2e11867e3125ebcd9975be866248))
* **typo:** tcp not tpc ([f883d22](https://github.com/briancaffey/terraform-aws-django/commit/f883d22825565a4d16c6c4d31427ef74480bbd9e))
* **ui:** fix settings for ui ([79844dd](https://github.com/briancaffey/terraform-aws-django/commit/79844dd2fb11f7e2ecd224b1afa65f15b00fd9d6))
* **ui:** update command default for ui container ([64bc67a](https://github.com/briancaffey/terraform-aws-django/commit/64bc67a5b5d9ffe3a8e0473fc3cc2f19f1e70464))

## [0.24.0](https://github.com/briancaffey/terraform-aws-django/compare/v0.23.2...v0.24.0) (2025-01-27)


### Features

* **upgrade:** upgrade terraform and aws provider versions for examples ([9a9ac94](https://github.com/briancaffey/terraform-aws-django/commit/9a9ac94193f84484147627f09d86b14353b620b1))

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
