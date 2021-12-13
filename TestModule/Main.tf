resource "signalfx_dashboard_group" "Test_Dashboard_Group" {
  name        = "${var.sfx_prefix} Test_Dashboard_Group"
  description = "Testing_Dashboard_Group"
}
