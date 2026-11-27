[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fgrafana-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/grafana) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/grafana)](https://hub.docker.com/r/readystack/grafana) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/grafana) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# Grafana: ReadyStack build kit

The offline build kit for the Docker image `readystack/grafana:v13.3.2-CE-ubuntu24.04-r1`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v13.3.2-CE-ubuntu24.04-r1](https://github.com/readystack-dev/grafana/releases/tag/v13.3.2-CE-ubuntu24.04-r1)
- Image: [`docker.io/readystack/grafana:v13.3.2-CE-ubuntu24.04-r1`](https://hub.docker.com/r/readystack/grafana/tags), manifest digest `sha256:a74d314bb2162d39f356730b6fb60ee2d6e20adb340280bc113bf0600f2fa121`
- Product page: https://readystack.dev/products/grafana
- Source and build recipe: https://readystack.dev/products/grafana/recipe
- Build trail: https://readystack.dev/products/grafana/trail/v13.3.2-CE-ubuntu24.04-r1
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=grafana

## The image

Single container, single static Go binary (CGO-free) + on-disk web frontend (public/) served from --homepath, foreground process. Observability/dashboards platform. State lives in an EMBEDDED SQLite database at /var/lib/grafana/grafana.db that grafana creates + migrates itself on first boot — NO external/relational DB, no docker-compose, no Kubernetes. The image holds the complete Grafana server but not its data-source and app plugins: on its first start Grafana downloads them (Prometheus, Loki, PostgreSQL, MySQL, Elasticsearch, CloudWatch and others, about 600 MB) from grafana.com into /var/lib/grafana/plugins, and without internet access it starts with only its four built-in data sources (Alertmanager, Azure Monitor, Graphite and TestData). (Grafana CAN be pointed at an external Postgres/MySQL via GF_DATABASE_* env, but the default + this image's self-contained shape is embedded SQLite.)

## Who uses Grafana and why

Operations, SRE and development teams who need dashboards and alerts over their metrics, logs and traces.

Grafana queries, visualises and alerts on metrics, logs and traces wherever they are stored, and lets teams build and share dashboards that mix several data sources.

A typical use: An operations team keeps server metrics in one database and application logs in another. A Grafana dashboard shows both for each service, an alert rule notifies the on-call engineer when errors climb, and the engineer moves from the graph to the matching logs with the same filters.

From the upstream project's own description: https://github.com/grafana/grafana, https://grafana.com/docs/grafana/latest/introduction/.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 12 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`grafana`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-25; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/grafana.

Grafana is distributed under its upstream licence (AGPL-3.0-only); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v13.3.2-CE-ubuntu24.04-r1 release](https://github.com/readystack-dev/grafana/releases/tag/v13.3.2-CE-ubuntu24.04-r1): `ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.tar.gz` (767.0 MB), SHA-256 `5423e43e45fd5675f40ef4abd2fd6c0b364b91c44782b125ab8a9b88ef0da8f3`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.rebuild.json.sigstore ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.tar.gz
cd v13.3.2-CE-ubuntu24.04-r1
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/grafana/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
