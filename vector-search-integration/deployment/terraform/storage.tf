# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_storage_bucket" "bucket_load_test_results" {
  name                        = "${var.cicd_runner_project_id}-${var.suffix_bucket_name_load_test_results}"
  location                    = var.region
  project                     = var.cicd_runner_project_id
  uniform_bucket_level_access = true
  force_destroy               = true
  depends_on                  = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

resource "google_storage_bucket" "logs_data_bucket" {
  for_each                    = toset(local.all_project_ids)
  name                        = "${each.value}-logs-data"
  location                    = var.region
  project                     = each.value
  uniform_bucket_level_access = true
  force_destroy               = true

  depends_on = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}
resource "google_storage_bucket" "data_ingestion_pipeline_gcs_root" {
  for_each                    = local.deploy_project_ids
  name                        = "${each.value}-pipeline-artifacts"
  location                    = var.region
  project                     = each.value
  uniform_bucket_level_access = true
  force_destroy               = true

  depends_on = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

resource "google_discovery_engine_data_store" "data_store_staging" {
  location                    = var.data_store_region
  project                     = var.staging_project_id
  data_store_id               = "${var.datastore_name}"
  display_name                = "${var.datastore_name}"
  industry_vertical           = "GENERIC"
  content_config              = "NO_CONTENT"
  solution_types              = ["SOLUTION_TYPE_SEARCH"]
  create_advanced_site_search = false
  provider                    = google.staging_billing_override
  depends_on         = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

resource "google_discovery_engine_search_engine" "search_engine_staging" {
  project        = var.staging_project_id
  engine_id      = "${var.search_engine_name}"
  collection_id  = "default_collection"
  location       = google_discovery_engine_data_store.data_store_staging.location
  display_name   = "Search Engine App Staging"
  data_store_ids = [google_discovery_engine_data_store.data_store_staging.data_store_id]
  search_engine_config {
    search_tier = "SEARCH_TIER_ENTERPRISE"
  }
  provider = google.staging_billing_override
}

resource "google_discovery_engine_data_store" "data_store_prod" {
  location                    = var.data_store_region
  project                     = var.prod_project_id
  data_store_id               = "${var.datastore_name}"
  display_name                = "${var.datastore_name}"
  industry_vertical           = "GENERIC"
  content_config              = "NO_CONTENT"
  solution_types              = ["SOLUTION_TYPE_SEARCH"]
  create_advanced_site_search = false
  provider                    = google.prod_billing_override
  depends_on         = [resource.google_project_service.cicd_services, resource.google_project_service.shared_services]
}

resource "google_discovery_engine_search_engine" "search_engine_prod" {
  project        = var.prod_project_id
  engine_id      = "${var.search_engine_name}"
  collection_id  = "default_collection"
  location       = google_discovery_engine_data_store.data_store_prod.location
  display_name   = "Search Engine App Prod"
  data_store_ids = [google_discovery_engine_data_store.data_store_prod.data_store_id]
  search_engine_config {
    search_tier = "SEARCH_TIER_ENTERPRISE"
  }
  provider = google.prod_billing_override
}

provider "google" {
  region = var.region
}

resource "google_vertex_ai_index" "vector_search_index_staging" {
  project = var.staging_project_id
  region = var.region
  display_name = var.vector_search_display_name
  description = "vector search index for test"
  metadata {
    config {
      dimensions = var.vector_search_embedding_size
      shard_size = var.vector_search_shard_size
      distance_measure_type = "DOT_PRODUCT_DISTANCE"
      approximate_neighbors_count = var.vector_search_approximate_neighbors_count
      algorithm_config {
        tree_ah_config {
        }
      }
    }
  }
  index_update_method = "STREAM_UPDATE"
}

resource "google_vertex_ai_index_endpoint" "vector_search_index_endpoint_staging" {
  project      = var.staging_project_id
  region       = var.region
  display_name = "${var.vector_search_display_name}_endpoint"
  public_endpoint_enabled = true
  depends_on = [google_vertex_ai_index.vector_search_index_staging]
}

resource "google_vertex_ai_index_endpoint_deployed_index" "vector_search_index_deployment_staging" {
    index_endpoint = google_vertex_ai_index_endpoint.vector_search_index_endpoint_staging.id
    index = google_vertex_ai_index.vector_search_index_staging.id
    deployed_index_id = var.vector_search_deployed_index_name
    depends_on = [
      google_vertex_ai_index.vector_search_index_staging,
      google_vertex_ai_index_endpoint.vector_search_index_endpoint_staging
    ]
}

resource "google_storage_bucket" "vector_search_data_bucket_staging" {
  name                        = "${var.prod_project_id}-vector-search-data"
  location                    = var.region
  project                     = var.staging_project_id
  uniform_bucket_level_access = true

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }

  # Use this block to create the bucket only if it doesn't exist
  depends_on = [resource.google_project_service.services]
}

resource "google_vertex_ai_index" "vector_search_index_prod" {
  project = var.prod_project_id
  region = var.region
  display_name = var.vector_search_display_name
  description = "vector search index for test"
  metadata {
    config {
      dimensions = var.vector_search_embedding_size
      distance_measure_type = "DOT_PRODUCT_DISTANCE"
      approximate_neighbors_count = var.vector_search_approximate_neighbors_count
      shard_size = var.vector_search_shard_size
      algorithm_config {
        tree_ah_config {
        }
      }
    }
  }
  index_update_method = "STREAM_UPDATE"
}

resource "google_vertex_ai_index_endpoint" "vector_search_index_endpoint_prod" {
  project      = var.prod_project_id
  region       = var.region
  display_name = "${var.vector_search_display_name}_endpoint"
  public_endpoint_enabled = true
  depends_on = [google_vertex_ai_index.vector_search_index_prod]
}

resource "google_vertex_ai_index_endpoint_deployed_index" "vector_search_index_deployment_prod" {
    index_endpoint = google_vertex_ai_index_endpoint.vector_search_index_endpoint_prod.id
    index = google_vertex_ai_index.vector_search_index_prod.id
    deployed_index_id = var.vector_search_deployed_index_name
    dedicated_resources {
      machine_spec {
        machine_type = var.vector_search_machine_type
      }
      min_replica_count = var.vector_search_min_replica_count
      max_replica_count = var.vector_search_max_replica_count
    }
    depends_on = [
      google_vertex_ai_index.vector_search_index_prod,
      google_vertex_ai_index_endpoint.vector_search_index_endpoint_prod
    ]
}

resource "google_storage_bucket" "vector_search_data_bucket_prod" {
  name                        = "${var.prod_project_id}-vector-search-data"
  location                    = var.region
  project                     = var.prod_project_id
  uniform_bucket_level_access = true

  lifecycle {
    prevent_destroy = true
    ignore_changes  = all
  }

  # Use this block to create the bucket only if it doesn't exist
  depends_on = [resource.google_project_service.services]
}
