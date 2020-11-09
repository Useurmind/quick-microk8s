variable admin_username {
  default = "adminuser"
}

variable admin_password {
  default = "l2kkhnACkWkKxmn9hlbe"
}

variable ssh_pub_key {
    default = "~/.ssh/id_rsa_btwwc.pub"
}

variable ssh_priv_key {
    default = "~/.ssh/id_rsa_btwwc"
}

locals {
    common_tags = {        
        "deployment" : "quick-microk8s"
    }
}

resource "azurerm_resource_group" "rg" {
  name     = "quick-microk8s"
  location = "West Europe"

  tags = local.common_tags
}