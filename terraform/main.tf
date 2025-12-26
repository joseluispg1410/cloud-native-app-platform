module "aks" {
  source = "./modules/aks"

  location            = var.location
  resource_group_name = var.resource_group_name
  cluster_name        = var.cluster_name
  node_count          = var.node_count
  node_vm_size        = var.node_vm_size

  acr_name = var.acr_name
}
