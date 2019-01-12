data "external" "flatten" {
  program = ["docker", "run", "muvaki/terraform-flatten:0.1.0", "iam", "${jsonencode(var.iam)}"]
}

// Locals variables : Module logic
locals {
  iam_permissions = "${compact(split(",", data.external.flatten.result["iam"]))}"
}

resource "google_kms_crypto_key" "default" {
  name            = "${var.name}"
  key_ring        = "${var.key_ring}"
  rotation_period = "${var.rotation_period}"
}

resource "google_kms_crypto_key_iam_binding" "default" {
    count     = "${length(local.iam_permissions) > 0 ? length(local.iam_permissions) : 0}"

    crypto_key_id = "${google_kms_crypto_key.default.id}"
    
    role      = "${trimspace(element(split("|", local.iam_permissions[count.index]), 0))}"
    members   = [
      "${compact(split(" ", element(split("|", local.iam_permissions[count.index]), 1)))}"
    ]

    depends_on = ["google_kms_crypto_key.default"]
}