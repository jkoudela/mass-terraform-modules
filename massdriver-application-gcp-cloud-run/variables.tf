variable "md_metadata" {
  type        = any
  description = "Massdriver metadata which is provided by the Massdriver deployment runtime"
}

variable "location" {
  type = string
}

variable "container_image" {
  type = string
}

variable "container_port" {
  type = number
}

variable "max_instances" {
  type = number
}

variable "container_concurrency" {
  type        = number
  default     = 0
  description = "The maximum allowed in-flight (concurrent) requests per container."
}

variable "endpoint" {
  type = any
}

variable "vpc_connector" {
  type = string
}
