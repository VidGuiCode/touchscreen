<?php
require_once 'inc/db.inc.php';
$db = getDb();
$id = intval($_POST['id'] ?? 0);
$set = intval($_POST['set'] ?? 100);
$db->query("INSERT INTO task (taskType,setPoint,fk_node_isAssigned) VALUES ('light',$set,$id)");
header('Location: node.php?id='.$id);
?>
