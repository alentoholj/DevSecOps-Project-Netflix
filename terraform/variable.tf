variable "prefix" {
  description = "Prefix for each name in this LAB"
  type        = string
}

variable "location" {
  description = "Location where we will put our resources"
  type        = string
}

variable "tag" {
  description = "Tags that will be attached to the resources"
  type        = map(string)
}