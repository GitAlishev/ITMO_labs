<?php

require_once 'connection.php';

$link = mysqli_connect($host, $user, $password, $database) or die("Error: " . mysqli_error($link));

echo "Connection successful.<br><br>";


$sql = "SELECT b.id_book AS id_book, b.book_name AS book_name,
	b.genre AS genre, b.price AS price, s.id_stor AS id_stor
	FROM book b
	JOIN storage s ON s.id_stor = b.id_stor
	ORDER BY b.id_book ASC";

$query = mysqli_query($link, $sql);

echo "Books<br>";
echo "<table border='1'>
<tr>
<th>book</th>
<th>genre</th>
<th>price, rub</th>
<th>storage</th>
<th colspan=2>edit</th>
</tr>";

while($row = mysqli_fetch_array($query)) {
	echo "<tr>";
	echo "<td>" . $row['book_name'] . "</td>";
	echo "<td>" . $row['genre'] . "</td>";
	echo "<td>" . $row['price'] . "</td>";
	echo "<td>" . $row['id_stor'] . "</td>";
	echo "<td><a href='edit.php?id_book=" . $row['id_book'] . "'>update</a></td>";
	echo "<td><a href='delete.php?id_book=" . $row['id_book'] . "'>delete</a></td>";
	echo "</tr>";
}
echo "</table>";
echo "<br>";


mysqli_close($link);
?>
