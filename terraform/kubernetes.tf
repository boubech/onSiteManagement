resource "azurerm_kubernetes_cluster" "k8s" {
  name                = "sdd-kubernetes"
  location            = var.azure_region
  resource_group_name = var.azure_group
  dns_prefix          = "sdd-kubernetes"

  default_node_pool {
    name            = "default"
    node_count      = var.k8s_node_count
    vm_size         = var.k8s_node_size
  }

  service_principal {
    client_id     = var.k8s_client_id
    client_secret = var.k8s_client_secret
  }
}


provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
  load_config_file       = "false"
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.k8s.kube_config.0.host
    load_config_file       = "false"
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s.kube_config.0.cluster_ca_certificate)
  }
  debug           = "true"
  version         = "1.1.1"
}