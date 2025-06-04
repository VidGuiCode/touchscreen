<?php
require_once 'inc/db.inc.php';
$id = intval($_GET['id'] ?? 0);
if(!$id){ die('Missing node id'); }
$bodyAttr = "data-node=\"$id\"";
include 'inc/header.inc.php';
?>

<!-- Node Header Section -->
<section class="section fade-in">
    <div class="node-header">
        <div class="flex items-center justify-between mb-lg">
            <h1 class="node-title" id="node-name">Loading...</h1>
            <div class="status-indicator">
                <div class="status-dot"></div>
                <span id="node-status">Checking...</span>
            </div>
        </div>
        
        <div class="node-metrics">
            <div class="node-metric">
                <div class="node-metric-value" id="node-soil">--</div>
                <div class="node-metric-label">Soil Moisture <span class="node-metric-unit">%</span></div>
            </div>
            <div class="node-metric">
                <div class="node-metric-value" id="node-temp">--</div>
                <div class="node-metric-label">Temperature <span class="node-metric-unit">°C</span></div>
            </div>
            <div class="node-metric">
                <div class="node-metric-value" id="node-humidity">--</div>
                <div class="node-metric-label">Humidity <span class="node-metric-unit">%</span></div>
            </div>
            <div class="node-metric">
                <div class="node-metric-value" id="node-light">--</div>
                <div class="node-metric-label">Light Level <span class="node-metric-unit">%</span></div>
            </div>
        </div>
    </div>
</section>

<!-- Chart Section -->
<section class="section fade-in">
    <h2><i class="fas fa-chart-line"></i> Sensor History</h2>
    <div id="chart"></div>
</section>

<!-- Control Section -->
<section class="section fade-in">
    <h2><i class="fas fa-sliders-h"></i> Plant Care Controls</h2>
    
    <div class="control-panel">
        <div class="control-group">
            <div class="control-label">Watering System</div>
            <form action="add_pump_task.php" method="POST" class="flex flex-col gap-sm">
                <input type="hidden" name="id" value="<?php echo $id; ?>">
                <input type="hidden" name="dose" value="100">
                <button type="submit" class="btn-primary">
                    <i class="fas fa-tint"></i>
                    Water Plant (100ml)
                </button>
            </form>
            
            <form action="add_pump_task.php" method="POST" class="flex flex-col gap-sm mt-sm">
                <input type="hidden" name="id" value="<?php echo $id; ?>">
                <input type="hidden" name="dose" value="200">
                <button type="submit" class="btn-secondary">
                    <i class="fas fa-shower"></i>
                    Deep Water (200ml)
                </button>
            </form>
        </div>
        
        <div class="control-group">
            <div class="control-label">Lighting Control</div>
            <form action="add_light_task.php" method="POST" class="flex flex-col gap-sm">
                <input type="hidden" name="id" value="<?php echo $id; ?>">
                <input type="hidden" name="set" value="100">
                <button type="submit" class="btn-outline">
                    <i class="fas fa-lightbulb"></i>
                    Turn Light On
                </button>
            </form>
            
            <form action="add_light_task.php" method="POST" class="flex flex-col gap-sm mt-sm">
                <input type="hidden" name="id" value="<?php echo $id; ?>">
                <input type="hidden" name="set" value="0">
                <button type="submit" class="btn-danger">
                    <i class="far fa-lightbulb"></i>
                    Turn Light Off
                </button>
            </form>
        </div>
        
        <div class="control-group">
            <div class="control-label">Quick Actions</div>
            <button class="btn-outline" onclick="refreshNodeData()">
                <i class="fas fa-sync"></i>
                Refresh Data
            </button>
            
            <button class="btn-outline mt-sm" onclick="window.history.back()">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </button>
        </div>
    </div>
</section>

<!-- Recent Tasks Section -->
<section class="section fade-in">
    <h2><i class="fas fa-tasks"></i> Recent Activities</h2>
    
    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-value" id="task-pending">0</div>
            <div class="stat-label">Pending Tasks</div>
            <div class="stat-trend">
                <i class="fas fa-clock"></i> In Queue
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-value" id="task-completed">0</div>
            <div class="stat-label">Completed Today</div>
            <div class="stat-trend">
                <i class="fas fa-check"></i> Finished
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-value" id="last-watered">--</div>
            <div class="stat-label">Last Watered</div>
            <div class="stat-trend">
                <i class="fas fa-tint"></i> Automated
            </div>
        </div>
        
        <div class="stat-card">
            <div class="stat-value" id="next-action">--</div>
            <div class="stat-label">Next Action</div>
            <div class="stat-trend">
                <i class="fas fa-calendar"></i> Scheduled
            </div>
        </div>
    </div>
</section>

<script>
// Node-specific JavaScript
function refreshNodeData() {
    showLoading('Refreshing node data...');
    fetchNodeData();
    setTimeout(hideLoading, 1000);
    showNotification('Node data refreshed', 'success');
}

// Enhanced node metrics update
function updateNodeMetrics(latest) {
    const metrics = {
        'node-soil': { value: latest.soilMoisture, unit: '%', color: '#00d4aa' },
        'node-temp': { value: latest.airTemperature, unit: '°C', color: '#ff6b6b' },
        'node-humidity': { value: latest.airHumidity, unit: '%', color: '#0099ff' },
        'node-light': { value: latest.lampBrightness, unit: '%', color: '#ffd93d' }
    };
    
    Object.entries(metrics).forEach(([id, metric]) => {
        const el = document.getElementById(id);
        if(el) {
            const displayValue = metric.value !== null && metric.value !== undefined ? 
                Math.round(metric.value) : '--';
            
            // Animate the value change
            animateCounter(id, displayValue === '--' ? 0 : displayValue);
            
            // Add color coding based on value ranges
            if(displayValue !== '--') {
                el.style.color = metric.color;
                
                // Add status indicators for critical values
                if(id === 'node-soil' && displayValue < 30) {
                    el.style.color = 'var(--status-offline)';
                    showNotification('Low soil moisture detected!', 'warning');
                } else if(id === 'node-temp' && (displayValue < 15 || displayValue > 35)) {
                    el.style.color = 'var(--accent-warning)';
                }
            }
        }
    });
}

// Update task statistics
function updateTaskStats() {
    // This would fetch task data from a new endpoint
    fetch(`resources/fetch/fetch_node_tasks.php?id=${document.body.dataset.node}`)
        .then(response => response.json())
        .then(data => {
            animateCounter('task-pending', data.pending || 0);
            animateCounter('task-completed', data.completed || 0);
            
            const lastWateredEl = document.getElementById('last-watered');
            const nextActionEl = document.getElementById('next-action');
            
            if(lastWateredEl) {
                lastWateredEl.textContent = data.lastWatered || '--';
            }
            
            if(nextActionEl) {
                nextActionEl.textContent = data.nextAction || '--';
            }
        })
        .catch(error => {
            console.error('Error updating task stats:', error);
        });
}

// Initialize node page
document.addEventListener('DOMContentLoaded', () => {
    // Add task stats update to interval
    updateIntervals.push(setInterval(updateTaskStats, 10000)); // Every 10 seconds
    
    // Initial task stats load
    setTimeout(updateTaskStats, 2000);
});
</script>

<?php include 'inc/footer.inc.php'; ?>
