variable "location" {
  description = "Azure region"
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
  default     = "rg-aks-demo"
}

variable "cluster_name" {
  description = "AKS cluster name"
  type        = string
  default     = "aks-demo"
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
  default     = 1
}

variable "node_vm_size" {
  description = "VM size for AKS nodes"
  type        = string
  default     = "Standard_B2s_v2"
}

variable "acr_name" {
  description = "Azure Container Registry name"
  type        = string
}