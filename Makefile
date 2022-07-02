examples-simple-init:
	terraform -chdir=examples/simple init

examples-simple-plan:
	terraform -chdir=examples/simple plan

examples-simple-apply:
	terraform -chdir=examples/simple apply

examples-simple: examples-simple-init	examples-simple-plan	examples-simple-apply

examples-simple-destroy:
	terraform -chdir=examples/simple destroy

examples-ad-hoc-init:
	terraform -chdir=examples/ad-hoc init -backend-config=backend.config

examples-ad-hoc-plan:
	terraform -chdir=examples/ad-hoc plan

examples-ad-hoc-apply:
	terraform -chdir=examples/ad-hoc apply

# PROD base

examples-prod-base-init:
	terraform -chdir=examples/prod/base init

examples-prod-base-plan:
	terraform -chdir=examples/prod/base plan

examples-prod-base-apply:
	terraform -chdir=examples/prod/base apply

examples-prod-base-destroy:
	terraform -chdir=examples/prod/base destroy

# PROD app

examples-prod-app-init:
	TF_LOG=ERROR terraform -chdir=examples/prod/app init 2> logs.txt

examples-prod-app-plan:
	terraform -chdir=examples/prod/app plan

examples-prod-app-apply:
	terraform -chdir=examples/prod/app apply

examples-prod-app-destroy:
	terraform -chdir=examples/prod/app destroy

tf-fmt:
	terraform fmt -recursive

tf-validate:
	terraform validate