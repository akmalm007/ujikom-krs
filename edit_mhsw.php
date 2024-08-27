<?php 
    include './koneksi.php';
    $npm = $_GET['id'];
    $query_mhsw = mysqli_query($db, "SELECT * FROM mahasiswa WHERE npm='$npm'");
    $read_mhsw = mysqli_fetch_array($query_mhsw);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Mahasiswa</title>
    <style>
        form {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin: 10px 0 5px;
        }
        input[type="text"], input[type="number"], input[type="submit"] {
            padding: 8px;
            width: 100%;
            max-width: 300px;
        }
        input[type="submit"] {
            cursor: pointer;
            background-color: #4CAF50;
            color: white;
            border: none;
            margin-top: 10px;
        }
    </style>
</head>
<body>

<h2>Edit Mahasiswa</h2>

<form action="update_mahasiswa.php" method="POST">
    <input type="hidden" name="npm" value="<?php echo $read_mhsw['npm']; ?>" />

    <label for="nama">Nama:</label>
    <input type="text" id="nama" name="nama" required value="<?php echo $read_mhsw['nama']; ?>">

    <label for="program_studi">Program Studi:</label>
    <input type="text" id="program_studi" name="program_studi" required value="<?php echo $read_mhsw['program_studi']; ?>">

    <label for="semester">Semester:</label>
    <input type="number" id="semester" name="semester" required value="<?php echo $read_mhsw['semester']; ?>">

    <label for="tahun_angkatan">Tahun Angkatan:</label>
    <input type="text" id="tahun_angkatan" name="tahun_angkatan" required value="<?php echo $read_mhsw['tahun_angkatan']; ?>">

    <input type="submit" name="simpan" value="Update Mahasiswa">
</form>

</body>
</html>

