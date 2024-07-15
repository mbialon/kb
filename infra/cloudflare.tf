terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.37.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.api_token
}

variable "api_token" {
  type = string
}

variable "account_id" {
  type = string
}

variable "zone_id" {
  type = string
}

resource "cloudflare_pages_project" "kb" {
  account_id        = var.account_id
  name              = "mbialon-kb"
  production_branch = "main"

  source {
    type = "github"
    config {
      owner                         = "mbialon"
      repo_name                     = "kb"
      production_branch             = "main"
      pr_comments_enabled           = true
      deployments_enabled           = true
      production_deployment_enabled = true
      preview_branch_includes       = ["*"]
    }
  }

  build_config {
    build_command   = "mkdocs build"
    destination_dir = "site"
  }

  deployment_configs {
    preview {
      environment_variables = {
        PYTHON_VERSION = "3.11"
      }
    }
    production {
      environment_variables = {
        PYTHON_VERSION = "3.11"
      }
    }
  }
}

resource "cloudflare_pages_domain" "kb" {
  account_id   = var.account_id
  project_name = cloudflare_pages_project.kb.name
  domain       = "kb.bialon.net"
}

resource "cloudflare_record" "kb" {
  zone_id = var.zone_id
  type    = "CNAME"
  name    = "kb.bialon.net"
  value   = cloudflare_pages_project.kb.subdomain
  proxied = true
}
