#!/usr/bin/env bash
set -ex

# Install recent curl version
# TODO

# show curl version
curl --version

echo "Show me value: $( php -r 'echo CURLOPT_PINNEDPUBLICKEY;' )"
