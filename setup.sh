#!/bin/bash

# 🎨 Stylish Header
echo -e "\e[1;35m"
echo "============================================"
echo "         🔥 WEBGHOSTER SETUP 🔥            "
echo "============================================"
echo -e "\e[0m"

# Function to check if Gobuster is installed
check_gobuster() {
    if command -v gobuster &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# If Gobuster is already installed, exit setup
if check_gobuster; then
    echo -e "\e[1;32mSetup is successful! ✅\e[0m"
    echo -e "\e[1;34mNow, run: \e[1;33m./webghoster.sh\e[0m"
    exit 0
fi

# Detect Linux distribution
OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')

echo "🔍 Detecting Linux distribution..."
sleep 1

# Try different installation methods
inst…
[4:44 pm, 10/03/2025] Karuppu: #!/bin/bash

# 🎨 Stylish Header
echo -e "\e[1;35m"
echo "============================================"
echo "         🔥 WEBGHOSTER SETUP 🔥            "
echo "============================================"
echo -e "\e[0m"

# Function to check if Gobuster is installed
check_gobuster() {
    if command -v gobuster &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# If Gobuster is already installed, exit setup
if check_gobuster; then
    echo -e "\e[1;32mSetup is successful! ✅\e[0m"
    echo -e "\e[1;34mNow, run: \e[1;33m./webghoster.sh\e[0m"
    exit 0
fi

# Detect Linux distribution
OS=$(grep '^ID=' /etc/os-release | cut -d '=' -f2 | tr -d '"')

echo "🔍 Detecting Linux distribution..."
sleep 1

# Try different installation methods
install_gobuster() {
    case "$OS" in
        ubuntu|debian|kali|pop)
            sudo apt update &> /dev/null && sudo apt install gobuster -y &> /dev/null
            ;;
        arch|manjaro)
            sudo pacman -Sy gobuster --noconfirm &> /dev/null
            ;;
        fedora)
            sudo dnf install gobuster -y &> /dev/null
            ;;
        *)
            echo "⚠️ Unknown Linux distribution: Trying Go installation..."
            go install github.com/OJ/gobuster/v3@latest &> /dev/null
            ;;
    esac
}

# Attempt to install Gobuster
install_gobuster

# Check if installation was successful
if check_gobuster; then
    echo -e "\e[1;32mSetup is successful! ✅\e[0m"
    echo -e "\e[1;34mNow, run: \e[1;33m./webghoster.sh\e[0m"
else
    echo -e "\e[1;31mSetup failed! ❌ Please install Gobuster manually.\e[0m"
fi