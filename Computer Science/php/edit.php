<?php
# PHP Version 5.3.13

require_once "connection.php";

$link = mysqli_connect($host, $user, $password, $database) or die("Error: " . mysqli_error($link));


echo "Enter updated info:<br>";

$id_book = $_GET['id_book'];

$sq1 = "SELECT b.id_book AS id_book, b.book_name AS book_name,
	b.genre AS genre, b.price AS price, s.id_stor AS id_stor
	FROM book b
	JOIN storage s ON s.id_stor = b.id_stor
	WHERE b.id_book = '" . $id_book . "';";

$q1 = mysqli_query($link, $sq1);
$books_info = mysqli_fetch_array($q1);

$sq2 = "SELECT * FROM storage;";
$q2 = mysqli_query($link, $sq2);

?>


<html>
	<body>
		<form action="edit2.php" method="get">
			<input type="hidden" name="id_book" value=<?php echo $id_book; ?>><br>
			Book name:
				<input type="text" name="book_name" value=<?php echo $books_info['book_name']; ?>><br><br>
			Genre:
				<input type="text" name="genre" value=<?php echo $books_info['genre']; ?>><br><br>
			Price:
				<input type="text" name="price" value=<?php echo $books_info['price']; ?>><br><br>
			Storage id:
				<select name="id_stor">
				<?php 
					while($row = mysqli_fetch_array($q2)) {
						echo $row;
						if ($row['id_stor'] == $books_info['id_stor'])
							echo "<option selected value='" . $row['id_stor'] . "'>" . $row['id_stor'] . "</option>";
						else
							echo "<option value='" . $row['id_stor'] . "'>" . $row['id_stor'] . "</option>";                    
					}
				?>
				</select><br><br>
			<input type="submit" value="Save changes">
		</form>
	</body>
</html>
