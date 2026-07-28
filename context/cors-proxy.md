# CORS proxy instead of cluster-side CORS support

## The local server proxies cluster requests rather than the browser calling the cluster directly

**Status:** active
**Evidence:** confirmed
**Source:** README "How it works"; commit `8a5dcbf`

`server.py` isn't just a static-file server — it also proxies `/proxy`, `/proxy_batch`, and effectively acts as a CORS proxy so the browser can query a remote UBDCC cluster that doesn't send `Access-Control-Allow-Origin` headers. `/proxy_batch` specifically fans out a list of GETs over a thread pool (`--batch-workers`, default 32) for snappy multi-DepthCache orderbook refreshes, instead of the browser issuing many individual cross-origin requests itself.

**Rejected alternative:** adding CORS middleware to the cluster's REST API (`unicorn-binance-depth-cache-cluster`) itself, so the dashboard's JS could call it directly from the browser. Explicitly tracked and dropped from this repo's own backlog (commit `8a5dcbf`: "CORS middleware in ubdcc-restapi: tracked on the cluster side, not here. Won't block dashboard work either way.").

**Reason:** a user points the dashboard at *any* UBDCC cluster's base URL at runtime — the dashboard doesn't control what CORS headers that cluster sends, and can't require every cluster deployment to add CORS support just to be dashboard-compatible. Proxying locally (through this pip-installed CLI's own server) solves it entirely client-side, independent of the cluster's configuration.

## Docker image rejected — unnecessary for a pip-installable CLI

**Status:** active
**Evidence:** confirmed
**Source:** commit `8a5dcbf`: "Docker image: unnecessary for a pip-installable CLI tool."

No Docker image is built or published for this package, unlike the cluster's own components (`ubdcc-dcn`, `ubdcc-mgmt`, `ubdcc-restapi`), which do ship Docker images.

**Reason:** this is a lightweight, stdlib-only CLI tool meant to be `pip install`ed and run locally next to whatever it's monitoring — containerizing it would add packaging overhead without a corresponding deployment need.
