KEYCLOAK_VERSION=13.0.1

build-keycloak:
	[ -d docker/keycloak ] || rm -rf docker/keycloak
	cd keycloak; mvn -Pdistribution -pl distribution/server-dist -am -Dmaven.test.skip clean install
	cp keycloak/distribution/server-dist/target/keycloak-${KEYCLOAK_VERSION}.zip docker
	cd docker; unzip keycloak-${KEYCLOAK_VERSION}.zip;\
	rm keycloak-${KEYCLOAK_VERSION}.zip; \
	mv keycloak-${KEYCLOAK_VERSION} keycloak

apply-configs:cp-jdbc cp-standalone-conf

docker-build:
	docker build -t keycloak-sandbox:0.1 docker
