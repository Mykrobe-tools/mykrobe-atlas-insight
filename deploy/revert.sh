# remove the failed deployment directory
CURRENT_VERSION=$(cat /var/go/releases/api/CURRENT_VERSION)
rm -R /var/go/releases/insight/$CURRENT_VERSION

# remove the failed image
docker images | grep $CURRENT_VERSION | awk '{print $1}' | xargs docker rmi

# work with the prior working version
PREVIOUS_VERSION=$(cat /var/go/releases/api/PREVIOUS_VERSION)
cd /var/go/releases/insight/$PREVIOUS_VERSION/deploy

# remove current images
docker rm -f insight insight-db || true
docker images -q --filter "dangling=true" | xargs --no-run-if-empty docker rmi

# run docker-compose up
docker-compose up -d

# clean containers down
./dkcleanup.sh