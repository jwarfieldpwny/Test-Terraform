resource "signalfx_text_chart" "title0" {
  name     = " "
  markdown = <<-EOF
    <table width="100%" rules="none">
    <tbody><tr>
    <td align="left" bgcolor="#7200ca" height="80px">
    <font size="5" color="#ffffff">Parent/Child Usage</font>
    </td>
    </tr>
    <tr>
    <td align="left" bgcolor="#aa00ff" height="40px">
    <font size="3" color="#ffffff">Metrics about the volume and nature of data that SignalFx is processing and storing for you, such as the number of hosts, containers, custom metrics and detectors in the last 10 minutes.</font>
    </td>
    </tr>
    </tbody></table>
  EOF
}
resource "signalfx_single_value_chart" "hostcount0" {
  name         = "Host Count"
  description  = "Number of Hosts SignalFx has seen in last 10 minutes"
  program_text = <<-EOF
    A = data('sf.org.child.numResourcesMonitored', filter=filter('resourceType', 'host')).sum().publish(label='A')
  EOF
  viz_options {
    label        = "A"
    color        = "blue"
    value_suffix = " Hosts"
  }
  max_precision = 3
}
