<?php
// Database connection
function getDb(){
    static $db = null;
    if($db === null){
        $db = new mysqli("127.0.0.1", "php", "qwer", "webDB");
        if($db->connect_error){
            die("DB connection failed: " . $db->connect_error);
        }
        $db->set_charset('utf8mb4');
    }
    return $db;
}
?>
