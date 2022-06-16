locals {
  cluster_type           = "gke-autopilot-test-public"
  network_name           = "gke-autopilot-test-public-network"
  subnet_name            = "gke-autopilot-test-public-subnet"
  master_auth_subnetwork = "gke-autopilot-test-public-master-subnet"
  pods_range_name        = "ip-range-pods-gke-autopilot-test-public"
  svc_range_name         = "ip-range-svc-gke-autopilot-test-public"
  subnet_names           = [for subnet_self_link in module.gcp-network.subnets_self_links : split("/", subnet_self_link)[length(split("/", subnet_self_link)) - 1]]
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.gke.endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.gke.ca_certificate)
}

module "gke" {
  source                          = "terraform-google-modules/kubernetes-engine/google"
  project_id                      = var.project_id
  name                            = "${local.cluster_type}-cluster"
  regional                        = true
  region                          = var.region
  network                         = module.gcp-network.network_name
  subnetwork                      = local.subnet_names[index(module.gcp-network.subnets_names, local.subnet_name)]
  ip_range_pods                   = local.pods_range_name
  ip_range_services               = local.svc_range_name
  release_channel                 = "REGULAR"
  enable_vertical_pod_autoscaling = true
}

module "gke_auth" {
  // module for kubectl config output. see outputs.tf
  source = "terraform-google-modules/kubernetes-engine/google//modules/auth"

  project_id   = var.project_id
  location     = module.gke.location
  cluster_name = module.gke.name
}
