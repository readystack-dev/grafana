# Grafana v13.3.2 — ReadyStack release `v13.3.2-CE-ubuntu24.04-r1`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/grafana:v13.3.2-CE-ubuntu24.04-r1` (linux/amd64). Index digest `sha256:2092ddf4824e76a292095f28ca82044c05a55499c37c1cbe6fe8deb86134e74b` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:a74d314bb2162d39f356730b6fb60ee2d6e20adb340280bc113bf0600f2fa121` [`TARGET_DIGEST.txt`].
- **Upstream:** Grafana v13.3.2 built from source at `v13.3.2` of https://github.com/grafana/grafana — upstream notes: https://github.com/grafana/grafana/releases/tag/v13.3.2 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** none (`FROM scratch`): a chiselled Ubuntu 24.04 runtime, the files Canonical's chisel cut from Ubuntu's own packages (`vendored/chisel/slices.txt`, `vendored/chisel/packages.tsv`); runtime user `grafana`.
- **Build:** `source-rebuild-go`, compiled offline with `--network=none`.
- **Supersedes:** ReadyStack release `v13.3.1-CE-ubuntu24.04-r3`.

## What changed in this release

- Upstream version v13.3.1 → v13.3.2.
- Minimum dependency versions ReadyStack enforces on top of upstream (raised only where upstream's own version was lower); shipped versions from the SBOM [`docs/sbom/SBOM.json`]:
  - `github.com/apache/thrift` at least `v0.25.0`: not raised, upstream already pins `v0.25.0` (shipped: `v0.25.0`)
  - `golang.org/x/crypto` at least `v0.56.0`: not raised, upstream already pins `v0.58.0` (shipped: `v0.58.0`)
  - `google.golang.org/grpc` at least `v1.83.2`: not raised, upstream already pins `v1.84.0` (shipped: `v1.84.0`)
  - `golang.org/x/net` at least `v0.62.0`: not raised, upstream already pins `v0.62.0` (shipped: `v0.62.0`)
  - `github.com/klauspost/compress` at least `v1.18.7`: not raised, upstream already pins `v1.20.3` (shipped: `v1.20.3`)
  - `github.com/getkin/kin-openapi` at least `v0.149.0`: not raised, upstream already pins `v0.151.0` (shipped: `v0.151.0`)
  - `github.com/go-jose/go-jose/v4` at least `v4.1.6`: not raised, upstream already pins `v4.1.6` (shipped: `v4.1.6`)
- This release moves Grafana from 13.3.1 to 13.3.2, a newer release of upstream's 13.3.x line. Upstream's release notes list what changed: https://github.com/grafana/grafana/releases/tag/v13.3.2

## Security status at release (measured 2026-11-24)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `grafana` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/grafana:v13.3.2-CE-ubuntu24.04-r1` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** Port 3000 is plain HTTP; put a TLS proxy in front of Grafana, or set GF_SERVER_PROTOCOL=https with GF_SERVER_CERT_FILE and GF_SERVER_CERT_KEY (a certificate and key readable by uid 472) and override the image's HTTP health check, for example with --health-cmd "/usr/local/bin/rs-probe -k https://127.0.0.1:3000/api/health || exit 1" (otherwise Docker reports the container unhealthy), before exposing it.
- **Before exposing this service:** Grafana publishes its Prometheus metrics at /metrics on port 3000 with no sign-in; set GF_METRICS_BASIC_AUTH_USERNAME and GF_METRICS_BASIC_AUTH_PASSWORD, or GF_METRICS_ENABLED=false, before exposing the port.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:a74d314bb2162d39f356730b6fb60ee2d6e20adb340280bc113bf0600f2fa121`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 9 of 10 use cases passed (10 authored) against the running image [`docs/validation/test-results.json`].
- Failed cases are listed in `docs/validation/FAILED_TESTS.md`.

## Known issues

- **low** (ReadyStack package): VERIFY.md: Open ledger problem RSD-grafana-a5cdfd5e08 (L-A39) still stands: provenance/IMAGE_EVIDENCE.json attestations.predicate_types lists only https://slsa.dev/provenance/v1 and https://spdx.dev/Document;… [`RSD-grafana-a5b2a33c2c`] (carried from `v13.3.1-CE-ubuntu24.04-r3`, recorded there as `RSD-grafana-9b64b3a9f3`)
- **low** (ReadyStack package): When the first start generated the admin password, the entrypoint puts it in Grafana's process environment on every start [`RSD-grafana-59c522870d`] (carried from `v13.2.4-CE-ubuntu24.04-r1`, recorded there as `RSD-grafana-94e4cdf983`)
- **low** (ReadyStack package): VERIFY.md: Same ledger problem RSD-grafana-a5cdfd5e08: `cosign verify-attestation --type https://slsa.dev/verification_summary/v1` has no attestation to verify; IMAGE_EVIDENCE.json attestations.predicate_types… [`RSD-grafana-e374eda30f`] (carried from `v13.3.1-CE-ubuntu24.04-r3`, recorded there as `RSD-grafana-999e050a2a`)
- Build-time check `grafana-dashboards-home` (GET http://127.0.0.1:3000/api/dashboards/home) returned 404, expected 200.

## Defects fixed

- 8 problems found before release and fixed before it shipped (8 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/grafana:v13.3.2-CE-ubuntu24.04-r1
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

