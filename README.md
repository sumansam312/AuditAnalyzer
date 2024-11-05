# AuditAnalyzer

**Author:** Sumanth M  
**Date:** 11-10-2024  
**Description:**  
The AuditAnalyzer project provides comprehensive system auditing and monitoring capabilities for administrators and users. It aggregates essential system information, user activity logs, network statistics, and performance metrics to help users maintain a secure and efficient operating environment.

---

## Features

- **System Information**: Hostname, current user, uptime, system load average, etc.
- **User Activity Logs**: Current logged-in users, last login records, recently executed commands, etc.
- **System Resource Usage**: Disk space usage, memory usage, CPU and memory-intensive processes.
- **Network Information**: Network interfaces, IP addresses, MAC addresses, etc.
- **Operating System Information**: Details from `/etc/os-release`.
- **Network Traffic Information**: Active network connections and socket statistics.
- **System Services**: List of active and failed system services.
- **Sudoers Information**: List of users with sudo access.

---

## How to Use

### Prerequisites

Before running the script, ensure the following tools are installed on your system:

- `bash` (For running the shell script)
- `a2ps` (For converting text to PostScript)
- `ps2pdf` (For converting PostScript to PDF)
  
#### On Debian-based Systems (e.g., Ubuntu, Linux Mint):
Run the following command to install both `a2ps` and `ps2pdf`:

```bash
sudo apt-get install a2ps ps2pdf
```

#### On Red Hat-based Systems (e.g., CentOS, Fedora, RHEL):
Use `dnf` or `yum` to install the required tools:

```bash
sudo dnf install a2ps ghostscript
```
or

```bash
sudo dnf install a2ps ghostscript
```
---

### Running the Script
1. **Clone the Repository**

  If you're using Git, clone the repository to your local machine:

```bash
git clone https://github.com/yourusername/AuditAnalyzer.git 
cd AuditAnalyzer
```

2. **Make the Script Executable**

Ensure the script is executable. You can do this with the following command:

```bash
   chmod +x AuditAnalyzer.sh
  ```

3. **Run the Script**
    To run the script, execute it with:
```bash
./AuditAnalyzer.sh

```
* The script will generate a detailed audit report and store it in a text file.
* You will be prompted to provide a filename for the PDF report.
* The script will convert the text report into a PDF file using `a2ps` and `ps2pdf`.

**Example output prompt:**

```bash
Enter the desired name for the PDF report (without extension): MyAuditReport
```

4. **Report Files**

* The generated audit report will be saved as a text file with a timestamp.
* If you choose to generate a PDF report, the script will save it with the filename you provided (e.g., `MyAuditReport.pdf`).
* Both the text and PDF reports will contain detailed information about the system's performance, network statistics, user activity, and more.
---

## Example of Output (Text)
The audit report includes the following sections:

**1. System Information**

```bash
System Hostname: example-hostname
------------------------------------------------------------------------------
Current User: root
------------------------------------------------------------------------------
Current Directory: /home/user
------------------------------------------------------------------------------
System Uptime: up 1 day, 3 hours, 45 minutes
------------------------------------------------------------------------------
System Load Average: 0.12, 0.07, 0.05
------------------------------------------------------------------------------
```
**2. User Activity**

```bash
Currently logged in users:
user1   pts/0        192.168.1.5    2024-11-05 10:30
root    pts/1        192.168.1.5    2024-11-05 10:32
------------------------------------------------------------------------------
Last logged in users (last 10):
user1   tty1         2024-11-04 09:00
root    tty1         2024-11-04 09:05
------------------------------------------------------------------------------
```

**3. System Resource Usage**
```bash
Disk Space Usage:
Filesystem     1K-blocks    Used Available Use% Mounted on
/dev/sda1       10240000  5120

000  5120000  50% /

Memory Usage:
total        used        free      shared  buff/cache   available
Mem:          16GB        8GB        4GB        1GB         4GB
------------------------------------------------------------------------------
```
---

## PDF Download Advantage
After generating the report using the script, you have the option to download a PDF version of the audit report. This PDF can be shared with other administrators or team members for documentation purposes. It’s helpful for generating formal audit records that can be stored or presented as part of system administration reviews.

**Advantages of the PDF:**

* **Professional Format:** The PDF provides a clean and formatted report for documentation.
* **Portability:** A PDF is a universally accepted format that can be opened on almost any device. 
* **Archiving:** PDFs are ideal for archiving as they preserve the layout and integrity of the report.
---

## Troubleshooting
If you encounter any issues, here are some common solutions:

1. **Missing Dependencies:** Ensure `a2ps` and `ps2pdf` are installed on your system. If the script fails to generate the PDF, verify that these tools are available in your   `$PATH`

2. **Permission Issues:** Ensure that you have the necessary permissions to execute the script and access the required system files.

3. **Invalid Command:** If a command used in the script is unavailable (e.g., netstat, ss, uptime), you may need to install additional utilities specific to your system.

---

## License
This project is licensed under the MIT License. See the LICENSE file for more details.
