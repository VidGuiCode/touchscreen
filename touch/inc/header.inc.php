<?php
$bodyAttr = isset($bodyAttr)?$bodyAttr:'';
?><!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=800, initial-scale=1.0">
<link rel="stylesheet" href="resources/css/main.css">
<script src="resources/js/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<title>Plantimeter Dashboard</title>
<link rel="icon" href="resources/img/favicon.png">
</head>
<body <?php echo $bodyAttr; ?>>
<div id="loading"><div class="progress"><div class="progress-bar" id="progress-bar"></div></div></div>
<header><img src="resources/img/Logo/logo_250.png" alt="Logo"></header>
<div class="scroll-wrapper">
