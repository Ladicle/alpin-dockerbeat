#!/usr/bin/env sh

# Wait for the Elasticsearch container to be ready before starting Kibana.
echo "Stalling for Elasticsearch"
while true; do
    nc -q 1 elasticsearch 9200 2>/dev/null && break
done

echo "Register index template to Elasticsearch"
curl -X PUT http://elasticsearch:9200/_template/dockerbeat \
     -d@/etc/dockerbeat/dockerbeat.template.json

echo "Start dockerbeat"
exec dockerbeat -c /etc/dockerbeat/dockerbeat.yml -e
