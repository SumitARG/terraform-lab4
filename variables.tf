variable "loc" {
    description = "Default Azure region"
    default     =   "westeurope"
}

variable "tags" {
    default     = {
        source  = "citadel"
        env     = "training"
    }
}

variable "webapplocs" {
    description = "List of locations for web apps"
    type        = "list"
    default     = []
}
variable "clientsecret"{
    default = "Jg-xsz_p7Ru/5TOiRke_F1fsimnVUVJ8"
}

variable "subscriptionid"{
    default = "32c32163-f026-41ed-9503-3b0ee6ec5540"
}
