#Azure provider source and version which we will use

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.64.0"
    }
  }
}


#Configure Microsoft Azure provider

provider "azurerm" {
  features {

  }
}
