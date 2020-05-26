#!/usr/bin/env bash


export TF_VAR_k8s_client_id=$ARM_CLIENT_ID
export TF_VAR_k8s_client_secret=$ARM_CLIENT_SECRET
export TF_VAR_ovh_endpoint=$OVH_ENDPOINT

export TF_VAR_ovh_app_key=$OVH_APPLICATION_KEY
export TF_VAR_ovh_app_secret=$OVH_APPLICATION_SECRET
export TF_VAR_ovh_consumer_key=$OVH_CONSUMER_KEY

terraform init
terraform apply