# Grafana: ReadyStack build kit

The offline build kit for the Docker image `readystack/grafana:v13.3.1-CE-ubuntu24.04-r3`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v13.3.1-CE-ubuntu24.04-r3](https://github.com/readystack-dev/grafana/releases/tag/v13.3.1-CE-ubuntu24.04-r3)
- Image: [`docker.io/readystack/grafana:v13.3.1-CE-ubuntu24.04-r3`](https://hub.docker.com/r/readystack/grafana/tags), manifest digest `sha256:ca33330e63d5c3c78bd55d868082d337998acd71b37b6c6a80eda458a53a7d6c`
- Product page: https://readystack.dev/products/grafana
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=grafana

Grafana is distributed under its upstream licence (AGPL-3.0-only); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v13.3.1-CE-ubuntu24.04-r3 release](https://github.com/readystack-dev/grafana/releases/tag/v13.3.1-CE-ubuntu24.04-r3): `ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.tar.gz` (766.9 MB), SHA-256 `ebf43c2f0a541e8a27a4b6b4c5f9e9ade335e172033b56175f1b9d25ba37644e`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.rebuild.json.sigstore ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.tar.gz
cd v13.3.1-CE-ubuntu24.04-r3
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/grafana/recipe. The complete kit is the release download. Each release is a tag here.
