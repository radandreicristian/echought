FROM rust:latest as build

# Create a new empty project (used for caching dependency install)
RUN USER=root cargo new --bin cache_trigger
WORKDIR /cache_trigger

# Copy the dependency manifests (Cargo.toml, Cargo.lock) only
COPY Cargo.toml Cargo.lock ./

# Build and cache the dependencies
RUN cargo build --release

WORKDIR /workspace

COPY . .

RUN cargo build --release

FROM debian:buster-slim as run

COPY --from=build /workspace/target/release/api /usr/local/bin/api

CMD ["api"]