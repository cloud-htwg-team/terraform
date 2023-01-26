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
