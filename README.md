# VictoriaMetrics

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/victoriametrics-e2e?utm_campaign=victoriametrics)

**VictoriaMetrics** — the fast, cost-effective, Prometheus-compatible time series database and monitoring solution, as a one-click Railway deploy. A single Go binary bundles ingestion, storage and querying; point your Prometheus remote-write, vmagent or Grafana at it and your dashboards keep working.

## Deploy and Host

One service, zero form fields:

- **victoriametrics** — pinned official image `victoriametrics/victoria-metrics:v1.154.1`, healthcheck `GET /health`, listens on Railway's injected `PORT`
- Persistent volume `victoriametrics-data` mounted at `/data` (12-month retention by default)

Self-scraping is on (`-selfScrapeInterval=10s`), so the built-in **vmui** at `/vmui` shows live metrics seconds after boot. Query with PromQL or MetricsQL at `/vmui`, ingest via Prometheus remote-write at `/api/v1/write`, read at `/api/v1/query`.

## Why Deploy

Self-hosting VictoriaMetrics means your metrics never leave your infrastructure — no per-series pricing, no cardinality bills, no vendor lock-in. It uses up to 7x less RAM than Prometheus for the same workload, speaks every Prometheus ingestion protocol (remote-write, scrape, InfluxDB, Graphite, OpenTSDB), and Grafana works against it with zero panel changes.

## Common Use Cases

- Drop-in Prometheus replacement — half the RAM, same PromQL, same Grafana dashboards
- Long-term metrics retention for homelabs and side projects (12 months default, tunable)
- Central remote-write sink for vmagent / Prometheus fleets
- Backend for alerting pipelines (pair with vmalert) and anomaly detection

## Configuration

Zero form fields on deploy. Optional knobs in the service's **Variables** panel after deploy:

- `RETENTION_PERIOD` — months of metrics to keep (default `12`)
- `SELF_SCRAPE_INTERVAL` — self-monitoring scrape interval (default `10s`)
- `PORT` — injected by Railway automatically; the wrapper listens on it

### Deployment Dependencies

Hobby plan or higher for the persistent volume. VictoriaMetrics needs nothing at runtime beyond its volume — no external API keys, no companion services, no third-party accounts. Point scrapers at `https://<your-domain>/api/v1/write` and open `/vmui` to explore.
