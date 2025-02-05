# commands used for local development

tf-fmt:
	terraform fmt -recursive

tf-validate:
	terraform validate

# ad hoc environment stacks

# ad hoc base
ecs-base-init:
	terraform -chdir=examples/ecs/base init

ecs-base-plan:
	terraform -chdir=examples/ecs/base plan

ecs-base-apply:
	terraform -chdir=examples/ecs/base apply

ecs-base-destroy:
	terraform -chdir=examples/ecs/base destroy

# ad hoc app
ecs-app-init:
	terraform -chdir=examples/ecs/app init

ecs-app-plan:
	terraform -chdir=examples/ecs/app plan

ecs-app-apply:
	terraform -chdir=examples/ecs/app apply

ecs-app-destroy:
	terraform -chdir=examples/ecs/app destroy

# prod environment stacks

# prod base

prod-base-init:
	terraform -chdir=examples/prod/base init

prod-base-plan:
	terraform -chdir=examples/prod/base plan

prod-base-apply:
	terraform -chdir=examples/prod/base apply

prod-base-destroy:
	terraform -chdir=examples/prod/base destroy

# prod app

prod-app-init:
	TF_LOG=ERROR terraform -chdir=examples/prod/app init 2> logs.txt

prod-app-plan:
	terraform -chdir=examples/prod/app plan

prod-app-apply:
	terraform -chdir=examples/prod/app apply

prod-app-destroy:
	terraform -chdir=examples/prod/app destroy
