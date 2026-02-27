#!/bin/bash
# Import mines from data.json into Supabase mines table
# Run this AFTER creating the mines table via schema-mines.sql

SB_URL="https://cxsariervcthxoudumaq.supabase.co"
SB_KEY="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN4c2FyaWVydmN0aHhvdWR1bWFxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MjE5NzAxMCwiZXhwIjoyMDg3NzczMDEwfQ.kphUFG1-TcS6NhUR8NMOQnpguf__FMePxQM1s1_DwSc"

cd "$(dirname "$0")"

echo "Importing mines in batches of 50..."

python3 << 'PYEOF'
import json, urllib.request, sys

SB_URL = "https://cxsariervcthxoudumaq.supabase.co"
SB_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN4c2FyaWVydmN0aHhvdWR1bWFxIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc3MjE5NzAxMCwiZXhwIjoyMDg3NzczMDEwfQ.kphUFG1-TcS6NhUR8NMOQnpguf__FMePxQM1s1_DwSc"

with open("data.json") as f:
    mines = json.load(f)

# Map data.json fields to mines table columns
def map_mine(m):
    return {
        "name": m.get("name"),
        "company": m.get("company"),
        "country": m.get("country"),
        "region": m.get("region"),
        "lat": m.get("lat"),
        "lng": m.get("lng"),
        "type": m.get("type", "Paste"),
        "tpd": m.get("tpd"),
        "ore_tpd": m.get("ore_tpd"),
        "plants": m.get("plants", 1),
        "notes": m.get("notes"),
        "commodity": m.get("commodity"),
        "status": m.get("status", "operating"),
        "confidence": m.get("confidence", "likely"),
        "source": m.get("source"),
        "source_label": m.get("source_label"),
        "year_commissioned": m.get("year_commissioned"),
        "designer": m.get("designer"),
    }

mapped = [map_mine(m) for m in mines]
# Remove None values
for m in mapped:
    for k in list(m.keys()):
        if m[k] is None:
            del m[k]

batch_size = 50
total = 0
for i in range(0, len(mapped), batch_size):
    batch = mapped[i:i+batch_size]
    data = json.dumps(batch).encode()
    req = urllib.request.Request(
        f"{SB_URL}/rest/v1/mines",
        data=data,
        headers={
            "apikey": SB_KEY,
            "Authorization": f"Bearer {SB_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=minimal"
        },
        method="POST"
    )
    try:
        resp = urllib.request.urlopen(req)
        total += len(batch)
        print(f"  Batch {i//batch_size + 1}: {len(batch)} mines inserted (total: {total})")
    except Exception as e:
        body = e.read().decode() if hasattr(e, 'read') else str(e)
        print(f"  ERROR batch {i//batch_size + 1}: {body}")
        sys.exit(1)

print(f"\nDone! {total} mines imported.")

# Verify count
req = urllib.request.Request(
    f"{SB_URL}/rest/v1/mines?select=id",
    headers={
        "apikey": SB_KEY,
        "Authorization": f"Bearer {SB_KEY}",
    }
)
resp = urllib.request.urlopen(req)
result = json.loads(resp.read())
print(f"Verification: {len(result)} mines in database")
PYEOF
