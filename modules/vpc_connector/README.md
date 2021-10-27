# VPC Serverless Connector Beta

This example deploys a single vpc serverless connector in the us-central1 region.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| project\_id | Project in which the vpc connector will be deployed. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| connector\_ids | ID of the VPC serverless connector that was deployed. |
| project\_id | The ID of the Google Cloud project being used |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->


### TODO:
fix
```
  # module.sun_vpc_connector.module.serverless-connector.google_vpc_access_connector.connector_beta["central-serverless"] must be replaced
-/+ resource "google_vpc_access_connector" "connector_beta" {
      ~ id             = "projects/static-emblem-327016/locations/europe-west2/connectors/central-serverless" -> (known after apply)
      ~ max_throughput = 700 -> 300 # forces replacement
        name           = "central-serverless"
      ~ self_link      = "projects/static-emblem-327016/locations/europe-west2/connectors/central-serverless" -> (known after apply)
      ~ state          = "READY" -> (known after apply)
        # (6 unchanged attributes hidden)

      ~ subnet {
            name       = "serverless-subnet"
          ~ project_id = "static-emblem-327016" -> (known after apply)
        }
    }
```