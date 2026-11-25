#!/bin/sh
# ReadyStack grafana entrypoint. Grafana creates its first admin (GF_SECURITY_ADMIN_USER, default "admin")
# when its user table is empty, with GF_SECURITY_ADMIN_PASSWORD, whose built-in default is "admin" — a known
# login on every install nobody configured. Unless the operator supplies a password, generate one before
# that first start and write it ONLY to $GF_PATHS_DATA/initial_admin_password (mode 600).
set -e
# GF_<NAME>__FILE: read the secret from that file into GF_<NAME> (upstream's image does this in its run.sh, which
# this image does not use; grafana itself ignores __FILE, so without this a __FILE password left the built-in default).
for v in $(env | sed -n 's/^\(GF_[A-Za-z0-9_]*\)__FILE=.*/\1/p'); do
  eval "f=\${${v}__FILE}"; eval "cur=\${${v}:-}"
  if [ -n "$cur" ]; then echo "grafana: both $v and ${v}__FILE are set; set only one" >&2; exit 1; fi
  if [ ! -r "$f" ]; then echo "grafana: ${v}__FILE=$f is not readable by $(id -un)" >&2; exit 1; fi
  eval "$v=\$(cat \"\$f\")"; export "$v"; unset "${v}__FILE"
done
DATA="${GF_PATHS_DATA:-/var/lib/grafana}"
PWF="$DATA/initial_admin_password"
if [ -z "${GF_SECURITY_ADMIN_PASSWORD:-}" ]; then
  if [ -s "$PWF" ]; then
    GF_SECURITY_ADMIN_PASSWORD="$(cat "$PWF")"; export GF_SECURITY_ADMIN_PASSWORD
  elif [ ! -f "$DATA/grafana.db" ]; then
    ( umask 077; head -c 18 /dev/urandom | base64 | tr -dc 'A-Za-z0-9' > "$PWF" )
    GF_SECURITY_ADMIN_PASSWORD="$(cat "$PWF")"; export GF_SECURITY_ADMIN_PASSWORD
    echo "grafana: GF_SECURITY_ADMIN_PASSWORD not set — the first admin's password was generated into $PWF"
  fi
fi
exec /usr/share/grafana/bin/grafana server --homepath=/usr/share/grafana --packaging=docker "$@"
