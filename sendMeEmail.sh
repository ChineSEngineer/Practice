#/usr/bin/env bash
my_email_address=$1
domain_address=$(echo $my_email_address | cut -d "@" -f2)
echo $domain_address
canonical_address=$(nslookup -q=mx $domain_address | grep $domain_address | head -n 1 |awk '{print $NF}')
echo $canonical_address

if [[ $? == 0 ]];then
    cp send.txt send_temperory.txt
    sed -i "s/targetEmail/$my_email_address/" send_temperory.txt
    telnet mxa-00256a01.gslb.pphosted.com 25 < send_temperory.txt
    #telnet $canonical_address 25 < send_temperory.txt
    rm send_temperory.txt
fi
