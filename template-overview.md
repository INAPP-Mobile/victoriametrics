# Deploy and Host

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.com/deploy/victoriametrics?utm_campaign=victoriametrics)

**VictoriaMetrics** — the fast, cost-effective, Prometheus-compatible time series database. A single Go binary bundles ingestion, storage and querying: point Prometheus remote-write, vmagent or Grafana at it and your dashboards keep working with zero changes. Deploys in one click, zero form fields.

On first boot the binary starts on Railway's injected `PORT`, creates its data dir on the persistent volume, and begins self-scraping — the built-in **vmui** at `/vmui` shows live metrics within seconds.

## About Hosting

One service, deployed with one click:

- **victoriametrics** — the VictoriaMetrics single-server binary (pinned official image `victoriametrics/victoria-metrics:v1.154.1`), healthcheck `GET /health`, honors Railway's injected `PORT`
- Persistent volume `victoriametrics-data` at `/data` — 12-month retention by default (`RETENTION_PERIOD` tunable)

No companion database: VictoriaMetrics is its own storage engine. Self-scraping (`SELF_SCRAPE_INTERVAL=10s`) means the instance monitors itself out of the box.

## Why Deploy

Self-hosting VictoriaMetrics means your metrics never leave your infrastructure — no per-series pricing, no cardinality bills, no vendor lock-in. It uses up to 7x less RAM than Prometheus for the same workload, ingests via every Prometheus protocol (remote-write, scrape, InfluxDB line protocol, Graphite, OpenTSDB), and queries with PromQL plus the MetricsQL superset. On Railway it is always on, so retention and alerting actually work around the clock.

## Common Use Cases

- A drop-in Prometheus replacement at half the RAM — same PromQL, same Grafana dashboards
- Long-term metrics retention for homelabs, side projects and small fleets (12 months default)
- A central remote-write sink for vmagent or Prometheus fleets (`/api/v1/write`)
- Metrics backend for alerting (pair with vmalert) and anomaly-detection pipelines

## Configuration

Zero form fields on deploy. After deploy, the optional knobs in the service's **Variables** panel:

- `RETENTION_PERIOD` — months of metrics to keep (default `12`)
- `SELF_SCRAPE_INTERVAL` — self-monitoring scrape interval (default `10s`)
- `PORT` — injected by Railway automatically

Ingest: `POST https://<your-domain>/api/v1/write` (Prometheus remote-write). Query: `/api/v1/query` or the visual explorer at `/vmui`.

## Dependencies for

### Deployment Dependencies

Hobby plan or higher for the persistent volume. VictoriaMetrics needs nothing at runtime beyond its volume — no external API keys, no companion services, no third-party accounts. Open `/vmui` after deploy to explore the self-scraped metrics.
