###########################
## APPLICATION
###########################
variable "backend_image" {
  default = "jboubechtoula/caps-onsite-management-backend"
}
variable "backend_image_tag" {
  default = "latest"
}
variable "frontend_image" {
  default = "jboubechtoula/caps-onsite-management-frontend"
}
variable "frontend_image_tag" {
  default = "latest"
}
###########################
## AZURE
###########################
variable "azure_group" {
  default = "demo-on-site-management"
}
variable "azure_region" {
  default = "francecentral"
}
###########################
## DNS
###########################
variable "domain_name_prefix" {
  default = "demo-on-site-management"
}
variable "domain_name_base" {
  default = "dvi.best"
}
###########################
## KUBERNETES
###########################
variable "k8s_node_count" {
  default = 1
}
variable "k8s_client_id" {
}
variable "k8s_client_secret" {
}
variable "k8s_node_size" {
  default = "Standard_DS3_v2"
}

###########################
## OVH
###########################
variable "ovh_endpoint" {
  description = "OVH_ENDPOINT"
  default     = "ovh-eu"
}
variable "ovh_app_key" {
  description = "OVH_APPLICATION_KEY"
}
variable "ovh_app_secret" {
  description = "OVH_APPLICATION_SECRET"
}
variable "ovh_consumer_key" {
  description = "OVH_CONSUMER_KEY"
}