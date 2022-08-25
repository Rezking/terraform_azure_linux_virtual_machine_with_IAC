 # A Terraform script that provisions a linux virtual machine with a new resource group, subnet, virtual network, and network interface.
 The main script is the `azure.tf` file and the variables are in the `variables.tf` file.
 To use this script, ensure the az cli is configured with an azure user account with an active subscription to ensure the code runs smoothly.
 
 Then run `terraform init` to initialize and install the provider used in the script `azurerm` in this case.
 
 Run `terraform plan` to see what the script will provision. Use the command `terraform apply` to run the script completely and provision the resources in the script
