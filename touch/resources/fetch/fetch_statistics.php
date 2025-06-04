<?php
require_once '../../inc/db.inc.php';
header('Content-Type: application/json');
$db = getDb();
$nodes = $db->query('SELECT COUNT(*) as c FROM node')->fetch_assoc()['c'];
echo json_encode(['nodes'=>(int)$nodes]);
?>
