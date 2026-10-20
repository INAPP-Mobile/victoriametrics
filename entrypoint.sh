#!/bin/sh
# Compose the upstream flags from Railway's environment, then exec the
# stock binary. PORT is injected by Railway; everything else has sane baked
# defaults and stays off the one-click deploy form (zero fields).
set -e
exec /victoria-metrics-prod \
  -storageDataPath=/data \
  "-httpListenAddr=:${PORT:-8428}" \
  "-retentionPeriod=${RETENTION_PERIOD:-12}" \
  "-selfScrapeInterval=${SELF_SCRAPE_INTERVAL:-10s}"
