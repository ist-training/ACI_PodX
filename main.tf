terraform {
  required_providers {
    aci = {
      source = "ciscodevnet/aci"
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
  name        = "test_tf_tenant"
  description = "This tenant is created by terraform ACI provider"
}
