provider "signalfx" {
  auth_token = var.access_token
  api_url    = "https://api.${var.realm}.signalfx.com"
}

module "Test Module" {
  source     = "./Test Module"
  sfx_prefix = var.sfx_prefix
}
