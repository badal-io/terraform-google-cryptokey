output "cryptokey_id" {
  value       = "${google_kms_crypto_key.default.id}"
  description = "The ID of the created CryptoKey. Its format is {projectId}/{location}/{keyRingName}/{cryptoKeyName}."
}
