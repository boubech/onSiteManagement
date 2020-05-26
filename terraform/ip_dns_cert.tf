
provider "acme" {
  server_url = "https://acme-v02.api.letsencrypt.org/directory"
}

##################################################################
## IP RESERVATION
#################################################################
resource "azurerm_public_ip" "ip" {
  name                = "publicip"
  location            = var.azure_region
  resource_group_name = azurerm_resource_group.group.name
  allocation_method   = "Static"
}
##################################################################
## ADD DNS ENTRY
#################################################################
resource "ovh_domain_zone_record" "record" {
  zone        = var.domain_name_base
  subdomain   = "*.${var.domain_name_prefix}"
  fieldtype   = "A"
  ttl         = "3600"
  target      = azurerm_public_ip.ip.ip_address
}

#################################################################
## GENERATE TLS CERT WITH ACME
#################################################################
resource "tls_private_key" "le_tls_private_key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}
resource "acme_registration" "local_registration" {
  account_key_pem = tls_private_key.le_tls_private_key.private_key_pem
  email_address   = "julien.boubechtoula@ca-ps.com"
}
resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.local_registration.account_key_pem
  common_name               = "*.${var.domain_name_prefix}.${var.domain_name_base}"
  subject_alternative_names = ["${var.domain_name_prefix}.${var.domain_name_base}"]

  dns_challenge {
    provider = "ovh"
    config = {
      OVH_ENDPOINT            = "${var.ovh_endpoint}"
      OVH_APPLICATION_KEY     = "${var.ovh_app_key}"
      OVH_APPLICATION_SECRET  = "${var.ovh_app_secret}"
      OVH_CONSUMER_KEY        = "${var.ovh_consumer_key}"
    }
  }
}




