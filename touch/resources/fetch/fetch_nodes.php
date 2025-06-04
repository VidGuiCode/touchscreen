<?php
require_once '../../inc/db.inc.php';
header('Content-Type: application/json');
$db = getDb();
$sql = "SELECT n.pk_node, n.name, MAX(m.recordDateTime) as last
        FROM node n
        LEFT JOIN measurement m ON n.pk_node = m.fk_node_isRecorded
        GROUP BY n.pk_node";
$res = $db->query($sql);
$nodes = [];
$now = time();
while($row = $res->fetch_assoc()){
    $online = ($row['last'] && (strtotime($row['last']) >= $now - 600));
    $nodes[] = [
        'pk'=>$row['pk_node'],
        'name'=>$row['name'],
        'online'=>$online
    ];
}
echo json_encode($nodes);
?>
