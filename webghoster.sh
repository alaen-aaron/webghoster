#!/bin/bash

LOG_FILE="webghoster.log"
DEFAULT_WORDLIST="wordlist/common.txt"  # Default wordlist location

# 🎨 Stylish Banner
echo -e "\e[1;35m"
echo "============================================"
echo "         🔥 WELCOME TO WEBGHOSTER 🔥       "
echo "        Ultimate Web Enumeration Tool       "
echo "============================================"
echo -e "\e[1;33m                BY ALAEN JOSHVA            \e[0m"
echo "============================================"
echo -e "\e[0m"

# 🛠 Check if Gobuster is installed
if ! command -v gobuster &> /dev/null; then
    echo -e "\e[1;31m❌ Gobuster is not installed!\e[0m"
    echo -e "\e[1;34mRun: \e[1;33m./setup.sh\e[0m"
    exit 1
fi

# Ensure we have write permission to the log file
touch "$LOG_FILE" 2>/dev/null || { echo "❌ Error: Cannot write to $LOG_FILE! Check permissions."; exit 1; }

# Logging function
log() {
    echo -e "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

# 🏹 Select Scan Mode
echo -e "\e[1;34mChoose the scan type (Press Enter for default: dir):\e[0m"
echo "1️⃣  Directory Brute Force (dir)"
echo "2️⃣  DNS Subdomain Brute Force (dns)"
echo "3️⃣  Virtual Host Brute Force (vhost)"
echo "4️⃣  Fuzzing (fuzz)"
echo "5️⃣  Amazon S3 Bucket Enumeration (s3)"
echo "6️⃣  Exit"
read -t 10 -p "Enter your choice (1-6): " choice

case $choice in
    1) mode="dir" ;;
    2) mode="dns" ;;
    3) mode="vhost" ;;
    4) mode="fuzz" ;;
    5) mode="s3" ;;
    6) echo "Exiting WebGhoster..."; exit 0 ;;
    "") mode="dir"; echo "👉 No mode selected, using default: dir" ;;
    *) echo "Invalid choice! Exiting..."; exit 1 ;;
esac

# 🌐 Enter the target
read -t 15 -p "Enter the target URL or domain: " target
if [[ -z "$target" || ! "$target" =~ ^(https?:\/\/)?[a-zA-Z0-9.-]+$ ]]; then
    echo "❌ Error: Invalid target! Example: example.com or https://example.com"
    exit 1
fi

# 📂 Enter the wordlist
read -t 10 -p "Enter the path to the wordlist (Press Enter for default: $DEFAULT_WORDLIST): " wordlist
wordlist="${wordlist:-$DEFAULT_WORDLIST}"

# Ensure the wordlist file exists
if [[ ! -f "$wordlist" ]]; then
    echo "❌ Error: Wordlist file not found at $wordlist!"
    exit 1
fi

# ⚡ Additional options
read -t 10 -p "Enter extra Gobuster options (or press Enter to skip): " extra_options

# 🏃 Run WebGhoster (Gobuster)
log "Starting WebGhoster in $mode mode against $target"
cmd="gobuster $mode -u $target -w $wordlist $extra_options"
echo -e "\e[1;32mExecuting: $cmd\e[0m"

# Run Gobuster and handle errors
eval "$cmd" | tee -a "$LOG_FILE" || { echo "❌ Gobuster encountered an error! Check the logs."; exit 1; }

log "WebGhoster scan completed!"
echo -e "\e[1;33mResults saved in $LOG_FILE\e[0m"
