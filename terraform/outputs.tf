output "cluster_name" {
  value = module.aks.cluster_name
}

output "resource_group" {
  value = module.aks.resource_group_name
}

output "kubeconfig" {
  value     = module.aks.kubeconfig
  sensitive = true
}

output "acr_login_server" {
  value = module.aks.acr_login_server
}

output "acr_name" {
  value = module.aks.acr_name
}
