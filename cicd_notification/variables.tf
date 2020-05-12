variable "application_name" {
  type = string
}

variable "subject" {
  type = string
}

variable "message" {
  type = string
}

variable "rule" {
  type = string
}

variable "slack_url" {
  type = string
  description = "the slack url to provide"
}
