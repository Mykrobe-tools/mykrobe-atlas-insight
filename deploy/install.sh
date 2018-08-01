#/bin/bash
set -e

export CURRENT_VERSION=`date +"%Y%m%d%H%M"`

echo $CURRENT_VERSION > /var/go/releases/insight/CURRENT_VERSION

mkdir -p /var/go/releases/insight/$CURRENT_VERSION
cd /var/go/releases/insight/$CURRENT_VERSION

cp -rf /var/lib/go-agent/pipelines/${TARGET_ENVIRONMENT}-atlas-insight/. .

# remove current images
docker images -q --filter "dangling=true" | xargs --no-run-if-empty docker rmi

export CURRENT_VERSION=`cat /var/go/releases/insight/CURRENT_VERSION`
export PREVIOUS_VERSION=`cat /var/go/releases/insight/PREVIOUS_VERSION`

# remove unwanted containers
docker rm -f insight insight-db || true
cd /var/go/releases/insight/$CURRENT_VERSION/deploy

# run docker-compose up
subber docker-compose.yml
docker-compose up -d

# clean containers down
./dkcleanup.sh

# remove unused volumes
echo 'Start volumes cleanup'
docker volume ls -qf dangling=true | xargs -r docker volume rm
echo 'End volumes cleanup'

# all ok set PREVIOUS_VERSION
echo $CURRENT_VERSION > /var/go/releases/insight/PREVIOUS_VERSION