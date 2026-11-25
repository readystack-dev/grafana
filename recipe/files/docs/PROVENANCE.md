# Provenance — Grafana (`v13.3.1-CE-ubuntu24.04-r3`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/grafana/grafana
- Revision built: `v13.3.1` (commit `5db6ba887630c7fa12e5bfd063f2fa854025468c`)
- Source tree: `ebc4917037d7fdc9a713db1a8912b58cad8403cc0c9eafc8a81ad3366640c602` over 24130 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-go`; base image `scratch + a chiselled Ubuntu 24.04 runtime (vendored/chisel/slices.txt, packages.tsv)`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795161055` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/grafana:v13.3.1-CE-ubuntu24.04-r3` — index digest `sha256:e0e441434f92e3ea4c5dc528bb25f0ad333219527c4d236738783f24ff5a09b9` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:ca33330e63d5c3c78bd55d868082d337998acd71b37b6c6a80eda458a53a7d6c` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/grafana:v13.3.1-CE-ubuntu24.04-r3`

## Pinned inputs, and why

- 41 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 2, language runtimes and toolchains 1, dependency versions readystack sets 12, pins in the kit's dockerfiles 14, readystack's build engine 5, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.trail.json`, published beside this archive and signed with the release key (`ReadyStack-grafana-v13.3.1-CE-ubuntu24.04-r3.trail.json.sigstore`), and readable at https://readystack.dev/products/grafana/trail/v13.3.1-CE-ubuntu24.04-r3.

