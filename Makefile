examples-simple-init:
	terraform -chdir=examples/simple init

examples-simple-plan:
	terraform -chdir=examples/simple plan

examples-simple-apply:
	terraform -chdir=examples/simple apply

examples-simple: examples-simple-init	examples-simple-plan	examples-simple-apply

examples-simple-destroy:
	terraform -chdir=examples/simple destroy

tf-fmt:
	terraform fmt -recursive

tf-validate:
	terraform validate