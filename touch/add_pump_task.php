<?php
require_once 'inc/db.inc.php';
$db = getDb();
$id = intval($_POST['id'] ?? 0);
$dose = intval($_POST['dose'] ?? 100);
$db->query("INSERT INTO task (taskType,setPoint,fk_node_isAssigned) VALUES ('pump',$dose,$id)");
header('Location: node.php?id='.$id);
?>
