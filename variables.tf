variable "aci_user" {
  type = string
  description = "the username for aci"
}
variable "aci_password" {
  type = string
  description = "The password for aci"
}
variable "aci_url" {
  type = string
  description = "the hostname or ip address of your APIC server"
}

variable "tenant_name" {
  type        = string
  description = "The name of our new Tenant managed by Terraform"
  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.tenant_name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vrfs" {
  type        = list(string)
  description = "List of VRFs we want our new tenant to have"
  default     = []

  validation {
    condition = alltrue([
      for vrf in var.vrfs : can(regex("^[a-zA-Z0-9_.-]{0,64}$", vrf))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}
variable "bridge_domains" {
  type = map(object({
    routing = bool,
    vrf     = string,
  }))
  description = "Map of bridge domains to create and their associated VRFs"
  default     = {}

  validation {
    condition = alltrue([
      for bd, settings in var.bridge_domains : can(regex("^[a-zA-Z0-9_.-]{0,64}$", bd))
    ])
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}
