#!/bin/bash

# Author: Sumanth M
# Description: The AuditAnalyzer project is designed to provide comprehensive system auditing and monitoring capabilities for administrators and users. By aggregating essential system information, user activity logs, network statistics, and performance metrics, it empowers users to maintain a secure and efficient operating environment.

# Date: 11-10-2024

# Function to check if a command exists
command_exists() {
  command -v "$1" &> /dev/null
}

# Function to log the system details to a report
generate_report() {
  echo "Audit Report - $(date)" > "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to append system information
system_info() {
  echo "System Hostname: $(hostname)" >> "$REPORT_FILE"
  echo "------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Current User: $(whoami)" >> "$REPORT_FILE"
  echo "------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Current Directory: $(pwd)" >> "$REPORT_FILE"
  echo "------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "System Uptime: $(uptime -p)" >> "$REPORT_FILE"
  echo "------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "System Load Average: $(uptime | awk -F'load average: ' '{ print $2 }')" >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log active users and system activity
user_activity() {
  echo "Currently logged in users:" >> "$REPORT_FILE"
  who >> "$REPORT_FILE"
  echo "-----------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Last logged in users (last 10):" >> "$REPORT_FILE"
  last -n 10 >> "$REPORT_FILE"
  echo "-----------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Last commands executed (last 15):" >> "$REPORT_FILE"
  tail -n 15 ~/.bash_history >> "$REPORT_FILE"
  echo "-----------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Recent Activity (top 10 users by activity):" >> "$REPORT_FILE"
  w -h | head -n 10 >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log system resource usage
system_resources() {
  echo "Disk Space Usage:" >> "$REPORT_FILE"
  df >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Memory Usage:" >> "$REPORT_FILE"
  free -h >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Top 10 Processes by CPU usage:" >> "$REPORT_FILE"
  ps -eo pid,comm,%cpu --sort=-%cpu | head -n 11 >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Top 10 Processes by Memory usage:" >> "$REPORT_FILE"
  ps -eo pid,comm,%mem --sort=-%mem | head -n 11 >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log network info
network_info() {
  echo "Network Interfaces and Addresses:" >> "$REPORT_FILE"
  ip addr >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "MAC Addresses:" >> "$REPORT_FILE"
  ip link | awk '/ether/ {print $2}' >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "IP Address and loopback address: " >> "$REPORT_FILE"
  ip addr | grep inet >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log OS information
os_info() {
  echo "Operating System Information:" >> "$REPORT_FILE"
  cat /etc/os-release >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log network traffic info
network_traffic() {
  echo "Network Traffic Report" >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Active Connections (netstat):" >> "$REPORT_FILE"
  netstat -tuln >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"

  echo "Socket Statistics (ss):" >> "$REPORT_FILE"
  ss -tuln >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log system services
system_services() {
  echo "Active and Failed Services (systemd):" >> "$REPORT_FILE"
  systemctl --type=service --state=failed >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log sudoers info
sudoers_info() {
  echo "Sudoers File (Users with Sudo Access):" >> "$REPORT_FILE"
  grep -Po '^sudo.+:\K.*' /etc/group >> "$REPORT_FILE"
  echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
}

# Function to log the top command output if user requests
include_top_command() {
  read -p "Include top command output? (yes/no): " INCLUDE_TOP
  if [[ "$INCLUDE_TOP" == "yes" ]]; then
    echo "Top Processes (top -b -n 1):" >> "$REPORT_FILE"
    top -b -n 1 >> "$REPORT_FILE"
    echo "-------------------------------------------------------------------------------" >> "$REPORT_FILE"
  fi
}

# Function to generate PDF from the text report
generate_pdf() {
  if command_exists a2ps && command_exists ps2pdf; then
    a2ps "$REPORT_FILE" -o "${REPORT_FILE%.txt}.ps"
    ps2pdf "${REPORT_FILE%.txt}.ps" "$PDF_FILE"
    rm "${REPORT_FILE%.txt}.ps"
    echo "PDF report generated: $PDF_FILE"
  else
    echo "Error: Required tools 'a2ps' or 'ps2pdf' not found. PDF generation skipped."
  fi
}

# Function to ask for PDF file name from user input
get_pdf_filename() {
  read -p "Enter the desired name for the PDF report (without extension): " PDF_FILENAME
  PDF_FILE="${PDF_FILENAME}.pdf"
}

# Main Execution

# Generate a timestamped filename for the text report
REPORT_FILE="Auditing_Report_$(date +'%Y-%m-%d_%H-%M-%S')"

# Ask the user for the PDF filename
get_pdf_filename

# Start creating the audit report
generate_report
system_info
user_activity
system_resources
network_info
os_info
network_traffic
system_services
sudoers_info

# Ask if the user wants to include the `top` command output
include_top_command

# Generate the PDF with the provided filename
generate_pdf

# Clean up the temporary files
rm "$REPORT_FILE"

echo "Audit report process completed."
