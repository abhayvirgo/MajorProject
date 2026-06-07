# check new versions here: https://github.com/kaito-project/kaito/releases
locals {
  kaito_workspace_version = "0.9.1"
  kaito_ragengine_version = "0.9.1"
}

# Install the kaito-workspace chart
resource "helm_release" "kaito_workspace" {
  name             = "kaito-workspace"
  chart            = "https://raw.githubusercontent.com/kaito-project/kaito/refs/heads/gh-pages/charts/kaito/workspace-${local.kaito_workspace_version}.tgz"
  namespace        = "kaito-workspace"
  create_namespace = true

  set = [
    {
      name  = "clusterName"
      value = azurerm_kubernetes_cluster.aks.name
    },
    {
      name  = "defaultNodeImageFamily"
      value = "ubuntu"
    },
    {
      name  = "featureGates.gatewayAPIInferenceExtension"
      value = "true"
    },
    {
      name  = "featureGates.disableNodeAutoProvisioning"
      value = "false"
    },
    {
      name  = "gpu-feature-discovery.nfd.enabled"
      value = "true"
    },
    {
      name  = "gpu-feature-discovery.gfd.enabled"
      value = "true"
    },
    {
      name  = "nvidiaDevicePlugin.enabled"
      value = "true"
    }
  ]

  depends_on = [azurerm_kubernetes_cluster_node_pool.nc24ads_a100_v6]
}

# Install the kaito-ragengine chart
resource "helm_release" "kaito_ragengine" {
  name             = "kaito-ragengine"
  chart            = "https://raw.githubusercontent.com/kaito-project/kaito/refs/heads/gh-pages/charts/kaito/ragengine-${local.kaito_ragengine_version}.tgz"
  namespace        = "kaito-ragengine"
  create_namespace = true
}