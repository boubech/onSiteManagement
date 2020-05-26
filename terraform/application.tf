#################################################################
## ADD WILD CARD TLS CERTIFICATE
#################################################################
resource "kubernetes_secret" "tls_secret" {
  metadata {
    name = "tls-secret-acme"
    namespace = "default"
  }
  data = {
    "tls.crt" = "${acme_certificate.certificate.certificate_pem}${acme_certificate.certificate.issuer_pem}"
    "tls.key" = acme_certificate.certificate.private_key_pem
  }
  type = "kubernetes.io/tls"
}

#################################################################
## DEPLOY APPLICATION
#################################################################
resource "helm_release" "application" {
  name      = "app"
  chart     = "${path.module}/on-site-management"
  namespace = "default"

  values    = [<<EOF

backend:
    image:
        repository: ${var.backend_image}
        tag: ${var.backend_image_tag}
    resources:
        limits:
            cpu: 1000m
            memory: 1Gi
        requests:
            cpu: 50m
            memory: 32Mi

frontend:
    image:
        repository: ${var.frontend_image}
        tag: ${var.frontend_image_tag}
    resources:
        limits:
            cpu: 500m
            memory: 128Mi
        requests:
            cpu: 50m
            memory: 32Mi

ingress:
  enabled: "true"
  annotations:
    kubernetes.io/ingress.class: "traefik"
  hosts:
    - host: "dashboard.${var.domain_name_prefix}.${var.domain_name_base}"
  tls:
    - hosts:
      - "${var.domain_name_prefix}.${var.domain_name_prefix}"
      secretName: "${kubernetes_secret.tls_secret.metadata[0].name}"


EOF
  ]

}