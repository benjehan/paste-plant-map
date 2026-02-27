# Global Paste Backfill Plants — Interactive Map

Interactive Leaflet.js map showing 100+ active cemented paste backfill operations worldwide.

## What It Is
A single-page web app (`index.html`) with dark mining-industry theme, circle markers sized by TPD, coloured by region, with filtering, popups, stats, and legend.

## Data Source
- **Primary:** L-P Gélinas (Agnico Eagle) LinkedIn post compilation — 108+ plants, 455,000+ tpd combined
- **Supplementary:** MineSmart MineMap API database, industry contacts, MineFill conference data
- **Note:** China has 400+ additional plants (not individually mapped due to data access)

## Files
- `index.html` — the app (CDN Leaflet, no build step, just open in browser)
- `data.json` — structured plant data (edit this to add/update plants)
- `raw-linkedin-data.md` — original extracted data from LinkedIn post

## How to Update
1. Edit `data.json` — add new entries with: name, company, country, region, lat, lng, type, tpd, plants, notes
2. Region must be one of: `Australia`, `Africa`, `South America`, `North America`, `Europe`, `Asia`
3. Type is typically: `Paste`, `CAF`, `CRF`
4. Refresh the page

## Hosting
Static files — host anywhere (GitHub Pages, Netlify, S3, etc). No server needed.

## Credit
Data compiled from industry sources. Contribute: contact@minesmart.io
Built by MineSmart.io
