init:
	terraform init
	terraform workspace new nick-demo || echo ""
	#terraform workspace new sliderule-demo || echo ""
	terraform workspace select sliderule-demo

plan: init
	terraform plan -var-file="nickdemo.tfvars"

apply: init
	terraform apply -var-file="nickdemo.tfvars"