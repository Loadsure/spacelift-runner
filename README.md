# Spacelift Runner

Public image for Spacelift. Used to run terraform over version 1.5.x.
It contains all binaries and scripts to execute necessary actions in the
different runs.

## Usage

To get the image use: `docker pull gchr.io/loadsure/spacelift-runner:latest`

To use the image in a spacelift stack you can use the following configuration:

```hcl
# Terraform
resource "spacelift_stack" "my_stack" {
  autodeploy   = true
  branch       = "main"
  description  = "Get hello world output"
  name         = "hello-world"
  project_root = "."
  repository   = "core-infra"
  runner_image = "gchr.io/my-repo/spacelift-runner:latest"
}
```

```yaml
# .spacelift/config.yml
version: "2"

stack_defaults:
  runner_image: gchr.io/my-repo/spacelift-runner:latest
```

## Development

### Requirements

- [Trivy](https://trivy.dev/latest/) - `brew install trivy`
- [Hadolint](https://github.com/hadolint/hadolint) - `brew install hadolint`
