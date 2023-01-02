# commands used for local development

tf-fmt:
	terraform fmt -recursive

tf-validate:
	terraform validate

# ad hoc environment stacks

# ad hoc base
ad-hoc-base-init:
	terraform -chdir=examples/ad-hoc/base init

ad-hoc-base-plan:
	terraform -chdir=examples/ad-hoc/base plan

ad-hoc-base-apply:
	terraform -chdir=examples/ad-hoc/base apply

ad-hoc-base-destroy:
	terraform -chdir=examples/ad-hoc/base destroy

# ad hoc app
ad-hoc-app-init:
	terraform -chdir=examples/ad-hoc/app init

ad-hoc-app-plan:
	terraform -chdir=examples/ad-hoc/app plan

ad-hoc-app-apply:
	terraform -chdir=examples/ad-hoc/app apply

ad-hoc-app-destroy:
	terraform -chdir=examples/ad-hoc/app destroy

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
