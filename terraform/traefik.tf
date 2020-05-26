data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

resource "helm_release" "traefik" {
  name       = "traefik"
  repository = data.helm_repository.stable.metadata[0].name
  chart      = "traefik"
  version    = "1.86.1"
  namespace  = "kube-system"

  set {
    name  = "kubernetes.ingressClass"
    value = "traefik"
  }
  set {
    name  = "kubernetes.ingressEndpoint.useDefaultPublishedService"
    value = "true"
  }
  set {
    name  = "ssl.enabled"
    value = "true"
  }
  set {
    name  = "ssl.permanentRedirect"
    value = "true"
  }

  set {
    name  = "externalTrafficPolicy"
    value = "Local"
  }
  set {
    name  = "loadBalancerIP"
    value = azurerm_public_ip.ip.ip_address
  }
  set {
    name = "service.annotations.\"service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group\""
    value = azurerm_resource_group.group.name
  }
}