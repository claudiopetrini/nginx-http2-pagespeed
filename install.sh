#bin/bash

#install dependencies
sudo apt-get install unzip zlibc zlib1g build-essential zlib1g-dev libpcre3 libpcre3-dev libssl-dev libxslt1-dev libxml2-dev libgd2-xpm-dev libgeoip-dev libgoogle-perftools-dev libperl-dev

#nginx version
NGINX_VERSION=1.7.9

#openssl version
OPENSSL_VERSION=1.0.1l

#ngx_pagespeed version
NPS_VERSION=1.9.32.3

#Directories
CURRENT_DIR=$(pwd)
OPENSSL_DIR=$(pwd)/openssl-${OPENSSL_VERSION}

#Save the nginx version
curl -O http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
#Extracting nginx 
tar -xvf nginx-${NGINX_VERSION}.tar.gz
#Save the openssl version
curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
#Extracting openssl
tar -xvf openssl-${OPENSSL_VERSION}.tar.gz
#Save ngx_pagespeed module
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${NPS_VERSION}-beta.zip
#Extracting ngx_pagespeed module
unzip release-${NPS_VERSION}-beta.zip
#Entering in ngx_pagespeed
cd ngx_pagespeed-release-${NPS_VERSION}-beta/
#Downloading psol
wget https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz
#Extracting psol
tar -xzvf ${NPS_VERSION}.tar.gz 
# Exiting from ngx_pagespeed
cd ..

#Entering inside the nginx folder
cd nginx-${NGINX_VERSION}
#Configuring 
./configure  \
--prefix=/etc/nginx \
--with-http_ssl_module \
--with-http_spdy_module \
--with-openssl=${OPENSSL_DIR} \
--with-cc-opt="-Wno-deprecated-declarations" \
--add-module=${CURRENT_DIR}/ngx_pagespeed-release-${NPS_VERSION}-beta

# Compiling everything on 64 bits systems
KERNEL_BITS=64 make install

#Cleaning sources
cd ${CURRENT_DIR}
rm *.tar.gz
rm -rf nginx-${NGINX_VERSION} ${OPENSSL_DIR}

