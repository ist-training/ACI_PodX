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
