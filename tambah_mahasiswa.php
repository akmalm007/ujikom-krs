<?php
include './koneksi.php';
$nama = $_POST['nama'];
$program_studi = $_POST['program_studi'];
$tahun_angkatan = $_POST['tahun_angkatan']; 
$semester = $_POST['semester'];

$query_mhsw = mysqli_query($db, "INSERT INTO mahasiswa (nama, program_studi, semester, tahun_angkatan)
                                VALUES ('$nama', '$program_studi', '$semester', '$tahun_angkatan')");

if ($query_mhsw) {
    header("location:./index.php");
} else {
    echo "gagal tersimpan";
}

?>

