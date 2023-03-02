variable "resource_group" {
    default = "linux-rg100"
}
variable "location" {
    default = "southcentralus"
}
variable "tfnsg" {
    default = "tfnsg"
}
variable "public_Ip" {
    default = "linux_pip"
}
variable "Vnet_Name" {
    default = "linux-VNet"
}
variable "Vnet_address_space" {
    default = "172.16.0.0/16"
}
variable "subnet_name" {
    default = "Linux_Subnet"
}
variable "address_prefix" {
    default = "172.16.0.0/26"
}

variable "Network_Interface_Name" {
    default = "linuxnic"
}

#vm variables
variable "admin_user" {
    default = "azadmin"
}

variable "image_publisher" {
    default = "Canonical"
}
variable "image_offer" {
    default = "UbuntuServer"
}
variable "image_sku" {
    default = "18_04-lts-gen2"
}
variable "image_version" {
    default = "18.04.202111080"
}

variable "OS_Disk_Size_in_GB" {
    default = 40
}

variable "VM_SKU" {
    default = "Standard_B4ms"
}
variable "VM_NAME" {
    default = "linuxubntu"
}
variable "admin_password" {
    default = "Password@123"
}
