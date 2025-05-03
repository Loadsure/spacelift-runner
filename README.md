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
  runner_image = "gchr.io/loadsure/spacelift-runner:latest"
}
```

```yaml
# .spacelift/config.yml
version: "2"

stack_defaults:
  runner_image: gchr.io/loadsure/spacelift-runner:latest
```

### Build

The image is built in GitHub Actions and pushed to the Github Container Registry. Its built on push to main, and listens
to changes on the `Dockerfile` and `.github/workflows/build.yml` files.

## Development

### Requirements

- [Trivy](https://trivy.dev/latest/) - `brew install trivy`
- [Hadolint](https://github.com/hadolint/hadolint) - `brew install hadolint`

### Build and push locally

```bash
export GITHUB_TOKEN=<your_github_token>
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker build -t gchr.io/loadsure/spacelift-runner:latest .
docker push gchr.io/loadsure/spacelift-runner:latest
```
