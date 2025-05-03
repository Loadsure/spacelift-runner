# Spacelift Runner

Public image for Spacelift. Used to run terraform over version 1.5.x.
It contains all binaries and scripts to execute nessecary actions in the
different runs.

## Usage

To get the image use: `docker pull gchr.io/loadsure/spacelift-runner:latest`

## Development

### Requirements

- [Go Task](https://taskfile.dev/) - `brew install go-task`
- [Trivy](https://trivy.dev/latest/) - `brew install trivy`
- [Hadolint](https://github.com/hadolint/hadolint) - `brew install hadolint`
