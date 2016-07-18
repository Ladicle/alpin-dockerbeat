#!/usr/bin/env sh

# Wait for the Elasticsearch container to be ready before starting Kibana.
echo "Stalling for Elasticsearch"
while true; do
    printf "HEAD / HTTP/1.0\n\n" | nc elasticsearch 9200 >/dev/null 2>&1 && break
done

echo "Register index template to Elasticsearch"
curl -X PUT http://elasticsearch:9200/_template/dockerbeat \
     -d@/etc/dockerbeat/dockerbeat.template.json

echo "Start dockerbeat"
exec dockerbeat -c /etc/dockerbeat/dockerbeat.yml -e
