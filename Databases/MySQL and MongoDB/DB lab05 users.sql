# 1. Директор 

INSERT INTO user (host, user, authentication_string, ssl_cipher, x509_issuer, x509_subject)
VALUES ('localhost', 'director', 'director', '', '', '');

INSERT INTO db (host, user, db, 
	select_priv,
	insert_priv,
	update_priv,
	delete_priv,
	create_priv,
	drop_priv,
	grant_priv
) VALUES ('localhost', 'director', 'database', 'Y','Y','Y','Y','Y','Y','Y');


# 2. Разработчик

INSERT INTO user (host, user, authentication_string, ssl_cipher, x509_issuer, x509_subject)
VALUES ('localhost', 'developer', 'developer', '', '', '');

INSERT INTO db (host, user, db, 
	alter_priv,
	delete_priv,
	create_priv
) VALUES ('localhost', 'developer', 'database', 'Y','Y','Y');


# 3. Модератор

INSERT INTO user (host, user, authentication_string, ssl_cipher, x509_issuer, x509_subject)
VALUES ('localhost', 'moderator', 'moderator', '', '', '');

INSERT INTO db (host, user, db, 
	select_priv,
	insert_priv,
	update_priv,
	delete_priv
) VALUES ('localhost', 'moderator', 'database', 'Y','Y','Y','Y');


# 4. Кадровый управляющий

INSERT INTO user (host, user, authentication_string, ssl_cipher, x509_issuer, x509_subject)
VALUES ('localhost', 'manager', 'manager', '', '', '');

INSERT INTO db (host, user, db, 
	select_priv,
	update_priv
) VALUES ('localhost', 'manager', 'database', 'Y','Y');


# 5. Сотрудник

INSERT INTO user (host, user, authentication_string, ssl_cipher, x509_issuer, x509_subject)
VALUES ('localhost', 'worker', 'worker', '', '', '');

INSERT INTO db (host, user, db, 
	select_priv,
	insert_priv
) VALUES ('localhost', 'worker', 'database', 'Y','Y');


# Доступ к бд с localhost или c 192.168.15.61
GRANT ALL ON dbase.* TO 'localhost"@"%' IDENTIFIED BY 'authentication_string';
GRANT ALL ON dbase.* TO '%"@"192.168.15.61' IDENTIFIED BY 'authentication_string';

# Проверяем данные
select host, user, db, select_priv, insert_priv, create_priv, grant_priv from db;
select host, user, authentication_string from user;
