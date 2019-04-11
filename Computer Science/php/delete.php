<?php
# PHP Version 5.3.13

require_once 'connection.php';

$link = mysqli_connect($host, $user, $password, $database) or die("Error: " . mysqli_error($link));

header("Location: list.php");


$id_book = $_GET['id_book'];

$sq1 = "DELETE
		FROM books_authors
		WHERE id_book = '" . $id_book . "';";

$sq2 = "DELETE
		FROM selling
		WHERE id_book = '" . $id_book . "';";

$sq3 = "DELETE
		FROM book
		WHERE id_book = '" . $id_book . "';";

$query1 = mysqli_query($link, $sq1);
$query2 = mysqli_query($link, $sq2);
$query3 = mysqli_query($link, $sq3);

mysqli_close($link);

?>
