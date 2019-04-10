<?php
require_once 'connection.php';

$link = mysqli_connect($host, $user, $password, $database)
or die("Error: " . mysqli_error($link));

// variables

$genre = strtr($_GET['genre'], '*', '%');
$surname = strtr($_GET['surname'], '*', '%');

// form

echo "<b>BOOK SEARCH</b><br>
<form method='GET' action='search.php'>
<p>Choose genre: <input type='text' name='genre' value='$genre'></p>
<p>The authors surname: <input type='text' name='surname' value='$surname'></p>
<p><input type='submit' name='enter' value='Search'></p>
</form>";

if (isset($_GET['enter'])) {

	$sql = "SELECT b.book_name AS book, b.genre AS genre,
		a.author_surname AS author, a.country AS country
		FROM book b
		JOIN books_authors b_a ON b.id_book = b_a.id_book
		JOIN author a ON a.id_author = b_a.id_author
		WHERE b.genre LIKE '%$genre%' AND a.author_surname LIKE '%$surname%'";

	$qq = mysqli_query($link, $sql);

	echo "Books<br>";
	echo "<table border='1'>
	<tr> 
	<th>book</th>
	<th>genre</th>
	<th>author</th>
	<th>country</th>
	</tr>";

	while($row = mysqli_fetch_array($qq)) {
		echo "<tr>";
		echo "<td>" . $row['book'] . "</td>";
		echo "<td>" . $row['genre'] . "</td>";
		echo "<td>" . $row['author'] . "</td>";
		echo "<td>" . $row['country'] . "</td>";
		echo "</tr>";
	}
		echo "</table>";
}

mysqli_close($link);
?>
