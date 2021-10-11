PUBLISH_VERSION=$(shell echo ${NEW_VERSION} | sed 's/inner-999/1/g')

GIT_COMMIT='demo-cart'
GIT_ORIGIN=$(shell git config --get remote.origin.url)

build:
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-adservice:latest --file ./src/adservice/Dockerfile ./src/adservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-cartservice:latest --file ./src/cartservice/src/Dockerfile ./src/cartservice/src --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-checkoutservice:latest --file ./src/checkoutservice/Dockerfile ./src/checkoutservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN} --build-arg SONARIO_GH_TOKEN=${SONARIO_GH_TOKEN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-currencyservice:latest --file ./src/currencyservice/Dockerfile ./src/currencyservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-emailservice:latest --file ./src/emailservice/Dockerfile ./src/emailservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-frontend:latest --file ./src/frontend/Dockerfile ./src/frontend --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN} --build-arg SONARIO_GH_TOKEN=${SONARIO_GH_TOKEN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-paymentservice:latest --file ./src/paymentservice/Dockerfile ./src/paymentservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-productcatalogservice:latest --file ./src/productcatalogservice/Dockerfile ./src/productcatalogservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN} --build-arg SONARIO_GH_TOKEN=${SONARIO_GH_TOKEN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-recommendationservice:latest --file ./src/recommendationservice/Dockerfile ./src/recommendationservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-shippingservice:latest --file ./src/shippingservice/Dockerfile ./src/shippingservice --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN} --build-arg SONARIO_GH_TOKEN=${SONARIO_GH_TOKEN}
	docker build --tag us.gcr.io/rookoutdemo/microservices-demo-loadgenerator:latest --file ./src/loadgenerator/Dockerfile ./src/loadgenerator --build-arg GIT_COMMIT=${GIT_COMMIT} --build-arg GIT_ORIGIN=${GIT_ORIGIN}


upload-cart-demo:
	docker push us.gcr.io/rookoutdemo/microservices-demo-adservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-cartservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-checkoutservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-currencyservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-emailservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-frontend:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-paymentservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-productcatalogservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-recommendationservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-shippingservice:latest
	docker push us.gcr.io/rookoutdemo/microservices-demo-loadgenerator:latest

upload-no-latest:
	docker push rookout/microservices-demo-adservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-cartservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-checkoutservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-currencyservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-emailservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-frontend:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-paymentservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-productcatalogservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-recommendationservice:${PUBLISH_VERSION}
	docker push rookout/microservices-demo-shippingservice:${PUBLISH_VERSION}

upload: upload-no-latest
	@if [ ${CIRCLE_BRANCH} = "master" ]; then \
		docker push rookout/microservices-demo-adservice:latest; \
		docker push rookout/microservices-demo-cartservice:latest; \
		docker push rookout/microservices-demo-checkoutservice:latest; \
		docker push rookout/microservices-demo-currencyservice:latest; \
		docker push rookout/microservices-demo-emailservice:latest; \
		docker push rookout/microservices-demo-frontend:latest; \
		docker push rookout/microservices-demo-paymentservice:latest; \
		docker push rookout/microservices-demo-productcatalogservice:latest; \
		docker push rookout/microservices-demo-recommendationservice:latest; \
		docker push rookout/microservices-demo-shippingservice:latest; \
	fi

build-and-upload: build upload