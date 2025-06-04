# 📟 Plantimeter Touchscreen Dashboard

**Real-time plant monitoring system with touch-optimized interface for Raspberry Pi**

This module provides the **web-based dashboard** for interacting with sensor nodes in the **Plantimeter automated plant monitoring system**. It runs on a **Raspberry Pi 4** equipped with a **7" 800x480 capacitive touchscreen** and is fully optimized for **touch interaction**, **real-time data**, and intuitive navigation.

## 🌐 Purpose

The dashboard enables plant operators to:
- **Monitor all connected ESP32 sensor nodes** in real-time
- **View detailed charts** and historical data per node
- **Control plant care** - trigger watering (100ml) and grow lights
- **Track system health** with color-coded alerts and statistics
- **Navigate seamlessly** through a touch-optimized scroll-snap interface

---

## ⚙️ Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Frontend** | HTML5, CSS3, JavaScript, jQuery 3.7.1 | Touch interface & real-time updates |
| **Backend** | PHP 8+, MySQL | API endpoints & data management |
| **Charts** | Apexcharts.js | Real-time sensor data visualization |
| **Touch UI** | Custom drag-scroll, snap sections | Raspberry Pi touchscreen optimization |
| **Hardware** | Raspberry Pi 4 + 7" capacitive touchscreen | Kiosk mode deployment |

---

## 🎯 Key Features

### Real-time Monitoring
- **5-second AJAX polling** for live dashboard updates
- **Color-coded status indicators** (online/offline, normal/warning/critical)
- **Threshold-based alerts** for soil moisture and temperature
- **Auto-refresh charts** showing last 10 measurements per node

### Touch-Optimized Interface
- **Snap-scroll sections** - smooth vertical navigation between dashboard areas
- **Drag-to-scroll functionality** - custom mouse/touch event handling
- **Finger-friendly buttons** - 140px+ width for easy touch interaction
- **Loading animations** with progress bars for visual feedback
- **No hover dependencies** - all interactions work via touch/click

### Plant Care Controls
- **One-tap watering** - adds 100ml water task with 60-second cooldown
- **Light toggle switch** - custom CSS switch for grow light control
- **Task queue system** - queued commands sent to ESP32 nodes
- **Action feedback** - visual confirmation and error handling

### Navigation Structure
- **Section 1**: General statistics (active nodes, system errors, alerts)
- **Section 2**: Node grid with live sensor readings
- **Section 3**: Individual node details (charts, tasks, thresholds)

---

## 🧩 Project Structure

```
touch/
├── index.php                    # Main dashboard (statistics + node grid)
├── node.php                     # Individual node detail page
├── add_pump_task.php           # AJAX endpoint for watering commands
├── add_light_task.php          # AJAX endpoint for light control
├── fetch_nodes.php             # AJAX endpoint for node list & status
├── fetch_node_data.php         # AJAX endpoint for charts & tasks
├── fetch_statistics.php        # AJAX endpoint for system statistics
├── writeLog.php                # Log endpoint for ESP32 nodes
├── api-test.html               # Development testing interface
├── inc/
│   ├── db.inc.php              # Database connection & config
│   ├── header.inc.php          # Shared HTML header
│   ├── footer.inc.php          # Shared HTML footer
│   └── touch.inc.php           # Touch interaction scripts
├── resources/
│   ├── css/main.css            # Complete styling (800+ lines)
│   ├── js/
│   │   ├── jquery-3.7.1.min.js
│   │   └── script.js           # Custom touch & AJAX handlers
│   ├── img/Logo/               # Project logos (250px, 800px, 1024px)
│   └── fonts/whitrabt.*        # Custom pixel font
└── logs/logs.txt               # System operation logs
```

---

## 🎨 Design System

### Screen Specifications
- **Fixed Resolution**: 800x480px (Raspberry Pi 7" touchscreen)
- **Header Height**: 70px fixed position
- **Scroll Behavior**: CSS `scroll-snap-type: y mandatory`
- **Section Heights**: `min-height: calc(100vh - 80px)`
- **Touch Targets**: Minimum 44px, preferred 60px+ for buttons

### Color Palette
```css
:root {
  --color-1: #122A44;    /* Header, dark backgrounds */
  --color-2: #2BB9D9;    /* Primary accent, cyan highlights */
  --color-3: #A7F8FB;    /* Light cyan, stat values */
  --color-4: #129B7F;    /* Teal buttons, progress bars */
  --color-5: #36D282;    /* Success green, healthy status */
  --color-6: #87ED95;    /* Light green indicators */
  
  /* Status Colors */
  --bs-success: #43a047; /* Online status */
  --bs-warning: #ffca28; /* Warning thresholds */
  --bs-danger: #e53935;  /* Offline/critical status */
}
```

### Typography
- **Primary Font**: WhiteRabbit (custom pixel font)
- **Font Sizes**: 14px (small), 16px (medium), 22px (large)
- **Headers**: 26-30px for section titles

---

## 🔄 Real-time Data Flow

```
ESP32 Nodes → writeLog.php → MySQL Database
                                  ↓
Dashboard ← AJAX Endpoints ← fetch_*.php APIs
    ↓
User Actions → add_*_task.php → Task Queue → ESP32 Execution
```

### AJAX Update Intervals
- **Dashboard**: 5 seconds (statistics + node status)
- **Node Details**: 30 seconds (charts + measurements)
- **Task Cooldown**: 60 seconds (prevent spam)

---

## 🎮 Touch Interaction Implementation

### Scroll-Snap Navigation
```css
.scroll-wrapper {
  scroll-snap-type: y mandatory;
  overflow-y: scroll;
  height: 100vh;
}

.scroll-wrapper > section {
  scroll-snap-align: start;
  min-height: calc(100vh - 80px);
}
```

### Custom Drag Scrolling
- **Mouse down**: Capture start position and scroll offset
- **Mouse move**: Calculate delta and update scroll position
- **Mouse up**: Reset drag state
- **Cursor feedback**: `grab` → `grabbing` states

### Button States & Feedback
- **Water button**: Disabled during cooldown, text changes ("Sende..." → "Hinzugefügt!")
- **Light switch**: Custom CSS toggle with brightness-based state
- **Card hover**: Transform scale and shadow effects

---

## 📊 Database Schema

### Core Tables
- **Node**: Sensor hardware (MAC address, plant variety, operator)
- **Measurement**: Time-series sensor data (soil, air, brightness)
- **Task**: Command queue (pump, light) with completion flags
- **PlantVariety**: Threshold settings for different plants
- **Operator**: User management

### Key Relationships
```sql
Node.fk_plantVariety_contains → PlantVariety.pk_plantVariety
Node.fk_operator_belongs → Operator.pk_user_id
Measurement.fk_node_isRecorded → Node.pk_node
Task.fk_node_isAssigned → Node.pk_node
```

---

## 🛠️ Setup & Deployment

### Prerequisites
- Raspberry Pi 4 with Raspberry Pi OS
- Apache/Nginx + PHP 8+ + MySQL
- 7" touchscreen connected and calibrated

### Installation
```bash
# 1. Clone to web directory
sudo git clone [repo] /var/www/html/plantimeter

# 2. Set permissions
sudo chown -R www-data:www-data /var/www/html/plantimeter
sudo chmod -R 755 /var/www/html/plantimeter

# 3. Import database
mysql -u root -p < database/plantimeter.sql

# 4. Configure database connection
sudo nano inc/db.inc.php
```

### Kiosk Mode Setup
```bash
# Install Chromium
sudo apt install chromium-browser

# Create autostart script
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/plantimeter.desktop << EOF
[Desktop Entry]
Type=Application
Name=Plantimeter Dashboard
Exec=chromium-browser --kiosk --disable-infobars http://localhost/plantimeter
EOF
```

---

## 🧪 Development Features

### API Testing
- **api-test.html**: Manual testing interface for ESP32 communication
- **writeLog.php**: Accepts MAC address and log data from nodes
- **Real-time validation**: Parameter checking and JSON responses

### Error Handling
- **Connection timeouts**: AJAX error callbacks with user feedback
- **Database failures**: Graceful degradation with "N/A" fallbacks
- **Stale data detection**: 20-minute threshold for offline status

### Performance Optimization
- **Selective updates**: Only refresh changed values, not entire DOM
- **Progressive loading**: Staggered AJAX calls with progress indication
- **Memory management**: Chart data limited to last 10 measurements

---

## 🔧 Customization

### Adding New Sensor Types
1. Update `Measurement` table schema
2. Modify `fetch_node_data.php` to include new fields
3. Add chart datasets in node.php Chart.js config
4. Update CSS color classes for new thresholds

### Threshold Configuration
- Modify `PlantVariety` table for new optimal ranges
- Update classification logic in `fetch_nodes.php`
- Adjust CSS warning/critical color assignments

### Screen Resolution Adaptation
- Modify CSS `:root` variables for different screen sizes
- Update `html` width/height constraints
- Adjust touch target sizes and spacing

---

## 🔍 Troubleshooting

### Common Issues
- **Blank charts**: Check Chart.js CDN loading and data format
- **No AJAX updates**: Verify PHP error logs and database connectivity
- **Touch not working**: Ensure mouse event handlers are properly bound
- **Styling issues**: Check font loading and CSS variable inheritance

### Debug Tools
- Browser DevTools → Network tab for AJAX monitoring
- `logs/logs.txt` for ESP32 communication logs
- MySQL query logs for database performance
- PHP error logs for backend issues

---

## 📱 Mobile Considerations

While optimized for Raspberry Pi touchscreen, the interface works on:
- **Tablets**: iPad, Android tablets (landscape mode recommended)
- **Desktop**: Mouse interaction fully supported
- **Mobile phones**: Limited due to 800px fixed width

---

## 🚀 Future Enhancements

- [ ] **Multi-language support** (German/English toggle)
- [ ] **Data export** (CSV download of measurements)
- [ ] **Push notifications** for critical alerts
- [ ] **Voice control** integration
- [ ] **Remote access** via VPN/tunnel
- [ ] **Historical trends** (weekly/monthly charts)

---

## 📄 License & Credits

**Project**: PIF DT IF 24/25 - Plants in Focus S.A.  
**Hardware**: ESP32 + sensor nodes, Raspberry Pi 4 + touchscreen  
**Framework**: Custom PHP/MySQL with jQuery frontend  

© 2024-25 Plantimeter | PLANTS IN FOCUS S.A. | Gardening made easy!
