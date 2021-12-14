# Charts as Code with Terraform Sample Repo

## Resources Included with this Example
This repo is collection of Terraform files to spin up these resources in an Observability Cloud org:
* 1 Dashboard Group
* 1 Dashboard associated to the Dashboard Group
* 4 Charts in the Dashboard:
  * A Text Chart to call out the purpose of the Dashboard
  * Two Single Value Charts to track the current state of a single value
  * A Time Chart to track a metric over time
* 1 Detector

### Module Structure
This project follows a Terraform pattern that builds a "root" module that simply calls other sub-modules.  With the limited set of resources in this project, everything here _could_ just go into a single file.  The design on this sample project, however, hints at what a multi-module, complex Terraform plan might look like. For more information on Terraform's module structure, see the tutorials [here](https://learn.hashicorp.com/collections/terraform/modules).

### Variables
This project is not intended as a deep dive into Terraform.  However, it's worth noting that this sample project uses Terraform variables.  Variables are used in any place that the `realm`, `access_token` variables are required by the Splunk/SignalFx provider resource or dashboard and chart resources. The `sfx_prefix` is simply an arbitrary value that's helpful to prefix Terraform-created resources in a shared sandbox or demo environment.

## Deploying The Resources
1. [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) on a machine that will execute the Terraform plan.
2. Get the proper `realm` and `access_token` for the target environment in which to deploy these resources
3. From the root path of this project, [initialize Terraform](https://www.terraform.io/docs/cli/commands/init.html) by executing:
```bash
terraform init
```
4. Generate a [Terraform plan](https://www.terraform.io/docs/cli/commands/plan.html) for these resources:
```bash
terraform plan -var="access_token=<your-access-token>" -var="realm=<your-realm>" -var="sfx_prefix=<arbitrary-string-of-your-choosing>"
```
5. Take a look at the resources that will be deployed.  If everything looks acceptable and passes the validation, [apply](https://www.terraform.io/docs/cli/commands/apply.html) the plan:
```bash
terraform apply -var="access_token=<your-access-token>" -var="realm=<your-realm>" -var="sfx_prefix=<arbitrary-string-of-your-choosing>"
```
