
//Authenticate to the cluster

gcloud container clusters get-credentials learnk8s-cluster-prod --zone europe-west3

//Check that you are authenticated + Get cluster name

kubectl config current-context

//Check what you are planning on creating + generate tf files

terraform plan

//Check that your configuration is valid

terraform validate

//Create the planned ressources

terraform apply

# creation of a tenant
### Terraform
- create a service account with the right access
- create a key for the service account
- add the key to the terraform folder
- `terraform apply -auto-approve`
- modify the tenant name value
- `terraform apply -var="namespace=<name input>" -auto-approve`
