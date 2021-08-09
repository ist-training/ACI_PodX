terraform {
  required_providers {
    aci = {
      source = "https://github.com/CiscoDevNet/terraform-provider-aci/releases/download/v0.7.1/terraform-provider-aci_0.7.1_SHA256SUMS"
    }
  }
}

provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}

resource "aci_tenant" "demotenant" {
  name        = "test_tf_tenant_podX"
  description = "This tenant is created by terraform ACI provider"
}

/*data "aci_tenant" "tenant_fetch" {
  name = "data_source_test"
}*/


/*
output "tenant_dn" {
  value = data.aci_tenant.tenant_fetch.id
}

output "app_dn" {
  value = data.aci_application_profile.ap_fetch.id
}

output "epg_dn" {
  value = data.aci_application_epg.epg_fetch.id
}*/
