variable "zone_name" {
  type        = string
  description = "aka website, use hyphens instead of dots"
}

variable "cf_zone_id" {
  type = string
  description = "found in CF Overview, on the right side under API.  also in the URI"
}