resource "signalfx_detector" "cpu_historical_norm" {
  name         = "${var.sfx_prefix} CPU utilization % greater than historical norm"
  description  = "Alerts when CPU usage for this host for the last 30 minutes was significantly higher than normal, as compared to the last 24 hours"
  program_text = <<-EOF
    from signalfx.detectors.against_recent import against_recent
    A = data('cpu.utilization').publish(label='A', enable=True)
    against_recent.detector_mean_std(stream=A, current_window='30m', historical_window='24h', fire_num_stddev=3, clear_num_stddev=2.5, orientation='above', ignore_extremes=True, calculation_mode='vanilla').publish('CPU utilization is significantly greater than normal, and increasing')
  EOF
  rule {
    detect_label       = "CPU utilization is significantly greater than normal, and increasing"
    severity           = "Warning"
    parameterized_body = "Some message body"
  }
}
