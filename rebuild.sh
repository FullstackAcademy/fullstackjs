eval $(docker-machine env --swarm assess-dot-new)
docker build -t davidyang/fullstackjs github.com/davidyang/fullstackjs
docker pull davidyang/fullstackjs
