# History

## Split out of `ubdcc-dashboard-demo`

**Status:** active
**Confirmed** (initial commit `5f9384a`: "server.py bundles the existing /proxy + /proxy_batch logic from the ubdcc-dashboard-demo")

This repo's `/proxy` and `/proxy_batch` server logic originated in the sibling `ubdcc-dashboard-demo` project, and was carried over when this pip-installable CLI package was created.

**Reason:** not stated explicitly beyond the initial-commit description — inferred that `ubdcc-dashboard-demo` served as a proving ground for the dashboard UI/proxy approach before it was packaged as a proper installable tool (`ubdcc-dashboard start`) with its own CLI, versioning, and PyPI release. Flagging the specific motivation as inferred, not confirmed, since no commit or doc states the demo-to-package rationale directly.

Unlike the rest of the UNICORN Binance Suite, this repo has no LUCIT-Systems-and-Development history — it was created directly under `oliver-zehentleitner`, after that cleanup had already happened suite-wide.
