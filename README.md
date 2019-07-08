# Terraform Crypto Key
An opinionated terraform module that creates key ring and authoritatively handles IAM permissions for the crypto key


Supports following:
- Provisoon Crypto Key
- Authoritatively manage key IAM Roles


## Usage


```hcl
module "cryptokey" {
    source  = "github.com/muvaki/terraform-google-cryptokey"

    name            = "cryptokey-name"
    key_ring        = "keyring-name"
    rotation_period = "5"

    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
    }
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| project | Project ID - if not provided it will get it from provider settings | string. | "" | no |
| name | Name of the crypto key | string | - | yes |
| key_ring | Name of the key ring that the crypto key belongs to | string | - | yes |
| rotation_period | The rotation period has the format of a decimal number with up to 9 fractional digits, followed by the letter s (seconds). It must be greater than a day (ie, 86400). to | string | - | yes |
| iam |  set of roles with their respective access accounts | map | {} | no |
| module_dependency | Pass an output from another variable/module to create dependency | string | "" | no |

### iam Inputs

IAM input should be passed as roles (key) with list of members as a list value. Roles can be passed as either custom role names (project/project-id/roles/role-name) or standard predefined gcp roles (roles/role-name). Members list is allowed to only have the following prefixes: domain, serviceAccount, user or group.

```hcl
    iam = {
        "roles/editor" = [
            "user:admin@muvaki.com",
            "serviceAccount:1111111111@cloudbuild.gserviceaccount.com"
        ],
        "project/muvaki/roles/superAdmin" = [
            "group:superadmins@muvaki.com"
        ]
```

## Outputs

| Name | Description | 
|------|-------------|
| cryptokey_id | The ID of the created CryptoKey. Its format is {projectId}/{location}/{keyRingName}/{cryptoKeyName}. |


## Docs:

module reference docs: 
- terraform.io (v0.12.3)
- GCP [KMS](https://cloud.google.com/kms/docs/
- GCP [IAM](https://cloud.google.com/iam/)

### LICENSE

MIT License