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
