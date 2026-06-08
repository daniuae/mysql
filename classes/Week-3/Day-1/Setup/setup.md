# Python Project Setup with `.env` in VS Code (Ubuntu)

## Prerequisites

* Ubuntu Linux
* Python 3 installed
* Visual Studio Code installed

---

# Step 1: Open Terminal

Press:

```text
Ctrl + Alt + T
```

Check Python version:

```bash
python3 --version
```

Example:

```text
Python 3.12.3
```

---

# Step 2: Create Project Folder

Navigate to your workspace:

```bash
cd ~/Documents
```

Create project directory:

```bash
mkdir PythonTraining
```

Move into project:

```bash
cd PythonTraining
```

Verify:

```bash
pwd
```

Output:

```text
/home/user/Documents/PythonTraining
```

---

# Step 3: Open Project in VS Code

From terminal:

```bash
code .
```

If `code` command is not found:

1. Open VS Code
2. Press:

```text
Ctrl + Shift + P
```

3. Search:

```text
Shell Command: Install 'code' command in PATH
```

4. Retry:

```bash
code .
```

---

# Step 4: Create Python Virtual Environment (.env)

Inside project folder:

```bash
python3 -m venv .env
```

Folder structure:

```text
PythonTraining/
└── .env/
```

Verify:

```bash
ls -la
```

---

# Step 5: Activate Virtual Environment

```bash
source .env/bin/activate
```

Expected:

```bash
(.env) user@ubuntu:~/Documents/PythonTraining$
```

---

# Step 6: Upgrade pip

```bash
pip install --upgrade pip
```

Verify:

```bash
pip --version
```

---

# Step 7: Install Required Packages

Example:

```bash
pip install pandas numpy requests
```

Verify:

```bash
pip list
```

---

# Step 8: Configure VS Code Python Interpreter

Press:

```text
Ctrl + Shift + P
```

Search:

```text
Python: Select Interpreter
```

Select:

```text
PythonTraining/.env/bin/python
```

Example:

```text
Python 3.12 (.env)
```

---

# Step 9: Create Project Structure

Create folders:

```bash
mkdir src
mkdir tests
```

Create files:

```bash
touch src/main.py
touch requirements.txt
touch README.md
```

Project structure:

```text
PythonTraining/
├── .env/
├── src/
│   └── main.py
├── tests/
├── requirements.txt
└── README.md
```

---

# Step 10: Create First Python Program

Open:

```text
src/main.py
```

Add:

```python
print("Hello Python Project")
```

Run:

```bash
python src/main.py
```

Output:

```text
Hello Python Project
```

---

# Step 11: Save Dependencies

Generate requirements file:

```bash
pip freeze > requirements.txt
```

View:

```bash
cat requirements.txt
```

Example:

```text
numpy==2.3.1
pandas==2.3.1
requests==2.32.4
```

---

# Step 12: Create `.gitignore`

Create file:

```bash
touch .gitignore
```

Add:

```gitignore
.env/
__pycache__/
*.pyc
.vscode/
```

---

# Step 13: Initialize Git Repository

```bash
git init
```

Add files:

```bash
git add .
```

Commit:

```bash
git commit -m "Initial Commit"
```

---

# Recommended Data Engineering Project Structure

```text
PythonTraining/
│
├── .env/
├── src/
│   ├── main.py
│   ├── extract.py
│   ├── transform.py
│   └── load.py
│
├── config/
│   └── config.yaml
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── output/
│
├── tests/
├── logs/
├── requirements.txt
├── .gitignore
├── README.md
└── setup.py
```

---

# One-Shot Setup Commands

```bash
mkdir PythonTraining

cd PythonTraining

python3 -m venv .env

source .env/bin/activate

pip install --upgrade pip

mkdir src tests

touch src/main.py

touch requirements.txt README.md .gitignore

code .
```

---

# Verification

Check active Python interpreter:

```bash
which python
```

Expected output:

```text
.../PythonTraining/.env/bin/python
```

Run application:

```bash
python src/main.py
```

Expected output:

```text
Hello Python Project
```

---

## Summary

You now have:

* A dedicated Python project folder
* A virtual environment (`.env`)
* VS Code configured with the correct interpreter
* Git initialized
* A scalable project structure suitable for Python, ETL, ELT, Data Engineering, and Machine Learning projects
