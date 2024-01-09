#!/bin/bash

RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m'

echo "Hostname  : $(hostname)"
echo "IP                : $(hostname -I)"

echo -n "Static IP : "
if ip r | grep -q 'proto static'; then
        echo -e "${GREEN}Passed${NC}"
else
        echo -e "${RED}Failed${NC}"
fi

echo -n "PermitRootLogin : "
if grep -q "PermitRootLogin yes" /etc/ssh/sshd_config 2>/dev/null; then
        echo -e "${GREEN}Yes${NC}"
else
        echo -e "${RED}No${NC}"
fi

echo -n "Trusted 158.108.32.60 : "
if head -q "158.108.32.60" /etc/bind/named.conf.options 2>/dev/null; then
        echo -e "${GREEN}Passed${NC}"
else
        echo -e "${RED}Failed${NC}"
fi

echo -n "Check http : "
if lynx http://testssl.cpe36.net 2>/dev/null ; then
        echo -e "${GREEN}Passed${NC}"
else
        echo -e "${RED}Failed${NC}"
fi

echo -n "Check https : "
if lynx https://testssl.cpe36.net 2>/dev/null ; then
        echo -e "${GREEN}Passed${NC}"
else
        echo -e "${RED}Failed${NC}"
fi