variable "module_dependency" {
  type        = "string"
  default     = ""
  description = "This is a dummy value to great module dependency"
}

variable "name" {
    description = "name for the crypto key"
    type        = "string"
}


variable "key_ring" {
    description = "name of the Key Ring the cryptokey belongs to"
    type        = "string"
}

variable "rotation_period" {
    description = "key rotation time"
    type        = "string"
    default     = "604800s"
}

variable "iam" {
    description = "Authoratative service account role binding"
    type        = "map"
    default     = {}
}