# codex-docker

This repository provides a Docker image for the OpenAI Codex CLI tool.

## Usage

Pull the image from GitHub Container Registry:
```bash
docker pull ghcr.io/k-ishigaki/codex-docker:latest
```

Or build it locally:
```bash
docker build --build-arg CODEX_VERSION=<version> -t codex-docker .
```

Run the CLI:
```bash
docker run --rm codex-docker codex --help
```

## Build Arguments

- `CODEX_VERSION`: The version of the Codex CLI to install (defaults to the version specified in the Dockerfile).

## GitHub Actions

The Docker image is built and published using GitHub Actions.
See `.github/workflows/docker-image.yml` for details.
