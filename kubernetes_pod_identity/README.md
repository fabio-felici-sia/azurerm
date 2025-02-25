# kubernetes\_ingress

Module that allows the creation of a pod identity. Check https://docs.microsoft.com/en-us/azure/aks/use-azure-ad-pod-identity#create-an-aks-cluster-with-kubenet-network-plugin for more.

## How to use it

```tf
module "ingress_pod_identity" {
  source = "../kubernetes_pod_identity"

  resource_group_name = "dvopla-d-aks-rg"
  location            = "northeurope"
  identity_name       = "helm-template-pod-identity"
  key_vault           = data.azurerm_key_vault.kv
  tenant_id           = "c767fb1d-a665-4714-9a1a-323a7818b016"
  cluster_name        = "dvopla-d-aks"
  namespace           = "helm-template"

  certificate_permissions = ["get"]
  key_permissions         = ["get"]
  secret_permissions      = ["get"]
}
```

<!-- markdownlint-disable -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 2.80.0, <= 2.99.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 2.99.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_user_assigned_identity.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [null_resource.create_pod_identity](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_permissions"></a> [certificate\_permissions](#input\_certificate\_permissions) | API permissions of the identity to access certificates | `list(string)` | `[]` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_identity_name"></a> [identity\_name](#input\_identity\_name) | Name to use for the identity. | `string` | n/a | yes |
| <a name="input_key_permissions"></a> [key\_permissions](#input\_key\_permissions) | API permissions of the identity to access keys | `list(string)` | `[]` | no |
| <a name="input_key_vault"></a> [key\_vault](#input\_key\_vault) | KeyVault azurerm resource where the identity will connect to. | `any` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | Location of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Kubernetes namespace. | `string` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Resource group of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_secret_permissions"></a> [secret\_permissions](#input\_secret\_permissions) | API permissions of the identity to access secrets | `list(string)` | `[]` | no |
| <a name="input_tenant_id"></a> [tenant\_id](#input\_tenant\_id) | Azure tenant id of the given KeyVault. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity"></a> [identity](#output\_identity) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
