<?php
# PHP Version 5.3.13

require_once 'connection.php';
 
$link = mysqli_connect($host, $user, $password, $database) or die("Error: " . mysqli_error($link));

header("Location: list.php");


$id_book = $_GET['id_book'];
$book_name = $_GET['book_name'];
$genre = $_GET['genre'];
$price = $_GET['price'];
$id_stor = $_GET['id_stor'];

$sq1 = "UPDATE book
        SET book_name = '" . $book_name . "',
        	genre = '" . $genre . "',
        	price = '" . $price . "',
        	id_stor = '" . $id_stor . "'
        WHERE id_book=" . $id_book . ";";

$q1 = mysqli_query($link, $sq1);


mysqli_close($link);

?>
