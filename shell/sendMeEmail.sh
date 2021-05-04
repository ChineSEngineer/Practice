#/usr/bin/env bash
my_email_address=$1
domain_address=$(echo $my_email_address | cut -d "@" -f2)
echo "Parse the domain address: $domain_address"
canonical_address=$(nslookup -q=mx $domain_address | grep $domain_address | head -n 1 |awk '{print $NF}')
echo "Lookup the canonical address of the domain:" $canonical_address

if [[ $? == 0 ]];then
    cp send.txt send_temperory.txt
    sed -i "s/targetEmail/$my_email_address/" send_temperory.txt
    sleep 1 | telnet $canonical_address 25 < send_temperory.txt
    rm send_temperory.txt
fi
