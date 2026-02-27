# Global Paste Backfill Plant Map

An interactive dashboard mapping **190+ paste backfill plants worldwide**, built by [MineSmart Solutions](https://minesmart.io).

🌐 **Live:** [pasteplant.minesmart.io](https://pasteplant.minesmart.io)

## What Is This?

A public, open-data map of every known paste backfill plant in the mining industry. Filter by region, commodity, status, and confidence level. View charts showing regional distribution, top plants by capacity, commodity breakdown, and commissioning timeline.

## Features

- 🗺️ **Interactive map** with bubble markers sized by paste capacity (tpd)
- 📊 **Dashboard sidebar** with Chart.js visualisations (region, commodity, timeline, status)
- 🔍 **Search & filter** by region, commodity, status, confidence
- 📝 **Submit a mine** — contribute data via the built-in form
- 📱 **Responsive** — works on desktop and mobile
- 🎨 **Dark theme** with MineSmart branding

## Tech Stack

Pure HTML/CSS/JS — no build step required.

- [Leaflet.js](https://leafletjs.com/) — mapping
- [Leaflet.markercluster](https://github.com/Leaflet/Leaflet.markercluster) — marker clustering
- [Chart.js](https://www.chartjs.org/) — charts
- [CARTO Dark](https://carto.com/basemaps/) — basemap tiles

## Data

`data.json` contains an array of paste plant records with fields:

| Field | Description |
|-------|-------------|
| name | Mine/plant name |
| company | Operating company |
| country | Country |
| region | Continent/region |
| lat, lng | Coordinates |
| type | Fill type (Paste) |
| tpd | Paste capacity (tonnes per day) |
| ore_tpd | Ore throughput (tpd) |
| commodity | Primary commodity |
| status | Operating status |
| confidence | Data confidence (verified/likely) |
| year_commissioned | Year commissioned |
| designer | Plant designer |

### Data Sources

- L-P Gélinas Inc. research
- Industry reports and conference papers
- Public company filings and technical reports
- Community contributions

## Contributing

Know of a paste plant not on the map? Have a correction?

1. Click **"Submit a Mine"** on the live site
2. Or open a pull request adding to `data.json`
3. Or email [info@minesmart.io](mailto:info@minesmart.io)

## Hosting

Static site — just serve `index.html` and `data.json` from any web server or CDN.

## About MineSmart

[MineSmart Solutions](https://minesmart.io) builds **Backfill Pro**, the paste operations management platform for underground mines. Track plant performance, optimise mix designs, and manage your backfill programme.

## Licence

**Code:** MIT  
**Data:** [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) — share and adapt with attribution.

---

*Built with ❤️ by MineSmart Solutions Ltd*
