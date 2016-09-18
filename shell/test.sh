#!/usr/bin/env bash
set -ex

CURL_VERSION="7.50.3"
PHP_VERSION="7.0.11"
CURRDIR=$( dirname "$0" )

CURL_MIRROR="http://dl.uxnr.de/mirror/curl" # https://curl.haxx.se/download
PHP_MIRRROR="http://de1.php.net/get"
PHP_MIRRROR_APPEND="/from/this/mirror"

# Import & trust key
gpg --import "$CURRDIR/danielcurlkey.asc"
echo "27EDEAF22F3ABCEB50DB9A125CC908FDB71E12C2:6:"|gpg --import-ownertrust

# Download recent curl version
# wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2
wget $CURL_MIRROR/curl-$CURL_VERSION.tar.bz2
wget $CURL_MIRROR/curl-$CURL_VERSION.tar.bz2.asc

gpg --verify curl-$CURL_VERSION.tar.bz2.asc

bzip2 -d curl-$CURL_VERSION.tar.bz2
tar -xf curl-$CURL_VERSION.tar

# build curl version
cd curl-$CURL_VERSION
./buildconf
./configure
make
sudo make install

# show curl version
curl --version
