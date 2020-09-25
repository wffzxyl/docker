xnet:
	docker network create --driver overlay --attachable  xnet

xstack:
	docker stack rm xstack
	sleep 5
	docker stack deploy -c docker-compose.yml --prune --with-registry-auth xstack

xprune:
	rm -rf data/mysql/data/*
	rm -rf data/redis/data/*
	rm -rf data/elasticsearch/data/*
	rm -rf data/elasticsearch/logs/*
	rm -rf data/zookeeper/data/*
	rm -rf data/zookeeper/datalog/*
	rm -rf data/zookeeper/logs/*
	rm -rf data/kafka/data/*
	rm -rf data/kafka/logs/*

#xproxyer:
#	docker stack rm proxyer
#	docker stack deploy -c proxyer.yml --prune --with-registry-auth proxyer

xpull:
	cat *.yml | grep image | grep -v '#' | awk '{print $$2}' | xargs -I{} docker pull {}

xclean:
	# docker stack rm proxyer
	docker stack rm xstack
