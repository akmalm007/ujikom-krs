<?php
include './koneksi.php';
$npm = $_POST['npm'];
$nama = $_POST['nama'];
$program_studi = $_POST['program_studi'];
$semester = $_POST['semester'];
$tahun_angkatan = $_POST['tahun_angkatan'];

if(isset($_POST['simpan'])) {
    mysqli_query($db, 
        "UPDATE mahasiswa
        SET nama='$nama', program_studi='$program_studi', semester='$semester', tahun_angkatan='$tahun_angkatan'
        WHERE npm='$npm'"
    );
}

header("location:./index.php");
?>
