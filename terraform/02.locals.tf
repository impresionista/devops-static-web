locals {
  name_tag_prefix  = "${var.enterprise}-${var.project_name}-"
  name_tag_sufix   = ("${var.environment}" == "" ? "${var.environment}" : "-${var.environment}")
}