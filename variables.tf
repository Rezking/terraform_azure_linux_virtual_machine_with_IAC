variable "resource_group" {
  type = map(any)
  default = {
    "name"     = "Rezking-R12"
    "location" = "centralus"
  }
}
variable "publickeyfile" {
  default = "******************"
}
variable "location_for_others" {
  default = "West US 3"
}
variable "virtualnet" {
  default = ["10.1.0.0/16"]
}
variable "subnet" {
  default = ["10.1.2.0/24"]
}
variable "vm_name" {
  default = "orevm2"
}
variable "vm_size" {
  type    = string
  default = "Standard_B1s"
}
variable "username" {
  type    = string
  default = "admin_user"
}
variable "os_image" {
  type = list(string)
  default = [
    "Canonical", "UbuntuServer", "16.04-LTS", "latest"
  ]
}
variable "vn_name" {
  default = "RezkingRGvnet972"
}
variable "mysubnet" {
  default = "Mysubnet1"
}
variable "nic" {
  default = "mynetworkinter"
}
variable "version1" {
  default = "=3.0.0"
}
