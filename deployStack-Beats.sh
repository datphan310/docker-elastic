#!/bin/bash

export ELASTIC_VERSION=6.6.0
export ELASTICSEARCH_USERNAME=elastic
export ELASTICSEARCH_PASSWORD=changeme
export ELASTICSEARCH_HOST=swarm-manager
export KIBANA_HOST=swarm-manager
#export ELASTICSEARCH_URL=http://192.168.5.103:9200

docker stack deploy --compose-file filebeat-docker-compose.yml filebeat
docker stack deploy --compose-file metricbeat-docker-compose.yml metricbeat
docker stack deploy --compose-file packetbeat-docker-compose.yml packetbeat