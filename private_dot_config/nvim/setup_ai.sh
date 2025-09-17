#!/bin/bash

# AI Provider Setup Script for Neovim CodeCompanion
# This script helps set up API keys using the central key management system

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Setting up AI providers for Neovim CodeCompanion${NC}"
echo "=================================================="

echo -e "${YELLOW}Note: This script now uses the central API key management system${NC}"
echo "API keys are stored in ~/.config/api-keys/keys.env.gpg and loaded automatically"
echo ""

# Function to setup API key using central system
setup_api_key() {
    local provider="$1"
    local env_var_name="$2"
    
    echo -e "\n${YELLOW}Setting up $provider API key${NC}"
    echo "Enter your $provider API key:"
    read -s -r api_key
    
    if [ -z "$api_key" ]; then
        echo -e "${RED}Error: API key cannot be empty${NC}"
        return 1
    fi
    
    # Use the central API key management system
    if command -v "$HOME/.local/bin/load-api-keys" >/dev/null 2>&1; then
        "$HOME/.local/bin/load-api-keys" set "$env_var_name" "$api_key"
        if [ $? -eq 0 ]; then
            echo -e "${GREEN}✓ $provider API key stored successfully${NC}"
        else
            echo -e "${RED}✗ Failed to store $provider API key${NC}"
            return 1
        fi
    else
        echo -e "${RED}Error: Central API key management system not found${NC}"
        echo "Please install setup-api-keys and load-api-keys scripts"
        return 1
    fi
}

# Setup Zhipu AI (Primary)
setup_zhipu() {
    echo -e "\n${BLUE}Setting up Zhipu AI (Primary Provider)${NC}"
    echo "Get your API key from: https://open.bigmodel.cn/"
    setup_api_key "Zhipu AI" "ZHIPU_API_KEY"
}

# Setup Bailian AI (Backup)
setup_bailian() {
    echo -e "\n${BLUE}Setting up Bailian AI (Backup Provider)${NC}"
    echo "Get your API key from: https://help.aliyun.com/zh/model-studio/call-application-through-api"
    setup_api_key "Bailian AI" "DASHSCOPE_API_KEY"
    
    # Bailian also needs app_id
    echo -e "\n${YELLOW}Bailian requires an App ID${NC}"
    echo "Enter your Bailian App ID:"
    read -s -r app_id
    
    if [ -n "$app_id" ]; then
        "$HOME/.local/bin/load-api-keys" set "BAILIAN_APP_ID" "$app_id"
        echo -e "${GREEN}✓ Bailian App ID stored successfully${NC}"
    fi
}

# Test API key setup
test_api_keys() {
    echo -e "\n${YELLOW}Testing API key setup...${NC}"
    
    if ! command -v "$HOME/.local/bin/load-api-keys" >/dev/null 2>&1; then
        echo -e "${RED}Error: API key management system not found${NC}"
        echo "Please install setup-api-keys and load-api-keys scripts first"
        return 1
    fi
    
    echo -e "${GREEN}✓ API key management system available${NC}"
    
    # Show currently configured keys
    echo -e "\n${YELLOW}Currently configured API keys:${NC}"
    "$HOME/.local/bin/load-api-keys" list | head -10
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
                echo -e "\n${YELLOW}Testing API keys...${NC}"
                test_api_keys
                echo -e "\n${YELLOW}Current environment API keys:${NC}"
                env | grep "_API_KEY=" | head -10
                ;;
            5) 
                echo -e "${GREEN}Setup complete!${NC}"
                echo "Your API keys are stored in the central encrypted system"
                echo "Restart your shell or run: source ~/.bashrc (or ~/.zshrc)"
                echo "Then restart Neovim to use the AI features."
                exit 0
                ;;
            *) echo -e "${RED}Invalid choice. Please try again.${NC}" ;;
        esac
    done
}

main "$@"