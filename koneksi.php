<?php 
$server = "localhost";
$user = "root";
$password = "";
$nama_db = "db_krs";

$db = mysqli_connect($server, $user, $password, $nama_db);

if (!$db) {
    die("Gagal Terhubung". mysqli_connect_error());
}

?>
