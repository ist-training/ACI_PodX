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

module "aci_tenant" {
  source  = "qzx/tenant/aci"
  version = "1.0.0"

  tenant_name = var.tenant_name
  vrfs        = var.vrfs //["MY_VRF1", "MY_VRF2"]
  bridge_domains = {
    BD1 = {
      routing = true
      vrf     = var.vrfs[1]//"MY_VRF1"
    },
    BD2 = {
      routing = false
      vrf     = var.vrfs[2]//"MY_VRF2"
    }
  }
  application_profiles = ["ONE", "TWO"]
  epgs = {
    EPG1 = {
      application_profile = "ONE"
      bridge_domain       = "BD1"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths        = []
    },
    EPG2 = {
      application_profile = "TWO"
      bridge_domain       = "BD2"
      domains             = ["uni/phys-MY_PHYSICAL_DOMAIN"]
      static_paths = [
        {
          vlan_id = 100
          path    = "topology/pod-1/protpaths-201-202/pathep-[MY_VPC_PATH_A]"
        },
        {
          vlan_id = 100
          path    = "topology/pod-1/protpaths-201-202/pathep-[MY_VPC_PATH_B]"
        }
      ]
    }
  }
}



/*
resource "aci_tenant" "demotenant" {
  name        = "test_tf_tenant_podX"
  description = "This tenant is created by terraform ACI provider"
}
*/
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
