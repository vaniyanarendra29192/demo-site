#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

flutter build web -t lib/raghav_main.dart --output build/raghav --no-web-resources-cdn

# Flutter uses the shared client demo shell. Apply Raghav's browser branding
# to the generated deployment files.
python3 - <<'PY'
from pathlib import Path
import json

output = Path("build/raghav")
title = "Raghav Restaurant & Banquet"
description = "Pure vegetarian dining and banquet reservations in Narolgam, Ahmedabad."
logo = "assets/assets/raghav/logo.jpg"

index = output / "index.html"
html = index.read_text()
html = html.replace("The Neelkanth Heritage", "Raghav Restaurant &amp; Banquet")
html = html.replace("Raghav Restaurant &amp; Banquet web app.", description)
html = html.replace('href="icons/Icon-192.png"', f'href="{logo}"')
html = html.replace('type="image/png" href="favicon.png"', f'type="image/jpeg" href="{logo}"')
index.write_text(html)

manifest = output / "manifest.json"
metadata = json.loads(manifest.read_text())
metadata.update(
    name=title,
    short_name="Raghav",
    description=description,
    background_color="#FDF9F1",
    theme_color="#B45309",
    icons=[{"src": logo, "sizes": "any", "type": "image/jpeg"}],
)
manifest.write_text(json.dumps(metadata, indent=2) + "\n")
PY
