# Provenance — Grafana (`v13.3.2-CE-ubuntu24.04-r1`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/grafana/grafana
- Revision built: `v13.3.2` (commit `b8e90ef2a99c8629339e7233a7a813456d87c075`)
- Source tree: `3e6c702252fbe186e2ab44257253f953655d8b5a06281005c27c5c9a47cd5295` over 24136 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-go`; base image `scratch + a chiselled Ubuntu 24.04 runtime (vendored/chisel/slices.txt, packages.tsv)`
- Compiled with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795544548` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/grafana:v13.3.2-CE-ubuntu24.04-r1` — index digest `sha256:2092ddf4824e76a292095f28ca82044c05a55499c37c1cbe6fe8deb86134e74b` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:a74d314bb2162d39f356730b6fb60ee2d6e20adb340280bc113bf0600f2fa121` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/grafana:v13.3.2-CE-ubuntu24.04-r1`

## Pinned inputs, and why

- 41 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 3, image digests 2, language runtimes and toolchains 1, dependency versions readystack sets 12, pins in the kit's dockerfiles 14, readystack's build engine 5, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.trail.json`, published beside this archive and signed with the release key (`ReadyStack-grafana-v13.3.2-CE-ubuntu24.04-r1.trail.json.sigstore`), and readable at https://readystack.dev/products/grafana/trail/v13.3.2-CE-ubuntu24.04-r1.

