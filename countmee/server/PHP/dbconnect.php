<?php
$servername = "localhost";
$username   = "hubbuddi_countmeeadmin";
$password   = "6vw]Os0)!};h";
$dbname     = "hubbuddi_countmeedb";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>