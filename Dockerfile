FROM rust:1.85-slim-bookworm AS builder

ENV CARGO_PROFILE_RELEASE_LTO=thin

WORKDIR /src
RUN apt-get update && \
    apt-get install -y --no-install-recommends pkg-config libssl-dev git && \
    rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 https://github.com/openai/codex.git .
WORKDIR /src/codex-rs
RUN cargo build --release --locked

FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends libssl3 ca-certificates && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /src/codex-rs/target/release/codex /usr/local/bin/codex
ENTRYPOINT ["codex"]
CMD ["--help"]
