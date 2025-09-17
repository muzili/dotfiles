#!/bin/bash

# AI Provider Setup Script for Neovim CodeCompanion
# This script helps set up GPG-encrypted API keys

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SECRETS_DIR="$SCRIPT_DIR/secrets"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up AI providers for Neovim CodeCompanion${NC}"
echo "=================================================="

# Create secrets directory if it doesn't exist
mkdir -p "$SECRETS_DIR"

# Function to setup GPG encrypted key
setup_gpg_key() {
    local provider="$1"
    local key_name="$2"
    
    echo -e "\n${YELLOW}Setting up $provider API key${NC}"
    echo "Enter your $provider API key (will be encrypted with GPG):"
    read -s -r api_key
    
    if [ -z "$api_key" ]; then
        echo -e "${RED}Error: API key cannot be empty${NC}"
        return 1
    fi
    
    # Get GPG recipient
    echo "Enter your GPG key ID (or press Enter to use default):"
    read -r gpg_recipient
    
    if [ -z "$gpg_recipient" ]; then
        gpg_recipient="default"
    fi
    
    # Encrypt the API key
    echo "$api_key" | gpg --armor --encrypt --recipient "$gpg_recipient" --output "$SECRETS_DIR/${key_name}.gpg"
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ $provider API key encrypted successfully${NC}"
    else
        echo -e "${RED}✗ Failed to encrypt $provider API key${NC}"
        return 1
    fi
}

# Setup Zhipu AI (Primary)
setup_zhipu() {
    echo -e "\n${BLUE}Setting up Zhipu AI (Primary Provider)${NC}"
    echo "Get your API key from: https://open.bigmodel.cn/"
    setup_gpg_key "Zhipu AI" "zhipu"
}

# Setup Bailian AI (Backup)
setup_bailian() {
    echo -e "\n${BLUE}Setting up Bailian AI (Backup Provider)${NC}"
    echo "Get your API key from: https://help.aliyun.com/zh/model-studio/call-application-through-api"
    setup_gpg_key "Bailian AI" "bailian"
    
    # Bailian also needs app_id
    echo -e "\n${YELLOW}Bailian requires an App ID${NC}"
    echo "Enter your Bailian App ID:"
    read -s -r app_id
    
    if [ -n "$app_id" ]; then
        echo "$app_id" | gpg --armor --encrypt --recipient "$gpg_recipient" --output "$SECRETS_DIR/bailian_app_id.gpg"
        echo -e "${GREEN}✓ Bailian App ID encrypted successfully${NC}"
    fi
}

# Test GPG setup
test_gpg() {
    echo -e "\n${YELLOW}Testing GPG setup...${NC}"
    
    if ! command -v gpg &> /dev/null; then
        echo -e "${RED}Error: GPG is not installed${NC}"
        echo "Please install GPG first:"
        echo "  Ubuntu/Debian: sudo apt-get install gnupg"
        echo "  macOS: brew install gnupg"
        return 1
    fi
    
    # Test if there are any GPG keys
    if ! gpg --list-keys &> /dev/null; then
        echo -e "${RED}Error: No GPG keys found${NC}"
        echo "Please generate a GPG key first:"
        echo "  gpg --full-generate-key"
        return 1
    fi
    
    echo -e "${GREEN}✓ GPG setup looks good${NC}"
}

# Main menu
main() {
    test_gpg
    
    while true; do
        echo -e "\n${BLUE}Choose an option:${NC}"
        echo "1) Setup Zhipu AI (Primary)"
        echo "2) Setup Bailian AI (Backup)"
        echo "3) Setup both providers"
        echo "4) Test decryption"
        echo "5) Exit"
        
        read -p "Enter your choice (1-5): " choice
        
        case $choice in
            1) setup_zhipu ;;
            2) setup_bailian ;;
            3) 
                setup_zhipu
                setup_bailian
                ;;
            4)
                echo -e "\n${YELLOW}Testing decryption...${NC}"
                for key_file in "$SECRETS_DIR"/*.gpg; do
                    if [ -f "$key_file" ]; then
                        key_name=$(basename "$key_file" .gpg)
                        echo "Testing $key_name..."
                        if gpg --quiet --decrypt "$key_file" > /dev/null 2>&1; then
                            echo -e "${GREEN}✓ $key_name decryption successful${NC}"
                        else
                            echo -e "${RED}✗ $key_name decryption failed${NC}"
                        fi
                    fi
                done
                ;;
            5) 
                echo -e "${GREEN}Setup complete!${NC}"
                echo "Your API keys are encrypted and stored in $SECRETS_DIR/"
                echo "Restart Neovim to use the AI features."
                exit 0
                ;;
            *) echo -e "${RED}Invalid choice. Please try again.${NC}" ;;
        esac
    done
}

main "$@"