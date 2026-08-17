# MySQL Troubleshooting in WSL — systemd Error

## Step 1 — Check PID 1

Run:

```bash
ps -p 1 -o comm=
```

If you get:

```text
init
```

instead of:

```text
systemd
```

then `systemctl` will not work.

---

## Step 2 — Try Starting MySQL Without systemd

Run:

```bash
sudo service mysql start
```

Then:

```bash
sudo service mysql status
```

If it says something like:

```text
mysql: unrecognized service
```

or fails to start, run:

```bash
sudo service --status-all
```

---

## Step 3 — Check Whether MySQL Is Actually Installed

Run:

```bash
mysql --version
```

Then:

```bash
dpkg -l | grep mysql
```

---

# If You Are Using WSL

This is very likely the cause.

Check WSL from **Windows PowerShell**, not the VS Code terminal:

```powershell
wsl --status
```

Then, inside Ubuntu, run:

```bash
cat /etc/wsl.conf
```

If `/etc/wsl.conf` does not contain the following configuration:

```ini
[boot]
systemd=true
```

edit the file:

```bash
sudo nano /etc/wsl.conf
```

Add:

```ini
[boot]
systemd=true
```

Save the file:

**Ctrl + O → Enter → Ctrl + X**

---

# Step 4 — Completely Restart WSL

Close Ubuntu/VS Code terminals.

Open **Windows PowerShell** and run:

```powershell
wsl --shutdown
```

Open Ubuntu again.

Now check PID 1:

```bash
ps -p 1 -o comm=
```

You should now see:

```text
systemd
```

---

# Step 5 — Start MySQL

Once PID 1 shows `systemd`, run:

```bash
sudo systemctl start mysql
```

Check the status:

```bash
sudo systemctl status mysql
```

If MySQL is running, you should see something similar to:

```text
Active: active (running)
```

---

# Important

Do **not** repeatedly run:

```bash
sudo systemctl start mysql
```

until:

```bash
ps -p 1 -o comm=
```

shows:

```text
systemd
```

The error:

```text
System has not been booted with systemd as init system (PID 1)
Failed to connect to bus
```

is happening **before MySQL is even being managed**.

---

# If It Still Does Not Work

Paste the output of these three commands:

```bash
ps -p 1 -o comm=
```

```bash
mysql --version
```

```bash
sudo service mysql status
```

These three outputs will tell us whether the problem is:

1. WSL systemd configuration
2. MySQL installation
3. MySQL service configuration
4. MySQL startup failure








# Fixing MySQL Root Authentication in Ubuntu (WSL/Linux)

If you're getting:

```text
Access denied for user 'root'@'localhost'
```

follow the steps below to configure the MySQL root account correctly.

---

# Step 1: Log in Using Ubuntu's MySQL Root Authentication

Run:

```bash
sudo mysql
```

If successful, you should see:

```text
Welcome to the MySQL monitor.
mysql>
```

If this command fails, note the exact error message before proceeding.

---

# Step 2: Check the Root Authentication Plugin

Inside the MySQL prompt, run:

```sql
SELECT user,
       host,
       plugin
FROM mysql.user
WHERE user = 'root';
```

Example output:

| user | host | plugin |
|------|------|--------|
| root | localhost | auth_socket |

If the plugin is:

```text
auth_socket
```

then:

```bash
sudo mysql
```

works because Ubuntu authenticates using your Linux account.

However,

```bash
mysql -u root -p
```

will fail until password authentication is configured.

---

# Step 3: Configure a Password for Root

Inside the MySQL prompt, execute:

```sql
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'YourStrongPassword';

FLUSH PRIVILEGES;
```

Replace:

```text
YourStrongPassword
```

with a secure password.

Example:

```sql
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password
BY 'Root@12345';

FLUSH PRIVILEGES;
```

---

# Step 4: Exit MySQL

```sql
EXIT;
```

---

# Step 5: Test Password Authentication

Run:

```bash
mysql -u root -p
```

Enter the password you configured.

If successful, you'll see:

```text
Welcome to the MySQL monitor.
mysql>
```

---

# If `sudo mysql` Also Gives "Access Denied"

Check whether the MySQL server is actually running.

### Check MySQL Service Status

```bash
sudo systemctl status mysql
```

> **Note (WSL Users):**
>
> If you receive:
>
> ```text
> System has not been booted with systemd as init system (PID 1).
> Failed to connect to bus: Host is down
> ```
>
> your WSL instance is not using `systemd`, so `systemctl` cannot be used.

Instead, run:

```bash
sudo service mysql status
```

or

```bash
sudo service mysql start
```

---

# Check if MySQL Server Is Running

Run:

```bash
sudo mysqladmin ping
```

If MySQL is running, you'll get:

```text
mysqld is alive
```

This means:

- The MySQL server is running.
- Only the authentication method needs to be corrected.

---

# If Authentication Still Fails

Please copy and paste the output of the following commands:

### 1. Login Using Sudo

```bash
sudo mysql
```

### 2. Password Login

```bash
mysql -u root -p
```

### 3. Check MySQL Service

For WSL (without systemd):

```bash
sudo service mysql status
```

For a normal Ubuntu installation (with systemd):

```bash
sudo systemctl status mysql
```

### 4. Check Server Status

```bash
sudo mysqladmin ping
```

---

# Expected Outcome

After completing the above steps, you should be able to log in using either:

Using Linux authentication:

```bash
sudo mysql
```

Or using password authentication:

```bash
mysql -u root -p
```

---

# Troubleshooting Summary

| Problem | Solution |
|---------|----------|
| `Access denied for user 'root'@'localhost'` | Configure password authentication using `ALTER USER` |
| `auth_socket` plugin | `sudo mysql` works, password login doesn't until changed |
| `systemctl` fails in WSL | Use `sudo service mysql start` instead |
| `mysqld is alive` | MySQL is running; fix authentication only |
| `Can't connect to local MySQL server` | Start the MySQL service |

---

If you share the outputs of:

```bash
sudo mysql
```

and

```bash
mysql -u root -p
```

I can tell you the exact next command without resetting or reinstalling your MySQL server.






# Fixing MySQL Error 1045 (Access Denied for `root@localhost`)

If you're seeing the following error:

```text
ERROR 1045 (28000): Access denied for user 'root'@'localhost'
(using password: NO)
```

follow these steps carefully.

> **Note:** These steps are intended for Ubuntu or WSL installations of MySQL.

---

# Step 1: Check MySQL Service Status

Check whether the MySQL service is running.

```bash
sudo service mysql status
```

### If MySQL is Running

Proceed to **Step 2**.

### If MySQL is Stopped

Start the service:

```bash
sudo service mysql start
```

Verify that it is running:

```bash
sudo service mysql status
```

---

# Step 2: Stop the MySQL Service

Stop MySQL before starting it in recovery mode.

```bash
sudo service mysql stop
```

Verify that it has stopped:

```bash
sudo service mysql status
```

Expected output:

```text
mysql is not running
```

---

# Step 3: Start MySQL in Recovery Mode

Start MySQL without loading the privilege tables.

```bash
sudo mysqld_safe --skip-grant-tables --skip-networking &
```

Wait **5–10 seconds**.

You may see several startup messages. This is normal.

Now try logging in:

```bash
sudo mysql
```

If successful, you should see:

```text
mysql>
```

---

# Step 4: Refresh Privileges

Inside the MySQL prompt, run:

```sql
FLUSH PRIVILEGES;
```

---

# Step 5: Check the Root Authentication Plugin

Run the following SQL command:

```sql
SELECT user,
       host,
       plugin
FROM mysql.user
WHERE user = 'root';
```

Example output:

```text
+------+-----------+-----------------------+
| user | host      | plugin                |
+------+-----------+-----------------------+
| root | localhost | auth_socket           |
+------+-----------+-----------------------+
```

or

```text
+------+-----------+-----------------------+
| user | host      | plugin                |
+------+-----------+-----------------------+
| root | localhost | caching_sha2_password |
+------+-----------+-----------------------+
```

---

# Stop Here

**Do not change the root password yet.**

The next step depends on the authentication plugin currently assigned to the `root` account.

Please copy and paste the output of:

```sql
SELECT user,
       host,
       plugin
FROM mysql.user
WHERE user = 'root';
```

Based on the result, we can determine the correct authentication method (`auth_socket`, `mysql_native_password`, `caching_sha2_password`, or another plugin) and safely configure the `root` account.

---

# If `mysqld_safe` Fails

If the following command:

```bash
sudo mysqld_safe --skip-grant-tables --skip-networking &
```

returns an error, copy and paste the complete error message.

That will help determine whether the issue is related to:

- MySQL not being installed correctly
- Incorrect data directory permissions
- A corrupted MySQL configuration
- Another MySQL startup problem

Once the exact error is available, the next troubleshooting step can be identified without reinstalling MySQL.

---

# Summary

1. Check whether MySQL is running.
2. Stop the MySQL service.
3. Start MySQL in recovery mode using `mysqld_safe`.
4. Log in using `sudo mysql`.
5. Run `FLUSH PRIVILEGES;`.
6. Check the `root` authentication plugin.
7. Share the output before making any changes to the `root` account.
