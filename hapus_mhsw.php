<?php
include'./koneksi.php';
$npm=$_GET['id'];

mysqli_query($db,
	"DELETE FROM mahasiswa
	WHERE npm='$npm'"
);

header("location:./index.php");
?>
