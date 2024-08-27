<?php
// Include the connection code here (or in a separate file and include it)
// ... (Connection code above)
include'./koneksi.php';

// // Query to fetch data from mahasiswa table
// $sql = "SELECT npm, nama, program_studi, semester, tahun_angkatan FROM mahasiswa";
// $result = $db->query($sql);

// $sort = isset($_GET['sort']) ? $_GET['sort'] : 'npm';
// $order = isset($_GET['order']) && $_GET[order'] == 'desc' ? 'desc' : 'asc';
$search = isset($_GET['search']) ? $_GET['search'] : '';

// SQL query with ORDER BY
$sql = "SELECT npm, nama, program_studi, semester, tahun_angkatan 
        FROM mahasiswa 
        WHERE nama LIKE '%$search%' 
        OR npm LIKE '%$search%' 
        OR program_studi LIKE '%$search%' 
        OR tahun_angkatan LIKE '%$search%' 
        ORDER BY npm ASC";
$result = $db->query($sql);
?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Data Mahasiswa</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

<h2>Data Mahasiswa</h2>

<button>
    <a href="./mahasiswa.php">Tambah Mahasiswa</a>
</button>

<form method="GET" action="">
    <input type="text" name="search" placeholder="Cari mahasiswa...">
    <input type="submit" value="Search">
</form>

<table border='1'>
     <tr>
        <th><a href="?sort=npm&order=<?php echo (isset($_GET['order']) && $_GET['order'] == 'asc') ? 'desc' : 'asc'; ?>">NPM</a></th>
        <th><a href="?sort=nama&order=<?php echo (isset($_GET['order']) && $_GET['order'] == 'asc') ? 'desc' : 'asc'; ?>">Nama</a></th>
        <th><a href="?sort=program_studi&order=<?php echo (isset($_GET['order']) && $_GET['order'] == 'asc') ? 'desc' : 'asc'; ?>">Program Studi</a></th>
        <th><a href="?sort=semester&order=<?php echo (isset($_GET['order']) && $_GET['order'] == 'asc') ? 'desc' : 'asc'; ?>">Semester</a></th>
        <th><a href="?sort=tahun_angkatan&order=<?php echo (isset($_GET['order']) && $_GET['order'] == 'asc') ? 'desc' : 'asc'; ?>">Tahun Angkatan</a></th>
        <th>Actions</th>
    </tr>
    <?php
    if ($result->num_rows > 0) {
        while($row = $result->fetch_assoc()) {
            echo "<tr>";
            echo "<td>" . $row["npm"] . "</td>";
            echo "<td>" . $row["nama"] . "</td>";
            echo "<td>" . $row["program_studi"] . "</td>";
            echo "<td>" . $row["semester"] . "</td>";
            echo "<td>" . $row["tahun_angkatan"] . "</td>";
            echo "<td><a href='edit_mhsw.php?id=". $row['npm'] ."'>Edit</a><br>
                <a href='hapus_mhsw.php?id=". $row['npm'] ."'>hapus</a>
                </td>";
            echo "</tr>";
        }
    } else {
        echo "<tr><td colspan='5'>No data available</td></tr>";
    };
    ?>

</table>

</body>
</html>

<?php
// Close the connection
$db->close();
?>

