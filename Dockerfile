# VictoriaMetrics on Railway — one-click deploy wrapper (single service)
#
# Base is the official prebuilt image (victoriametrics/victoria-metrics),
# pinned to v1.154.1: the single Go binary bundles ingestion, storage and
# querying — the wrapper only adapts it to Railway, never rebuilds it.
#
# Why each non-default setting exists:
#   USER root ................. Railway mounts persistent volumes root-owned;
#                               keep root explicit so -storageDataPath=/data
#                               is always writable.
#   entrypoint.sh ............. Execs the upstream /victoria-metrics-prod
#                               binary with Railway-aware flags: listens on
#                               the injected PORT, stores data on the volume;
#                               retention and self-scrape stay tunable via env.
#   HEALTHCHECK NONE .......... The stock image has no healthcheck; Railway's
#                               external healthcheckPath ("/health") in
#                               railway.json is the readiness gate.
#
# Upstream: https://github.com/VictoriaMetrics/VictoriaMetrics (Apache-2.0)
# Base image: victoriametrics/victoria-metrics v1.154.1

FROM victoriametrics/victoria-metrics:v1.154.1

USER root

HEALTHCHECK NONE

EXPOSE 8428

LABEL org.opencontainers.image.source="https://github.com/mc9max/victoriametrics"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
