# Directory Monitor & Antivirus System

A simple Bash tool system to automatically watch a folder for malicious files, quarantine them, and let you review or restore them later.

## 1. Code Overview & Hierarchy

*   **antivirusd.sh**: The background script that monitors the target folder.
*   **restore.sh**: The interactive tool used to recover or delete quarantined files.
*   **Makefile**: Used to run both scripts easily.

```text
.
├── Makefile
├── README.md
├── antivirusd.sh
└── restore.sh
```

---

## 2. Prerequisites & Installation (Ubuntu)

This system only uses standard Linux tools. To ensure you have `make` installed, follow these steps:

1. Update your packages:
   ```bash
   sudo apt update
   ```
2. Install the `make` utility:
   ```bash
   sudo apt install -y build-essential
   ```
3. Make both scripts executable:
   ```bash
   chmod +x antivirusd.sh restore.sh
   ```

---

## 3. How to Run the Tools

**Note:** Do not run both tools at the same time.

### Step 1: Run the Antivirus Monitor
To start watching your directory (defaults to checking `OS_LAB2_TEST` every 10 seconds):
```bash
make run-av
```
*To stop the monitor at any time, press **Ctrl + C**.*

### Step 2: Run the Restore Tool
Once the monitor is stopped, launch the recovery wizard to review quarantined files:
```bash
make run-restore
```
You will type the number of the file you want to manage, then choose an option:
*   **1**: Restore the file back to its original folder.
*   **2**: Permanently delete the file.
*   **3**: Leave it as-is and go back.

---
