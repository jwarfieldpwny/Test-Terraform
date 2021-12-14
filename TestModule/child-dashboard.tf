# note the value for dashboard_group that references the `id` property of the signalfx_dashboard_group created in ../main.tf
resource "signalfx_dashboard" "dashboard0" {
  name            = "${var.sfx_prefix} Dashboard 0"
  dashboard_group = signalfx_dashboard_group.dashboardgroup0.id
  time_range      = "-1w"

  variable {
    alias                  = "Host"
    apply_if_exist         = false
    description            = "Dashboard Description"
    property               = "SFHost"
    replace_only           = false
    restricted_suggestions = false
    value_required         = false
    values = [
      "SFDemo",
    ]
    values_suggested = ["SFDemo"]
  }

  chart {
    chart_id = signalfx_text_chart.title0.id
    width    = 12
    height   = 1
    row      = 0
  }

  chart {
    chart_id = signalfx_single_value_chart.activekpods0.id
    width    = 6
    height   = 1
    row      = 1
    column   = 0
  }

  chart {
    chart_id = signalfx_single_value_chart.hostcount0.id
    width    = 6
    height   = 1
    row      = 1
    column   = 6
  }

  chart {
    chart_id = signalfx_time_chart.latencychart0.id
    width    = 12
    height   = 1
    row      = 2
    column   = 0
  }


}

resource "signalfx_text_chart" "title0" {
  name     = " "
  markdown = <<-EOF
    <table width="100%" rules="none">
    <tbody><tr>
    <td align="left" bgcolor="#7200ca" height="80px">
    <font size="5" color="#ffffff">An Example Dashboard</font>
    </td>
    </tr>
    <tr>
    <td align="left" bgcolor="#aa00ff" height="40px">
    <font size="3" color="#ffffff">This is an example dashboard created via Terraform configuration files.</font>
    </td>
    </tr>
    </tbody></table>
  EOF
}
resource "signalfx_single_value_chart" "activekpods0" {
  name         = "Active K8s Pods"
  description  = "This may include \"pause\" containers used internally by K8s"
  program_text = <<-EOF
    A = data('container_cpu_utilization', filter=filter('kubernetes_cluster', '*') and filter('kubernetes_namespace', '*') and filter('deployment', '*', match_missing=True) and filter('sf_tags', '*', match_missing=True), rollup='rate').sum(by=['kubernetes_cluster', 'kubernetes_namespace', 'kubernetes_pod_uid']).count().publish(label='A')
  EOF
  viz_options {
    label        = "A"
    color        = "blue"
    value_suffix = " Pods"
  }
  max_precision = 3
}

resource "signalfx_single_value_chart" "hostcount0" {
  name         = "Host Count"
  description  = "Number of Hosts SignalFx has seen in last 10 minutes"
  program_text = <<-EOF
    A = data('sf.org.numResourcesMonitored', filter=filter('resourceType', 'host')).publish(label='A')
  EOF
  viz_options {
    label        = "A"
    color        = "blue"
    value_suffix = " Hosts"
  }
  max_precision = 3
}

resource "signalfx_time_chart" "latencychart0" {
  name = "Avg Latency"

  program_text = <<-EOF
        A = data('demo.trans.latency').mean(by=['demo_host']).publish(label='A')
        EOF

  time_range = 3600

  plot_type         = "LineChart"
  show_data_markers = true

  legend_options_fields {
    property = "Host"
    enabled  = true
  }

  legend_options_fields {
    property = "hostname"
    enabled  = false
  }

  axis_left {
    label         = "CPU Total Idle"
    low_watermark = 1000
  }
}
