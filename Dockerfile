FROM alpine:3.22.0

RUN apk add --no-cache openssl ca-certificates curl tar nodejs npm python3 uv ripgrep

ARG CODEX_VERSION=rust-v0.5.0

RUN set -eux; \
    ARCH=$(uname -m); \
    OS=$(uname -s | tr '[:upper:]' '[:lower:]'); \
    case "$ARCH:$OS" in \
        x86_64:linux) TGT=x86_64-unknown-linux-musl;; \
        aarch64:linux) TGT=aarch64-unknown-linux-musl;; \
        x86_64:darwin) TGT=x86_64-apple-darwin;; \
        aarch64:darwin) TGT=aarch64-apple-darwin;; \
        *) echo "Unsupported platform: $ARCH-$OS"; exit 1;; \
    esac; \
    CODEX_URL="https://github.com/openai/codex/releases/download/${CODEX_VERSION}/codex-${TGT}.tar.gz"; \
    curl -fsSL "$CODEX_URL" -o /tmp/codex.tar.gz; \
    tar -xzf /tmp/codex.tar.gz -C /usr/local/bin; \
    mv /usr/local/bin/codex-* /usr/local/bin/codex; \
    chmod +x /usr/local/bin/codex; \
    chown root:root /usr/local/bin/codex; \
    rm /tmp/codex.tar.gz
