# Deploy GKE Test Cluster 
 
Creates a GKE test cluster on Google Cloud Compute, outputs kubectl config for access

## Requires gcloud cli setup and application default token

### Install gcloud

https://cloud.google.com/sdk/docs/install

### gcloud init

Run gcloud init and create a new gcp project

Your new gcp project ID will be needed later.

```
gcloud init
```

### Enable gcloud ADP login which Terraform will use

```
gcloud auth application-default login
```

### Enable billing account for your new project

The GCP proejct will also need billing enabled and a valid credit card. Ideally the base install provided by this module will be in the free tier but based upon your usage this may not be the case. Depending on what you deploy to the test cluster. https://cloud.google.com/billing/docs/how-to/modify-project


### Enable GCP APIs for project

In order to operate you must activate the following APIs on your GCP project:

```
gcloud projects list
gcloud config set project YOUR_GPC_PROJECT_ID
gcloud services list --available
gcloud services enable container.googleapis.com
gcloud services enable compute.googleapis.com
```

### Update Terraform project_id inputs with your project_id

Replace YOUR_GCP_PROJECT_ID in google-provider.tf
Replace YOUR_GCP_PROJECT_ID in variables.tf


## Run Terraform
```
terraform init
terraform plan
terraform apply
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.25.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.11.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp-network"></a> [gcp-network](#module\_gcp-network) | terraform-google-modules/network/google | >= 4.0.1, < 5.0.0 |
| <a name="module_gke"></a> [gke](#module\_gke) | terraform-google-modules/kubernetes-engine/google | n/a |
| <a name="module_gke_auth"></a> [gke\_auth](#module\_gke\_auth) | terraform-google-modules/kubernetes-engine/google//modules/auth | n/a |

## Resources

| Name | Type |
|------|------|
| [kubernetes_pod.nginx-example](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/pod) | resource |
| [kubernetes_service.nginx-example](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/service) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to host the cluster in | `string` | `"YOUR_GCP_PROJECT_ID"` | no |
| <a name="input_region"></a> [region](#input\_region) | The region the cluster in | `string` | `"us-central1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_name"></a> [cluster\_name](#output\_cluster\_name) | Cluster name |
| <a name="output_kubeconfig_raw"></a> [kubeconfig\_raw](#output\_kubeconfig\_raw) | n/a |
| <a name="output_location"></a> [location](#output\_location) | n/a |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The project ID the cluster is in |
| <a name="output_region"></a> [region](#output\_region) | The region in which the cluster resides |
| <a name="output_service_account"></a> [service\_account](#output\_service\_account) | The service account to default running nodes as if not overridden in `node_pools`. |
| <a name="output_subnet_names"></a> [subnet\_names](#output\_subnet\_names) | The names of the subnet being created |
| <a name="output_zones"></a> [zones](#output\_zones) | List of zones in which the cluster resides |
<!-- END_TF_DOCS -->
