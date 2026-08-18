# ============================================================
# 1. CHECK MYSQL
# ============================================================

sudo service mysql status

# If MySQL is stopped:
sudo service mysql start


# ============================================================
# 2. TRY TO LOGIN AS MYSQL ROOT
# ============================================================

sudo mysql


# ============================================================
# 3. IF "sudo mysql" WORKS
#    Run the following INSIDE mysql>
# ============================================================

SELECT USER(), CURRENT_USER();

SELECT user, host, plugin
FROM mysql.user
WHERE user = 'root';

ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'Root@12345';

FLUSH PRIVILEGES;

GRANT ALL PRIVILEGES
ON *.*
TO 'root'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'root'@'localhost';

EXIT;


# ============================================================
# 4. TEST ROOT LOGIN
# ============================================================

mysql -u root -p

# Password:
# Root@12345


# ============================================================
# 5. IF "sudo mysql" GIVES:
#
# ERROR 1045 (28000):
# Access denied for user 'root'@'localhost'
#
# THEN RESET ROOT PASSWORD
# ============================================================

sudo service mysql stop

sudo mysqld_safe --skip-grant-tables --skip-networking &

# Wait a few seconds, then:

mysql -u root


# ============================================================
# 6. INSIDE mysql>
# ============================================================

FLUSH PRIVILEGES;

ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY 'Root@12345';

FLUSH PRIVILEGES;

EXIT;


# ============================================================
# 7. STOP RECOVERY MODE
# ============================================================

sudo service mysql stop

# If necessary:
sudo pkill mysqld


# ============================================================
# 8. START MYSQL NORMALLY
# ============================================================

sudo service mysql start

sudo service mysql status


# ============================================================
# 9. LOGIN AS ROOT
# ============================================================

mysql -u root -p

# Password:
# Root@12345


# ============================================================
# 10. GRANT FULL PRIVILEGES
#    Run inside mysql>
# ============================================================

GRANT ALL PRIVILEGES
ON *.*
TO 'root'@'localhost'
WITH GRANT OPTION;

FLUSH PRIVILEGES;

SHOW GRANTS FOR 'root'@'localhost';


# ============================================================
# 11. FINAL TEST
# ============================================================

CREATE DATABASE smartdb;

SHOW DATABASES;

USE smartdb;

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO employees VALUES (1, 'Dani');

SELECT * FROM employees;
