#!/bin/bash

[ "bceb480fa994ddbe7690e8f53912d678" = "$(curl -Ss https://get.netdata.cloud/kickstart.sh | md5sum | cut -d ' ' -f 1)" ] && \
	 echo "Netdata installed successfully" || \
	 echo "FAILED to install Netdata"

netdata -D