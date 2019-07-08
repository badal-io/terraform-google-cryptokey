# Locals variables : Module logic
locals {
  iam_permissions = [
    for k, v in var.iam:
    { "role" = k, "members" = v}
  ]
}

resource "google_kms_crypto_key" "default" {
  name            = "${var.name}"
  key_ring        = "${var.key_ring}"
  rotation_period = "${var.rotation_period}"
}

resource "google_kms_crypto_key_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    crypto_key_id = "${google_kms_crypto_key.default.id}"
    
    role    = "${trimspace(local.iam_permissions[count.index].role)}"
    members = "${compact(local.iam_permissions[count.index].members)}"

    depends_on = ["google_kms_crypto_key.default"]
}