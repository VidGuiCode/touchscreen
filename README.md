# 📟 Plantimeter Touchscreen Dashboard (L3 Module)

A **touch-optimized web dashboard** for the Plantimeter automated plant monitoring system, designed to run on a **Raspberry Pi 4 with 7" capacitive touchscreen (800x480)**. Features real-time sensor monitoring, plant care automation, and intuitive finger-touch navigation.

## 🎯 Core Features

### Touch-First Interface
- **Fixed 800x480 layout** optimized for capacitive touch
- **Snap-scroll sections** with smooth transitions between views
- **Custom drag scrolling** using mouse events (no mobile gestures)
- **Section feedback** - visual indicators when switching between sections
- **Finger-friendly buttons** with proper touch targets and cooldown management

### Real-Time Monitoring
- **5-second AJAX polling** for live dashboard updates
- **30-second refresh** on individual node detail pages
- **Progressive loading screens** with animated progress bars
- **Color-coded status indicators** (online/offline, health warnings)

### Plant Care Automation
- **One-click watering** (100ml) with task queue system
- **Grow light toggle** with visual feedback
- **Task management** with completion tracking
- **Threshold-based alerts** for soil moisture and temperature

## 🏗️ Architecture

```
Hardware: Raspberry Pi 4 + 7" Touchscreen (800x480)
Frontend: HTML5 + CSS3 + JavaScript/jQuery + ApexCharts
Backend: PHP 8+ + MySQL
Interface: AJAX-driven real-time updates
```

### Data Flow
```
ESP32 Sensor Nodes → MySQL Database → PHP APIs → AJAX Endpoints → Touch UI
                                         ↓
User Touch Actions → AJAX Requests → Task Queue → Node Execution
```

## 📁 Project Structure

```
touch/
├── index.php                     # Main dashboard with statistics & node grid
├── node.php                      # Individual node detail page with charts
├── inc/
│   ├── db.inc.php                # Database connection
│   ├── header.inc.php            # Shared HTML header
│   ├── footer.inc.php            # Shared HTML footer
│   ├── session.inc.php           # Session management (empty)
│   └── touch.inc.php             # Touch interaction scripts
├── resources/
│   ├── css/
│   │   └── main.css              # Complete styling with CSS variables
│   ├── js/
│   │   ├── jquery-3.7.1.min.js  # jQuery library
│   │   └── script.js             # Touch interactions & drag scrolling
│   ├── fonts/
│   │   ├── whitrabt.ttf          # Custom WhiteRabbit font
│   │   ├── whitrabt.woff         # Font in WOFF format
│   │   └── fontawesome-free-6.7.1/ # FontAwesome icons
│   └── img/
│       ├── favicon.png           # Site favicon
│       └── Logo/                 # Logo variations (250px, 800px, 1024px)
├── resources/fetch/              # AJAX API endpoints
│   ├── fetch_statistics.php     # General dashboard statistics
│   ├── fetch_nodes.php          # Node list with status & measurements
│   └── fetch_node_data.php      # Individual node data & tasks
├── add_light_task.php           # Light control task creation
├── add_pump_task.php            # Watering task creation
└── logs/
    └── logs.txt                 # System logs
```

## 🎨 Design System

### Screen Specifications
- **Resolution:** Fixed 800x480px (Raspberry Pi 7" touchscreen)
- **Header:** 70px height, fixed position with logo and navigation
- **Scroll Wrapper:** Full viewport with snap-scroll sections
- **Loading Screen:** Full-screen overlay with progress animation

### Color Palette (CSS Variables)
```css
:root {
    /* Primary Colors */
    --color-1: #122A44;    /* Header, dark backgrounds */
    --color-2: #2BB9D9;    /* Cyan highlights, titles */
    --color-3: #A7F8FB;    /* Light accent, labels */
    --color-4: #129B7F;    /* Buttons, success states */
    --color-5: #36D282;    /* Success indicators */
    --color-6: #87ED95;    /* Healthy status */
    
    /* Alerts */
    --bs-success: #43a047;
    --bs-warning: #ffca28;
    --bs-danger: #e53935;
    
    /* Shadows */
    --box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
}
```

### Typography
- **Primary Font:** WhiteRabbit (custom pixel-style font)
- **Fallback:** sans-serif
- **Sizes:** 14px (small), 16px (medium), 22px (large)

## 🔧 Touch Interface Implementation

### Snap-Scroll Sections
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
- Mouse-based drag simulation for touch devices
- Visual feedback with cursor changes (grab/grabbing)
- Smooth momentum scrolling
- Section snapping on release

### Touch Targets
- Minimum 44px touch targets for accessibility
- Proper button spacing and padding
- Visual feedback on touch/hover states
- Cooldown timers to prevent rapid-fire actions

## 📊 Data Visualization

### ApexCharts Integration
- **Line charts** for sensor measurements over time
- **Responsive design** for 800x480 resolution
- **Real-time updates** with smooth animations
- **Color-coded series:**
  - Soil Moisture: `#36D282` (green)
  - Air Humidity: `#2BB9D9` (cyan) 
  - Air Temperature: `#FF5733` (red)

### Chart Configuration
```javascript
// Use ApexCharts for all data visualization
const options = {
    chart: { type: 'line', height: 300 },
    series: [/* sensor data */],
    colors: ['#36D282', '#2BB9D9', '#FF5733'],
    responsive: [{ 
        breakpoint: 800, 
        options: { /* mobile adjustments */ }
    }]
};
```

## 🔄 Real-Time Updates

### AJAX Polling System
- **Dashboard:** 5-second intervals for statistics and node status
- **Node Details:** 30-second intervals for charts and measurements
- **Progressive Loading:** Visual feedback during data fetches
- **Error Handling:** Graceful degradation on connection issues

### Update Mechanisms
```javascript
// Statistics update every 5 seconds
setInterval(updateStatistics, 5000);

// Node data update every 5 seconds on main dashboard
setInterval(updateNodes, 5000);

// Node detail page updates every 30 seconds
setInterval(fetchNodeData, 30000);
```

## 🛠️ Task Management System

### Watering System
- **100ml standard dose** via pump tasks
- **Immediate execution** with database queue
- **Visual confirmation** and cooldown timer
- **Status tracking** (pending/completed/failed)

### Light Control
- **Toggle switch interface** with visual feedback
- **Binary control** (0% = off, 100% = on)
- **Task completion flagging** system
- **Real-time status updates**

## 🔐 Database Schema

### Core Tables
- **Node:** Sensor device registration and configuration
- **Measurement:** Time-series sensor data
- **Task:** Action queue for watering and lighting
- **PlantVariety:** Plant-specific thresholds and care requirements
- **Operator:** User management for access control

### Status Detection
- **Online Status:** Last measurement within 10 minutes
- **Data Staleness:** Measurements older than 20 minutes show "N/A"
- **Health Alerts:** Threshold-based warnings for critical conditions

## 🚀 Server Deployment

### Prerequisites
- **Web Server** with PHP 8+ and MySQL support
- **Database** with existing Plantimeter schema

### Upload Instructions
1. **Upload Project Files** to your web server
2. **Configure Database Connection** in `inc/db.inc.php`:
   ```php
   define("HOST", "127.0.0.1");
   define("DB_USER", "php");
   define("DB_PASSWORD", "qwer");
   define("DB_NAME", "webDB");
   ```
3. **Set File Permissions** if needed for your server environment

### Production Deployment
- **Kiosk Mode:** Chromium fullscreen on boot
- **Auto-start Service:** Systemd service for dashboard
- **WiFi Configuration:** For ESP32 sensor communication
- **Touchscreen Calibration:** Ensure proper touch response

## 🎮 User Interaction Flow

### Main Dashboard
1. **Loading Screen:** Animated progress on initial load
2. **Statistics Section:** System overview with health indicators
3. **Node Grid:** Touch cards for each sensor node
4. **Node Selection:** Tap card to view detailed information

### Node Detail Page
1. **Overview Section:** Node configuration and current status
2. **Current Measurements:** Latest sensor readings with timestamps
3. **Chart Section:** Historical data visualization with ApexCharts
4. **Task Management:** Recent actions and completion status
5. **Control Actions:** Water and light controls with feedback

### Touch Gestures
- **Tap:** Select nodes, trigger actions
- **Drag:** Scroll between sections with snap behavior
- **Hold:** No special actions (optimized for quick interactions)

## 🔍 Performance Considerations

### Optimization Features
- **Efficient AJAX:** Only update changed data on subsequent loads
- **Image Optimization:** Properly sized logos and icons
- **CSS Variables:** Consistent theming with minimal overhead
- **JavaScript Debouncing:** Prevent rapid-fire touch events
- **Database Indexing:** Optimized queries for real-time performance

### Memory Management
- **Limited DOM Updates:** Update existing elements vs. rebuilding
- **Chart Reuse:** Update existing ApexCharts instances
- **Event Cleanup:** Proper removal of event listeners
- **Image Caching:** Leverage browser cache for static assets

## 📱 Browser Compatibility

**Primary Target:** Chromium on Raspberry Pi OS
**Fallback Support:** Modern browsers with touch capability
**No Support:** Internet Explorer, legacy mobile browsers

## 🚀 Future Enhancements

- **Multi-language Support:** German/English toggle
- **User Authentication:** Operator-specific dashboards
- **Advanced Analytics:** Trend analysis and predictions
- **Push Notifications:** Critical alert system
- **Offline Mode:** Local caching for network interruptions

---

**Build this entire system from scratch using the specifications above. Focus on touch optimization, real-time updates with AJAX, and ApexCharts for data visualization. Remove any references to Chart.js and ensure all fetch endpoints are properly organized in the resources/fetch/ directory.**
