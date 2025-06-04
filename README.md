# 📟 L3 - Touchscreen Web Dashboard (Planimeter Project)

This module provides the **web-based dashboard** for interacting with sensor Nodes in the **Planimeter automated plant monitoring system**. It runs on a **Raspberry Pi 4** equipped with a **7" 800x480 capacitive touchscreen** and is fully optimized for **touch interaction**, **real-time data**, and a clean UI layout.

## 🌐 Purpose

L3 enables plant operators to:
- View the current state of all connected nodes (ESP32 sensors)
- Access per-node charts and thresholds
- See recent sensor data (moisture, temperature, humidity, brightness)
- Trigger interactions via a clean touchscreen interface

---

## ⚙️ Tech Stack

| Component | Details |
|----------|---------|
| **Frontend** | HTML, CSS (custom variables), JavaScript, jQuery |
| **Backend** | PHP 8+, MySQL |
| **Charts** | Apexcharts.js |
| **Touch** | Desktop-like mouse-based touch (no mobile gestures) |

---

## 🧩 Structure

- `/index.php` – Main dashboard page, shows all statistics and all node cards
- `/node.php?id=1` – Per-node detail view, includes chart, thresholds, tasks
- `/fetch_statistics.php` – AJAX endpoint for general data
- `/fetch_nodes.php` – AJAX endpoint for node list and status
- `/fetch_node_data.php?id=X` – AJAX for chart & task data per node
- `/writeLog.php` – Used by ESP32 nodes to log measurements

---

## 🎨 Design Specifications

### Screen & Layout
- **Resolution:** Fixed 800x480px
- **Header:** `70px` height, fixed
- **Scroll wrapper:** fills viewport with smooth snapping
- **Cards & tables:** visually centered, padding adjusted for small screens

### Color Palette (CSS Variables)
| Name | Color | Usage |
|------|-------|-------|
| `--color-1` | `#122A44` | Header, backgrounds |
| `--color-2` | `#2BB9D9` | Cyan highlights |
| `--color-3` | `#A7F8FB` | Label text, light accent |
| `--color-4` | `#129B7F` | Buttons, dividers |
| `--color-5` | `#36D282` | Success, charts |
| `--color-6` | `#87ED95` | Healthy indicators |

### Font
- Custom pixel-style font: `WhiteRabbit`
- Fallback: `sans-serif`

### Touch Interaction
- `cursor: grab/grabbing` on scrollable areas
- Enlarged clickable targets (e.g. `.card`, `button`)
- No hover-only behaviors
- Simulated “drag to scroll” using mouse events

---

## 🧪 Features

✅ One-time full-screen **loading animation** on startup  
✅ Live updates of general stats and node data every **30 seconds**  
✅ Per-node charts showing:
- Soil Moisture (%)
- Air Humidity (%)
- Air Temperature (°C)  

✅ Node cards link to detail pages via `node.php?id=X`  
✅ All values protected with `htmlspecialchars()` (avoid PHP deprecation)

---

## 📁 File List

| File | Description |
|------|-------------|
| `index.php` | Landing page with node overview |
| `node.php` | Detail page for one Node |
| `style.css` | Unified styling file |
| `script.js` | Contains scroll logic, AJAX, interactivity |
| `fetch_statistics.php` | Returns JSON for stats |
| `fetch_nodes.php` | Returns JSON for all nodes |
| `fetch_node_data.php` | Returns measurements + tasks for one node |
| `writeLog.php` | Accepts log input from devices (via POST) |

---

## 🧱 Database
The `/database/webdb-db_2025-02-21 - shortform.sql` file contains the full table structure and foreign key relationships used in this project. You can import it into MySQL using:

---

## 🛠️ Setup

1. Clone the repo to your **Raspberry Pi (Apache server)** under `/var/www/html`
2. Ensure **PHP + MySQL** are configured
3. Import the MySQL schema (`Node`, `Operator`, `Measurement`, etc.)
4. Adjust database credentials in `db.inc.php`
5. Navigate to `http://localhost/index.php`

---

## 🔒 Security Notes

- Only data logging via MAC address is open.
- Admin settings and authentication are handled separately in L4/L6.

---

## ✅ Final Goals

- Touchscreen-friendly UI, no keyboard or mouse needed
- Clear visuals for plant caretakers
- Instant overview and per-node history
- Clean German and English layout (multi-language support ready)
