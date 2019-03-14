#!/usr/bin/env bash

set -e

# specify the path for nginx (primary) configuation file 
path="/etc/nginx/nginx.conf"

#exit 1: general error, exit 0: success
#checking : no parameter (IP address) is given
if [$1 = ]; then
	echo "failure:no IP address is given"
	exit 1
else
	ip=$1
fi



# IP = $1,declare -r -x???
# update the testing url, use sed to edit the filename, s#pattern#replacement#p,match pattern and print replacement only,  update the filename in the config file 
#/ to separate filename path, * to match every file within the path
current=$(sed /i 's/server\s(.+?):6379/'ip' ' $path)



# ec
if [[ "$current" != "ip" ]]; then
    sed -i'' -E "s/server\s(.+?):6379/server $ip:6379/" $path 
#reload the configuration to redirect nginx
    /usr/sbin/nginx -s reload
    echo "hot-swap to the updating new ip address""
else
    # print warning message
    echo "'ip' already been allocated, hotswap failed""
    exit 1
fi





