<?php
require_once 'connection.php';

$link = mysqli_connect($host, $user, $password, $database) or die("Error: " . mysqli_error($link));


// CREATE TABLE publishing_house


$sql = "CREATE TABLE publishing_house ( 
    code_publication int(5) NOT NULL,
    id_izdatel int(5) NOT NULL,
    city_izdatel varchar(50) NOT NULL,
    contacts_house varchar(50) NOT NULL,
    about_izdatel varchar(50) NOT NULL,
    logo varchar(50) NOT NULL,
    PRIMARY KEY (code_publication))";

if (mysqli_query($link, $sql)) {
	echo "Table 'publishing_house' created successfully";
} else {
	echo "Error: " . mysqli_error($link);
}
echo "<br>";

$sqql = "INSERT INTO publishing_house VALUES
('1234', '123456', 'SPb', '5435435', 'Litera', 'req.png'),
('2345', '234567', 'Kazan', '9873546', 'April', 'altyn.png')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'publishing_house'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";

$qq = mysqli_query($link, "SELECT * FROM publishing_house");

echo "Publishing house";
echo "<table border='1'>
<tr>
<th>code_publication</th>
<th>id_izdatel</th>
<th>city_izdatel</th>
<th>contacts_house</th>
<th>about_izdatel</th>
<th>logo</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['code_publication'] . "</td>";
echo "<td>" . $row['id_izdatel'] . "</td>";
echo "<td>" . $row['city_izdatel'] . "</td>";
echo "<td>" . $row['contacts_house'] . "</td>";
echo "<td>" . $row['about_izdatel'] . "</td>";
echo "<td>" . $row['logo'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE storage


$sql = "CREATE TABLE storage ( 
    id_stor int(5) NOT NULL,
    num_shel int(5) NOT NULL,
    num_books_st int(5) NOT NULL,
    num_rack int(5) NOT NULL,
    dopolnitelno varchar(50) NOT NULL,
    PRIMARY KEY (id_stor))";

if (mysqli_query($link, $sql)) {
    echo "Table 'storage' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO storage VALUES
('1', '1200', '6543', '45', 'common'),
('2', '1300', '5734', '40', 'special'),
('3', '200', '400', '20', 'unique')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'storage'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM storage");

echo "Storage";
echo "<table border='1'>
<tr>
<th>id_stor</th>
<th>num_shel</th>
<th>num_books_st</th>
<th>num_rack</th>
<th>dopolnitelno</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_stor'] . "</td>";
echo "<td>" . $row['num_shel'] . "</td>";
echo "<td>" . $row['num_books_st'] . "</td>";
echo "<td>" . $row['num_rack'] . "</td>";
echo "<td>" . $row['dopolnitelno'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE book


$sql = "CREATE TABLE book ( 
    id_book int(5) NOT NULL,
    book_name varchar(50) NOT NULL,
    genre varchar(50) NOT NULL,
    year int(4) NOT NULL,
    price int(5) NOT NULL,
    annotation varchar(50) NOT NULL,
    shelf_num int(5) NOT NULL,
    copies int(5) NOT NULL,
    code_publication int(5) NOT NULL,
    id_stor int(5) NOT NULL,
    PRIMARY KEY (id_book),
    FOREIGN KEY (code_publication) REFERENCES publishing_house (code_publication),
    FOREIGN KEY (id_stor) REFERENCES storage (id_stor))";

if (mysqli_query($link, $sql)) {
    echo "Table 'book' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO book VALUES
('123', 'Baskerville Dog', 'detective', '1901', '400', 'abv', '567', '10', '1234', '1'),
('234', 'Pim', 'novel', '1838', '300', 'mysterious', '450', '3', '2345', '2'),
('345', 'The man who laughs', 'historical novel', '1869', '250', 'good', '8', '2', '1234', '2'),
('456', 'Les Miserables', 'historical novel', '1862', '350', 'toosee', '40', '1', '2345', '1'),
('567', 'War and Peace', 'novel', '1867', '800', 'sky', '3', '10', '1234', '3'),
('678', 'Idiot', 'novel', '1869', '759', 'indeed', '1', '14', '2345', '2')
";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'book'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM book");

echo "";
echo "<table border='1'>
<tr>
<th>id_book</th>
<th>book_name</th>
<th>genre</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_book'] . "</td>";
echo "<td>" . $row['book_name'] . "</td>";
echo "<td>" . $row['genre'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE client


$sql = "CREATE TABLE client ( 
    card_num int(10) NOT NULL,
    client_name varchar(50) NOT NULL,
    client_phone int(10) NOT NULL,
    client_mail varchar(50) NOT NULL,
    discount_card varchar(50) NOT NULL,
    PRIMARY KEY (card_num))";

if (mysqli_query($link, $sql)) {
    echo "Table 'client' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO client VALUES
('545646546', 'Fakhriev D.', '567890', 'erd@mail.ru', 'yes'),
('123456789', 'Chepkasov M.', '876904', 'tenthgr@mail.ru', 'yes')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'client'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM client");

echo "Client";
echo "<table border='1'>
<tr>
<th>card_num</th>
<th>client_name</th>
<th>client_phone</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['card_num'] . "</td>";
echo "<td>" . $row['client_name'] . "</td>";
echo "<td>" . $row['client_phone'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE seller


$sql = "CREATE TABLE seller ( 
    id_seller int(5) NOT NULL,
    seller_name varchar(50) NOT NULL,
    seller_photo varchar(50) NOT NULL,
    seller_phone int(10) NOT NULL,
    seller_mail varchar(50) NOT NULL,
    seller_seniority int(5) NOT NULL,
    PRIMARY KEY (id_seller))";

if (mysqli_query($link, $sql)) {
    echo "Table 'seller' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO seller VALUES
('1253', 'Khakimov R.', 'yuyu7y.png', '76756', 'ef@gmail.com', '4'),
('1254', 'Ivanov D.', 'hist.png', '87845', 'ivdn@gmail.com', '2')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'seller'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM seller");

echo "Seller";
echo "<table border='1'>
<tr>
<th>id_seller</th>
<th>seller_phone</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_seller'] . "</td>";
echo "<td>" . $row['seller_phone'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE author


$sql = "CREATE TABLE author ( 
    id_author int(5) NOT NULL,
    author_surname varchar(50) NOT NULL,
    author_name varchar(50) NOT NULL,
    author_photo varchar(50) NOT NULL,
    country varchar(50) NOT NULL,
    used_genres varchar(50) NOT NULL,
    PRIMARY KEY (id_author))";

if (mysqli_query($link, $sql)) {
    echo "Table 'author' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO author VALUES
('7', 'Conan Doyle', 'Arthur', 'freq.png', 'Great Britain', 'detective'),
('5', 'Allan Po', 'Edgar', 'myst.png', 'USA', 'novel, detective, science fiction'),
('1', 'Hugo', 'Victor', 'hh.png', 'France', 'novel, history, drama'),
('2', 'Tolstoy', 'Leo', 'litwater.png', 'Russia', 'novel'),
('3', 'Dostoyevsky', 'Fyodor', 'rel.png', 'Russia', 'novel, philosophy')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'author'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM author");

echo "Author";
echo "<table border='1'>
<tr>
<th>id_author</th>
<th>author_surname</th>
<th>author_name</th>
<th>country</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_author'] . "</td>";
echo "<td>" . $row['author_surname'] . "</td>";
echo "<td>" . $row['author_name'] . "</td>";
echo "<td>" . $row['country'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE selling


$sql = "CREATE TABLE selling ( 
    id_selling int(5) NOT NULL,
    books_num int(5) NOT NULL,
    id_book int(5) NOT NULL,
    card_num int(10) NOT NULL,
    id_seller int(5) NOT NULL,
    PRIMARY KEY (id_selling),
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (card_num) REFERENCES client (card_num),
    FOREIGN KEY (id_seller) REFERENCES seller (id_seller))";

if (mysqli_query($link, $sql)) {
    echo "Table 'selling' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO selling VALUES
('2', '3', '123', '545646546', '1253'),
('23', '1', '234', '123456789', '1254')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'selling'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM selling");

echo "Selling";
echo "<table border='1'>
<tr>
<th>id_selling</th>
<th>books_num</th>
<th>id_book</th>
<th>card_num</th>
<th>id_seller</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_selling'] . "</td>";
echo "<td>" . $row['books_num'] . "</td>";
echo "<td>" . $row['id_book'] . "</td>";
echo "<td>" . $row['card_num'] . "</td>";
echo "<td>" . $row['id_seller'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";



// CREATE TABLE books_authors


$sql = "CREATE TABLE books_authors ( 
    id_book int(5) NOT NULL,
    id_author int(5) NOT NULL,
    PRIMARY KEY (id_book),
    FOREIGN KEY (id_book) REFERENCES book (id_book),
    FOREIGN KEY (id_author) REFERENCES author (id_author))";

if (mysqli_query($link, $sql)) {
    echo "Table 'books_authors' created successfully";
} else {
    echo "Error: " . mysqli_error($link);
}
echo "<br>";


$sqql = "INSERT INTO books_authors VALUES
('123', '7'),
('234', '5'),
('345', '1'),
('456', '1'),
('567', '2'),
('678', '3')";

if ($link->query($sqql) === TRUE) {
    echo "New record created successfully in 'books_authors'";
} else {
    echo "Error: " . $sqqll . $link->error;
}
echo "<br><br>";


$qq = mysqli_query($link, "SELECT * FROM books_authors");

echo "Books_authors";
echo "<table border='1'>
<tr>
<th>id_book</th>
<th>id_author</th>
</tr>";

while($row = mysqli_fetch_array($qq))
{
echo "<tr>";
echo "<td>" . $row['id_book'] . "</td>";
echo "<td>" . $row['id_author'] . "</td>";
echo "</tr>";
}
echo "</table>";
echo "<br>";


mysqli_close($link);
?>
