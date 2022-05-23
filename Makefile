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

tf-fmt:
	terraform fmt -recursive

tf-validate:
	terraform validate