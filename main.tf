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
  vrfs        = var.vrfs 
  bridge_domains = var.bridge_domains 
  
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
