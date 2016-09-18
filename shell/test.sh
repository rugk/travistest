#!/usr/bin/env bash
set -ex

CURL_VERSION="7.50.3"
CURRDIR=$( dirname "$0" )

# Import & trust key
gpg --import "$CURRDIR/danielcurlkey.asc"
echo "27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2:6:"|gpg --import-ownertrust

# Download recent curl version
# wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2
wget http://dl.uxnr.de/mirror/curl/curl-$CURL_VERSION.tar.bz2
wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2.asc

gpg --verify curl-$CURL_VERSION.tar.bz2.asc

bzip2 -d curl-$CURL_VERSION.tar.bz2
tar -xf curl-$CURL_VERSION.tar

# build curl version
cd curl-$CURL_VERSION
./buildconf
./configure
make
sudo make install

# sudo ln -s /usr/local/bin/curl /usr/bin/curl

# show curl version
curl --version
php -r 'var_dump(curl_version());'

echo "Show me value: $( php -r 'echo CURLOPT_PINNEDPUBLICKEY;' )"
