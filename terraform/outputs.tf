output "kubeconfig" {
    value =  azurerm_kubernetes_cluster.k8s.kube_config_raw
}
output "application" {
    value =  helm_release.application
}