 module "rgs" {
  source              = "../../modules/rg-microtodoui-dev-eus-01"
  resource_group_name = "rg-microtodoui-dev-eus-01class"
   location            = "East US"
# } 

 module "vnet" {
  depends_on          = [module.rgs]
  source              = "../../modules/vnet-microtodoui-dev-eus-01"
  name                = "vnet-microtodoui-dev-eus-01agw"
  location            = module.rgs.location
  address_space       = ["10.0.0.0/16"]
  resource_group_name = module.rgs.resource_group_name

 }

 module "subnet" {
   depends_on           = [module.rgs, module.vnet]
  source               = "../../modules/snet-app-dev-eus-01"
   name                 = "snet-app-dev-eus-01"
 resource_group_name  = module.rgs.resource_group_name
   virtual_network_name = module.vnet.vnet_name
   address_prefixes     = ["10.0.1.0/24"]
}


# module "stgacc" {
#   depends_on               = [module.rgs]
#   source                   = "../../modules/stmicrotodouidev01"
#   name                     = "stmicrotodouidev01"
#   resource_group_name      = module.rgs.resource_group_name
#   location                 = module.rgs.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# module "stgcont" {
#   depends_on            = [module.stgacc, module.rgs]
#   source                = "../../modules/stc-microtodoui-dev-eus-01"
#   name                  = "microtodoui-dev-eus-01"
#   storage_account_id    = module.stgacc.id
#   container_access_type = "private"

# }


# module "pip" {
#   depends_on          = [module.rgs]
#   source              = "../../modules/pip-microtodoui-dev-eus-01"
#   name                = "pip-microtodoui-dev-eus-01"
#   resource_group_name = module.rgs.resource_group_name
#   location            = module.rgs.location
#   allocation_method   = "Static"
# }


# module "nic" {
#   depends_on                    = [module.rgs, module.vnet, module.subnet]
#   source                        = "../../modules/nic-vm1-microtodoui-dev-eus-01"
#   name                          = "nic-vm1-microtodoui-dev-eus-01"
#   location                      = module.rgs.location
#   resource_group_name           = module.rgs.resource_group_name
#   subnet_id                     = module.subnet.subnet_id
#   private_ip_address_allocation = "Dynamic"

# }

# module "nsg" {
#   depends_on          = [module.rgs, module.vnet, module.subnet, module.nic]
#   source              = "../../modules/nsg-microtodoui-dev-eus-01"
#   name                = "nsg-microtodoui-dev-eus-01"
#   location            = module.rgs.location
#   resource_group_name = module.rgs.resource_group_name
# }

# module "nsg_association" {
#   depends_on                = [module.rgs, module.vnet, module.subnet, module.nsg, module.nic]
#   source                    = "../../modules/network_security_group_association"
#   subnet_id                 = module.subnet.subnet_id
#   network_security_group_id = module.nsg.nsg_id

# }

# module "vm" {
#   depends_on            = [module.rgs, module.vnet, module.subnet, module.nic, module.nsg, module.nsg_association]
#   source                = "../../modules/vm1-microtodoui-dev-eus-01"
#   name                  = "vm1-microtodoui-dev-eus-01"
#   location              = module.rgs.location
#   resource_group_name   = module.rgs.resource_group_name
#   network_interface_ids = [module.nic.id]
#   vm_size               = "Standard_B1s"


# }


# module "aks" {
#   depends_on          = [module.rgs]
#   source              = "../../modules/aks-microtodoui-dev-eus-01"
#   name                = "aks-microtodoui-dev-eus-01"
#   location            = module.rgs.location
#   resource_group_name = module.rgs.resource_group_name
#   dns_prefix          = "aks-microtodoui-dev-eus-01"
# }   
