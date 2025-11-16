# Setup Guide

Let's get your development environment ready. This will take 30-60 minutes depending on your internet speed and computer.

!!! tip "Take Your Time"
    Don't rush this. A proper setup now will save you hours of troubleshooting later. Follow each step carefully and test as you go.

---

## What You'll Install

We'll set up these tools in order:

1. **Python** - Programming language for data work
2. **VS Code** - Code editor
3. **Git** - Version control
4. **PostgreSQL** - Database for practice
5. **Docker** - For running Airflow later
6. **Accounts** - Snowflake, GitHub, dbt Cloud

**Total disk space needed:** ~15GB

---

## Step 1: Install Python

### Check If You Have Python

Open your terminal (Mac/Linux) or Command Prompt (Windows) and type:

```bash
python --version
```

or

```bash
python3 --version
```

If you see `Python 3.10` or higher, you're good! Skip to Step 2.

If not, or if you get an error, continue below.

### Install Python

=== "Windows"
    
    1. Go to [python.org/downloads](https://www.python.org/downloads/)
    2. Download Python 3.11 or 3.12 (latest stable)
    3. Run the installer
    4. **Important:** Check "Add Python to PATH"
    5. Click "Install Now"
    
    **Verify:**
    
    ```cmd
    python --version
    ```
    
    Should show: `Python 3.11.x` or similar

=== "Mac"
    
    **Option 1: Official Installer (Easiest)**
    
    1. Go to [python.org/downloads](https://www.python.org/downloads/)
    2. Download Python 3.11 or 3.12 for macOS
    3. Run the installer
    4. Follow prompts
    
    **Option 2: Homebrew (Recommended if you have it)**
    
    ```bash
    brew install python@3.11
    ```
    
    **Verify:**
    
    ```bash
    python3 --version
    ```

=== "Linux"
    
    Most Linux distributions come with Python. Update if needed:
    
    **Ubuntu/Debian:**
    
    ```bash
    sudo apt update
    sudo apt install python3.11 python3-pip
    ```
    
    **Fedora:**
    
    ```bash
    sudo dnf install python3.11
    ```
    
    **Verify:**
    
    ```bash
    python3 --version
    ```

### Install pip (Python Package Manager)

**Check if you have it:**

```bash
pip --version
```

or

```bash
pip3 --version
```

If you see a version number, you're good. If not:

=== "Windows"
    
    pip usually comes with Python. If missing:
    
    ```cmd
    python -m ensurepip --upgrade
    ```

=== "Mac/Linux"
    
    ```bash
    python3 -m ensurepip --upgrade
    ```

---

## Step 2: Install VS Code

### Download and Install

1. Go to [code.visualstudio.com](https://code.visualstudio.com/)
2. Download for your operating system
3. Run the installer
4. Accept default options

### Recommended Extensions

Open VS Code and install these extensions (click Extensions icon in left sidebar):

1. **Python** (by Microsoft) - Python language support
2. **Pylance** (by Microsoft) - Python IntelliSense
3. **Jupyter** (by Microsoft) - Notebook support
4. **SQLTools** - SQL query support
5. **Git Graph** - Visualise git branches
6. **YAML** - For editing Airflow/dbt files

**To install:**

- Press `Ctrl+Shift+X` (Windows/Linux) or `Cmd+Shift+X` (Mac)
- Search for extension name
- Click "Install"

---

## Step 3: Install Git

### Check If You Have Git

```bash
git --version
```

If you see a version number, skip to "Configure Git" below.

### Install Git

=== "Windows"
    
    1. Go to [git-scm.com/download/win](https://git-scm.com/download/win)
    2. Download Git for Windows
    3. Run installer
    4. **Important settings during install:**
        - Select "Git from the command line and also from 3rd-party software"
        - Select "Use Visual Studio Code as Git's default editor"
        - Keep other defaults
    
    **Verify:**
    
    ```cmd
    git --version
    ```

=== "Mac"
    
    **Option 1: Xcode Command Line Tools**
    
    ```bash
    xcode-select --install
    ```
    
    **Option 2: Homebrew**
    
    ```bash
    brew install git
    ```
    
    **Verify:**
    
    ```bash
    git --version
    ```

=== "Linux"
    
    **Ubuntu/Debian:**
    
    ```bash
    sudo apt install git
    ```
    
    **Fedora:**
    
    ```bash
    sudo dnf install git
    ```
    
    **Verify:**
    
    ```bash
    git --version
    ```

### Configure Git

Set your name and email (used in commit messages):

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

**Verify:**

```bash
git config --list
```

---

## Step 4: Install PostgreSQL

### Why PostgreSQL?

We'll use PostgreSQL as a practice database. It's free, widely used, and similar to production databases you'll encounter.

### Install PostgreSQL

=== "Windows"
    
    1. Go to [postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
    2. Download the installer (version 15 or 16)
    3. Run installer
    4. **Settings:**
        - Password: Choose something you'll remember (e.g., `postgres`)
        - Port: 5432 (default)
        - Locale: Default
    5. Finish installation
    
    **Verify:**
    
    Open Command Prompt:
    
    ```cmd
    psql --version
    ```

=== "Mac"
    
    **Option 1: Postgres.app (Easiest)**
    
    1. Go to [postgresapp.com](https://postgresapp.com/)
    2. Download and drag to Applications
    3. Open Postgres.app
    4. Click "Initialize" to create default server
    
    **Option 2: Homebrew**
    
    ```bash
    brew install postgresql@15
    brew services start postgresql@15
    ```
    
    **Verify:**
    
    ```bash
    psql --version
    ```

=== "Linux"
    
    **Ubuntu/Debian:**
    
    ```bash
    sudo apt install postgresql postgresql-contrib
    sudo systemctl start postgresql
    ```
    
    **Fedora:**
    
    ```bash
    sudo dnf install postgresql-server postgresql-contrib
    sudo postgresql-setup --initdb
    sudo systemctl start postgresql
    ```
    
    **Verify:**
    
    ```bash
    psql --version
    ```

### Test PostgreSQL Connection

Try connecting to the database:

=== "Windows"
    
    ```cmd
    psql -U postgres
    ```
    
    Enter your password when prompted.

=== "Mac"
    
    ```bash
    psql postgres
    ```

=== "Linux"
    
    ```bash
    sudo -u postgres psql
    ```

You should see a prompt like:

```
postgres=#
```

Type `\q` to exit.

---

## Step 5: Install Docker

### Why Docker?

We'll use Docker to run Apache Airflow locally. It packages everything you need in containers.

### Install Docker Desktop

=== "Windows"
    
    **Requirements:**
    
    - Windows 10 64-bit: Pro, Enterprise, or Education (Build 19041 or higher)
    - Or Windows 11
    - Enable WSL 2 (Windows Subsystem for Linux)
    
    **Steps:**
    
    1. Go to [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
    2. Download Docker Desktop for Windows
    3. Run installer
    4. Follow prompts (enable WSL 2 when asked)
    5. Restart computer
    6. Open Docker Desktop
    
    **Verify:**
    
    ```cmd
    docker --version
    docker-compose --version
    ```

=== "Mac"
    
    1. Go to [docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop/)
    2. Download Docker Desktop for Mac
        - Choose Apple Silicon or Intel based on your Mac
    3. Drag to Applications
    4. Open Docker Desktop
    5. Grant permissions when prompted
    
    **Verify:**
    
    ```bash
    docker --version
    docker-compose --version
    ```

=== "Linux"
    
    **Ubuntu/Debian:**
    
    ```bash
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    
    # Add your user to docker group
    sudo usermod -aG docker $USER
    
    # Install Docker Compose
    sudo apt install docker-compose
    
    # Log out and back in for group changes
    ```
    
    **Verify:**
    
    ```bash
    docker --version
    docker-compose --version
    ```

### Test Docker

Run a test container:

```bash
docker run hello-world
```

You should see a "Hello from Docker!" message.

---

## Step 6: Create Online Accounts

### GitHub Account

**Why:** Store your code, collaborate, deploy your site

1. Go to [github.com/signup](https://github.com/signup)
2. Create account (free tier is fine)
3. Verify your email
4. Choose a username you're happy with (it's public)

### Snowflake Account

**Why:** Cloud data warehouse for storing and querying data

1. Go to [signup.snowflake.com](https://signup.snowflake.com/)
2. Choose "Standard" edition
3. Select cloud provider (AWS, Azure, or GCP - doesn't matter for learning)
4. Choose region close to you
5. Complete registration
6. **Note your account URL** (e.g., `https://abc1234.snowflakecomputing.com`)

**Free trial:** 30 days, £400 credit (more than enough for this course)

### dbt Cloud Account

**Why:** Transform data with SQL models

1. Go to [cloud.getdbt.com/signup](https://cloud.getdbt.com/signup)
2. Sign up with email or GitHub
3. Choose "Developer" plan (free)
4. Complete setup

---

## Step 7: Install Python Packages

We'll install common packages you'll use throughout the course.

### Create Project Directory

```bash
# Create directory
mkdir data-roles-practice
cd data-roles-practice
```

### Create Virtual Environment

**Why:** Keeps project dependencies isolated

=== "Windows"
    
    ```cmd
    python -m venv venv
    venv\Scripts\activate
    ```
    
    You should see `(venv)` before your prompt.

=== "Mac/Linux"
    
    ```bash
    python3 -m venv venv
    source venv/bin/activate
    ```
    
    You should see `(venv)` before your prompt.

### Install Packages

```bash
pip install --upgrade pip

# Data manipulation
pip install pandas numpy

# Database connections
pip install psycopg2-binary sqlalchemy

# Data visualisation
pip install matplotlib seaborn plotly

# Machine learning
pip install scikit-learn

# Jupyter notebooks
pip install jupyter notebook

# Airflow (we'll do this properly later, but let's check it works)
pip install apache-airflow==2.7.3

# API development
pip install flask requests

# Data quality
pip install great-expectations
```

This might take 5-10 minutes.

### Test Installation

```bash
python -c "import pandas; import numpy; import sklearn; print('All packages imported successfully!')"
```

---

## Step 8: Clone the Course Repository

Get the sample data and code:

```bash
# Make sure you're in your data-roles-practice directory
git clone https://github.com/glsdown/data-roles-guide.git
cd data-roles-guide
```

---

## Step 9: Test Everything

Let's make sure everything works:

### Test 1: Python

Create a test file:

```bash
echo 'print("Hello from Python!")' > test.py
python test.py
```

Should print: `Hello from Python!`

### Test 2: Jupyter

```bash
jupyter notebook
```

Should open in your browser. Create a new notebook and run:

```python
import pandas as pd
df = pd.DataFrame({'A': [1, 2, 3]})
print(df)
```

### Test 3: PostgreSQL Connection

Create `test_db.py`:

```python
import psycopg2

try:
    conn = psycopg2.connect(
        host="localhost",
        database="postgres",
        user="postgres",
        password="your_password_here"  # Update this!
    )
    print("✓ PostgreSQL connection successful!")
    conn.close()
except Exception as e:
    print(f"✗ Connection failed: {e}")
```

Run it:

```bash
python test_db.py
```

### Test 4: Docker

```bash
docker run --rm hello-world
```

Should show Docker's hello message.

---

## Troubleshooting

### Python Not Found

**Issue:** `python: command not found`

**Fix:**

- On Mac/Linux, try `python3` instead of `python`
- On Windows, reinstall Python and check "Add to PATH"

### Permission Denied (Mac/Linux)

**Issue:** `Permission denied` when running commands

**Fix:**

Use `sudo` before the command:

```bash
sudo apt install package-name
```

### Port Already in Use

**Issue:** PostgreSQL or Docker port conflicts

**Fix:**

Check what's using the port:

```bash
# Mac/Linux
lsof -i :5432

# Windows
netstat -ano | findstr :5432
```

Kill the process or change the port.

### Docker Won't Start

**Issue:** Docker Desktop fails to start

**Fix:**

- Windows: Enable WSL 2 and Hyper-V in Windows Features
- Mac: Grant permissions in System Preferences > Privacy
- Linux: Add user to docker group: `sudo usermod -aG docker $USER`

### Can't Install Packages

**Issue:** `pip install` fails

**Fix:**

```bash
# Upgrade pip
python -m pip install --upgrade pip

# Use --user flag
pip install --user package-name

# Check internet connection
```

---

## Setup Checklist

Before moving on, verify you have:

- [x] Python 3.10+ installed and working
- [x] pip package manager working
- [x] VS Code installed with extensions
- [x] Git installed and configured
- [x] PostgreSQL installed and running
- [x] Docker Desktop installed and working
- [x] GitHub account created
- [x] Snowflake account created (free trial)
- [x] dbt Cloud account created (free tier)
- [x] Virtual environment created and activated
- [x] Key Python packages installed
- [x] All tests passing

---

## What's Next?

Congratulations! Your environment is ready. Now let's learn the fundamentals:

[Start with Fundamentals →](../fundamentals/index.md){ .md-button .md-button--primary }

Or if you're eager to start building:

[Jump to Hands-On Projects →](../hands-on/project-overview.md){ .md-button }

---

## Need Help?

Setup issues are common. Don't get discouraged!

- 💬 [Ask in GitHub Discussions](https://github.com/glsdown/data-roles-guide/discussions)
- 🐛 [Report Setup Issues](https://github.com/glsdown/data-roles-guide/issues)
- 📧 [Email for Support](mailto:your.email@example.com)

Include details about:

- Your operating system
- The exact error message
- What you were trying to do
- What you've already tried

We'll help you get unstuck! 🚀