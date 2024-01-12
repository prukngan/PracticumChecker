#!/bin/bash

RED='\e[0;31m'
GREEN='\e[0;32m'
NC='\e[0m'

echo '-----------------------------'
echo "| Hostname  : $(hostname) |"
echo "| IP        : $(hostname -I)  |"
echo '-----------------------------'

echo -n "Static IP : "
if ip r | grep -q 'proto static' 2>/dev/null; then
        echo "${GREEN}Passed${NC}"
else
        echo "${RED}Failed${NC}"
fi

echo -n "PermitRootLogin deny : "
if sudo service ssh restart | grep -q "PermitRootLogin no" /etc/ssh/sshd_config 2>/dev/null; then
        echo "${GREEN}Passed${NC}"
else
        echo "${RED}Failed${NC}"
fi

echo -n "Trusted 158.108.32.60 : "
if grep -q "158.108.32.60" /etc/bind/named.conf.options 2>/dev/null; then
        echo "${GREEN}Passed${NC}"
else
        echo "${RED}Failed${NC}"
fi

echo -n "Check http : "
if lynx -source http://testssl.cpe36.net >/dev/null 2>&1 ; then
        echo "${GREEN}Passed${NC}"
else
        echo "${RED}Failed${NC}"
fi

echo -n "Check https : "
if lynx -source https://testssl.cpe36.net >/dev/null 2>&1 ; then
        echo "${GREEN}Passed${NC}"
else
        echo "${RED}Failed${NC}"
fi