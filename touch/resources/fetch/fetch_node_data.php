<?php
require_once '../../inc/db.inc.php';
header('Content-Type: application/json');
$id = intval($_GET['id'] ?? 0);
$db = getDb();
$node = $db->query("SELECT * FROM node WHERE pk_node=$id")->fetch_assoc();
$latest = $db->query("SELECT * FROM measurement WHERE fk_node_isRecorded=$id ORDER BY recordDateTime DESC LIMIT 1")->fetch_assoc();
$chart = $db->query("SELECT recordDateTime, soilMoisture FROM measurement WHERE fk_node_isRecorded=$id ORDER BY recordDateTime DESC LIMIT 20");
$data = [];
while($c = $chart->fetch_assoc()){
    $data[] = [strtotime($c['recordDateTime'])*1000, (float)$c['soilMoisture']];
}
$response = [
    'node'=>$node,
    'latest'=>$latest,
    'chart'=>['soil'=>array_reverse($data)]
];
echo json_encode($response);
?>
