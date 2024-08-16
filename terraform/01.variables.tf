variable "AWS_PROFILE" {
  description = "AWS profile to use in deployment"
  type = string
  sensitive = true
}

variable "AWS_DEFAULT_REGION" {
  description = "AWS default configured region"
  type = string
  sensitive = false
}

variable "enterprise" {
  description = "Enterprise name for tags and names"
  default = "Personal"
  type = string
  sensitive = false
}
variable "project_name" {
  description = "Project name for tags and names"
  default = "lab"
  type = string
  sensitive = false
}
variable "environment" {
  description = "Environment prefix for tags and names"
  default = ""
  type = string
  sensitive = false
}

variable "ssh_key_name" {
  description = "AWS SSH key name to use in deploys"
  default = "mundose_pin2"
  type = string
  sensitive = true
}

variable "authorized_ssh_ip_list" {
  description = "IP Authorized to access servers thru SSH"
  default = [ "10.0.0.1" ]
  type = list
  sensitive = true
}

variable "my_ip" {
  description = "My IP address"
  type = string
  sensitive = true
}

variable "frontend_exposed_port" {
  description = "Exposed port for frontend access"
  type = string
  sensitive = true
}