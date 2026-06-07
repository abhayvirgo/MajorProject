resource "azurerm_kubernetes_cluster_node_pool" "nc24ads_a100_v6" {
  name                        = "workndepool"
  temporary_name_for_rotation = "worknotemp"
  kubernetes_cluster_id       = azurerm_kubernetes_cluster.aks.id
  mode                        = "User"
  vm_size                     = "Standard_D2ads_v6"
  node_count                  = 1
  auto_scaling_enabled        = true
  min_count                   = 1
  max_count                   = 2
  gpu_driver                  = "None"
  os_type                     = "Linux"
  zones                       = []
  os_disk_size_gb             = 64
  os_disk_type                = "Ephemeral" # "Managed" 
  priority                    = "Spot"
  eviction_policy             = "Delete"
  #   gpu_instance = "MIG1g"

  node_labels = {
    "kubernetes.azure.com/scalesetpriority" = "spot"
    "apps"                                  = "phi-4"
  }

  node_taints = [
    "kubernetes.azure.com/scalesetpriority=spot:NoSchedule",
  ]
  tags = {
    Environment = "Free-Tier-Testing"
  }
}