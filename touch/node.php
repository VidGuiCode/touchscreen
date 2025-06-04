<?php
require_once 'inc/db.inc.php';
$id = intval($_GET['id'] ?? 0);
if(!$id){ die('Missing node id'); }
$bodyAttr = "data-node=\"$id\"";
include 'inc/header.inc.php';
?>
<section class="section">
    <h2 id="node-name">Node</h2>
    <div>Soil Moisture: <span id="node-soil">-</span></div>
    <div id="chart"></div>
    <form action="add_pump_task.php" method="POST">
        <input type="hidden" name="id" value="<?php echo $id; ?>">
        <button type="submit"><i class="fas fa-tint"></i> Water 100ml</button>
    </form>
    <form action="add_light_task.php" method="POST">
        <input type="hidden" name="id" value="<?php echo $id; ?>">
        <button type="submit"><i class="fas fa-lightbulb"></i> Toggle Light</button>
    </form>
</section>
<?php include 'inc/footer.inc.php'; ?>
