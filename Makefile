init:
	terraform init
	terraform workspace new sliderule-demo || echo ""
	terraform workspace select sliderule-demo

plan: init
	terraform plan -var-file="main.tfvars"

apply: init
	terraform apply -var-file="main.tfvars"

destroy: init
	terraform destroy -var-file="main.tfvars"