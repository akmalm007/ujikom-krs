<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tambah Mahasiswa</title>
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

<h2>Tambah Mahasiswa Baru</h2>

<form action="tambah_mahasiswa.php" method="POST">
    <label for="nama">Nama:</label>
    <input type="text" id="nama" name="nama" required>

    <label for="program_studi">Program Studi:</label>
    <input type="text" id="program_studi" name="program_studi" required>

    <label for="semester">Semester:</label>
    <input type="number" id="semester" name="semester" required>

    <label for="tahun_angkatan">Tahun Angkatan:</label>
    <input type="text" id="tahun_angkatan" name="tahun_angkatan" required>

    <input type="submit" value="Tambah Mahasiswa">
</form>

</body>
</html>

