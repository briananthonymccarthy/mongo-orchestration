#!/bin/bash
MONGO_VERSION=${MONGO_VERSION}
PLATFORM=${PLATFORM}
DOWNLOAD_URL=${DOWNLOAD_URL}
ENTERPRISE_LABEL=${ENTERPRISE_LABEL}
FILE_EXT=${FILE_EXT}
PLATFORM_DECOMPRESS=${PLATFORM_DECOMPRESS}

set -o errexit
set -o verbose

# Mongo 2.4 on RHEL has a different download URL from everything else
if [[ ${MONGO_VERSION} = "2.4.14" && ${PLATFORM} = "linux" ]]; then
  export MONGO_DOWNLOAD_URL="http://${DOWNLOAD_URL}/${PLATFORM}/mongodb-${PLATFORM}-x86_64-subscription-rhel62-${MONGO_VERSION}.${FILE_EXT}"
else
  export MONGO_DOWNLOAD_URL="http://${DOWNLOAD_URL}/${PLATFORM}/mongodb-${PLATFORM}-x86_64-${ENTERPRISE_LABEL}-${MONGO_VERSION}.${FILE_EXT}"
fi

echo "Downloading: ${MONGO_DOWNLOAD_URL}"

curl ${MONGO_DOWNLOAD_URL} -o mongod-binaries.${FILE_EXT} --silent --max-time 120
${PLATFORM_DECOMPRESS} mongod-binaries.${FILE_EXT}
mv mongodb-* mongod
chmod +x mongod/bin/*
./mongod/bin/mongod --version
