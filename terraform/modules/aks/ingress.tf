resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  namespace  = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "4.10.0"

  create_namespace = true

  values = [<<EOF
controller:
  service:
    type: LoadBalancer
EOF
  ]

  depends_on = [azurerm_kubernetes_cluster.aks]
}
