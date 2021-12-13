resource "signalfx_dashboard_group" "Test Dashboard Group" {
  name        = "${var.sfx_prefix} Test Dashboard Group"
  description = "Testing Dashboard Group"
}
