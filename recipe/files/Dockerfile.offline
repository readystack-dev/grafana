# GENERATED L-009 hermetic build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned bases from BASE_IMAGE_DIGESTS.lock; vendored Go tree + debs from Dockerfile.vendor.
FROM golang:1.27.4-bookworm@sha256:4fa7c968ba93f1635670522dbb01a2c78150443e1385746924566079f36570ea AS build_grafana
WORKDIR /src
COPY vendored/grafana-src/ .
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOWORK=off GOFLAGS="-mod=vendor -buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1795161055
RUN go build -trimpath -ldflags='-s -w -X main.version=13.3.1' -o /grafana ./pkg/cmd/grafana && /grafana --version && \
    { readelf -lW /grafana | sed -n 's/.*Requesting program interpreter: \(.*\)]$/\1/p'; readelf -dW /grafana | sed -n 's/.*Shared library: \[\(.*\)\]$/\1/p'; } > /grafana.needs
# rs-probe: the HEALTHCHECK helper (standard library only, from the kit's rs-probe.go)
FROM golang:1.27.4-bookworm@sha256:4fa7c968ba93f1635670522dbb01a2c78150443e1385746924566079f36570ea AS build_rs_probe
WORKDIR /probe
COPY rs-probe.go main.go
COPY rs-probe.mod go.mod
ENV CGO_ENABLED=0 GOTOOLCHAIN=local GOFLAGS="-buildvcs=false" GOPROXY=off SOURCE_DATE_EPOCH=1795161055
RUN go build -trimpath -ldflags='-s -w' -o /rs-probe .
# the chiselled rootfs (vendored/chisel, cut by Dockerfile.vendor), the service user, the binaries
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289 AS rootfs
ARG SOURCE_DATE_EPOCH=1795161055
ADD vendored/chisel/rootfs.tar /rootfs/
RUN printf 'grafana:x:472:472::/usr/share/grafana:/bin/sh\n' >> /rootfs/etc/passwd && printf 'grafana:x:472:\n' >> /rootfs/etc/group && \
    mkdir -p /rootfs/usr/share/grafana /rootfs/var/lib/grafana /rootfs/var/lib/grafana/plugins /rootfs/var/log/grafana /rootfs/etc/grafana /rootfs/etc/grafana/provisioning /rootfs/etc/grafana/provisioning/datasources /rootfs/etc/grafana/provisioning/dashboards /rootfs/etc/grafana/provisioning/notifiers /rootfs/etc/grafana/provisioning/plugins /rootfs/etc/grafana/provisioning/access-control /rootfs/etc/grafana/provisioning/alerting && chown -R 472:472 /rootfs/usr/share/grafana /rootfs/var/lib/grafana /rootfs/var/lib/grafana/plugins /rootfs/var/log/grafana /rootfs/etc/grafana /rootfs/etc/grafana/provisioning /rootfs/etc/grafana/provisioning/datasources /rootfs/etc/grafana/provisioning/dashboards /rootfs/etc/grafana/provisioning/notifiers /rootfs/etc/grafana/provisioning/plugins /rootfs/etc/grafana/provisioning/access-control /rootfs/etc/grafana/provisioning/alerting
COPY --from=build_grafana /grafana /rootfs/usr/share/grafana/bin/grafana
COPY --from=build_grafana /grafana.needs /tmp/needs/grafana
COPY --from=build_rs_probe /rs-probe /rootfs/usr/local/bin/rs-probe
COPY --from=build_grafana /src/public /rootfs/usr/share/grafana/public
COPY --from=build_grafana /src/conf /rootfs/usr/share/grafana/conf
COPY readystack-entrypoint.sh /rootfs/usr/local/bin/readystack-entrypoint.sh
RUN chmod 755 /rootfs/usr/share/grafana/bin/grafana /rootfs/usr/local/bin/rs-probe && \
    chown -R 472:472 /rootfs/usr/share/grafana/public && \
    chown -R 472:472 /rootfs/usr/share/grafana/conf && \
    chown 472:472 /rootfs/usr/local/bin/readystack-entrypoint.sh && \
    chmod 0755 /rootfs/usr/local/bin/readystack-entrypoint.sh
RUN --mount=type=bind,source=vendored/chisel,target=/chisel set -eu; \
    for n in /tmp/needs/*; do while read -r lib; do [ -n "$lib" ] || continue; \
      case "$lib" in /*) [ -e "/rootfs$lib" ] ;; *) [ -n "$(find /rootfs/usr/lib /rootfs/usr/lib64 -name "$lib" 2>/dev/null | head -1)" ] ;; esac || \
      { echo "$(basename "$n") needs $lib, which the chiselled rootfs does not have: add its slice to runtime_base.slices" >&2; exit 1; }; \
    done < "$n"; done; rm -rf /tmp/needs; \
    [ -e /rootfs/etc/os-release ] || { echo "no /etc/os-release: base-files_release-info is missing" >&2; exit 1; }; \
    [ "$(grep -c '^Package: ' /rootfs/var/lib/dpkg/status)" = "$(wc -l < /chisel/packages.tsv)" ] || \
      { echo "/var/lib/dpkg/status does not list every package of vendored/chisel/packages.tsv" >&2; exit 1; }; \
    rm -rf /rootfs/var/log/dpkg.log /rootfs/var/log/alternatives.log /rootfs/var/log/apt /rootfs/var/cache/ldconfig/aux-cache /rootfs/var/cache/fontconfig
FROM scratch
ARG SOURCE_DATE_EPOCH=1795161055
COPY --from=rootfs /rootfs/ /
ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin GF_PATHS_HOME=/usr/share/grafana GF_PATHS_DATA=/var/lib/grafana GF_PATHS_LOGS=/var/log/grafana GF_PATHS_PLUGINS=/var/lib/grafana/plugins GF_PATHS_PROVISIONING=/etc/grafana/provisioning PATH=/usr/share/grafana/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
LABEL org.opencontainers.image.licenses="AGPL-3.0-only"
LABEL com.readystack.license.disclosure="This image includes Grafana (https://github.com/grafana/grafana), licensed under AGPL-3.0-only. Modifications: the Go workspace files go.work and go.work.sum are deleted so the root module vendors and builds alone (its go.mod replace directives keep every in-tree module the server uses), and the build raises Go-module dependency versions in go.mod and go.sum where upstream's are older than the fixed, upstream-published releases (security updates; no Grafana source file is edited); full diff of every upstream file the build changes at https://readystack.dev/source/grafana/v13.3.1/grafana-v13.3.1-readystack.patch. Operating-system packages come from Ubuntu's archive, unmodified. ReadyStack license holders have access to the image build recipe and patched-package manifest on request via contact@readystack.dev."
LABEL org.opencontainers.image.title="Grafana"
LABEL org.opencontainers.image.description="Grafana provides a unified observability platform for visualizing metrics and logs. It enables teams to monitor system health and troubleshoot issues through customizable, real-time dashboards."
LABEL org.opencontainers.image.source="https://github.com/grafana/grafana"
LABEL org.opencontainers.image.version="v13.3.1-CE-ubuntu24.04-r3"
LABEL org.opencontainers.image.revision="5db6ba887630c7fa12e5bfd063f2fa854025468c"
HEALTHCHECK --interval=5s --timeout=30s --start-period=30s \
  CMD /usr/local/bin/rs-probe http://127.0.0.1:3000/api/health || exit 1
USER grafana
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/readystack-entrypoint.sh"]
