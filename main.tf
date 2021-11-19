terraform {
  required_providers {
    aci = {
      source = "CiscoDevNet/aci"
      version = "1.0.1"
    }
  }
}

provider "aci" {
  username = var.aci_user
  password = var.aci_password
  url      = var.aci_url
  insecure = true
}

module "tenant" {
  source  = "qzx/tenant/aci"
  version = "1.2.3"

  tenant_name = "example"
  vrfs        = ["MY_VRF1", "MY_VRF2"]
  bridge_domains = {
    BD1 = {
      routing = true
      vrf     = "MY_VRF1"
    },
    BD2 = {
      routing = false
      vrf     = "MY_VRF2"
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
          vlan_id = 111
          path    = "topology/pod-1/protpaths-201-202/pathep-[MY_VPC_PATH_A]"
        },
        {
          vlan_id = 222
          path    = "topology/pod-1/protpaths-201-202/pathep-[MY_VPC_PATH_B]"
        }
      ]
    }
  }
}
