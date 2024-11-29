wget https://github.com/GoogleCloudPlatform/terraformer/releases/download/0.8.24/terraformer-all-linux-amd64
chmod +x terraformer-all-linux-amd64
sudo mv terraformer-all-linux-amd64 /usr/local/bin/terraformer
terraformer --version

COMMAND: terraformer import aws --resources=sg,ec2_instance,elb --regions=us-east-1
UPDATE PROVIDERS IN STATE FILE:
terraform state replace-provider -- -/aws hashicorp/aws
terraform init
terraform plan
terraform apply
