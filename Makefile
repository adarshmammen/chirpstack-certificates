make: certs/ca certs/loraserver/api certs/lora-app-server/api certs/lora-geo-server/api certs/lora-gateway-bridge/basicstation

docker:
	docker run --rm cfssl make

clean:
	rm -rf certs

certs/ca:
	mkdir -p certs/ca
	cfssl gencert -initca config/ca-csr.json | cfssljson -bare certs/ca/ca

certs/loraserver/api: certs/ca
	mkdir -p certs/loraserver/api/server
	mkdir -p certs/loraserver/api/client

	# loraserver api server certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile server config/loraserver/api/server/certificate.json | cfssljson -bare certs/loraserver/api/server/loraserver-api-server

	# loraserver api client certificate (e.g. for lora-app-server)
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile client config/loraserver/api/client/certificate.json | cfssljson -bare certs/loraserver/api/client/loraserver-api-client

certs/lora-app-server/api: certs/ca
	mkdir -p certs/lora-app-server/api/server
	mkdir -p certs/lora-app-server/api/client
	mkdir -p certs/lora-app-server/join-api/server
	mkdir -p certs/lora-app-server/join-api/client

	# lora-app-server api server certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile server config/lora-app-server/api/server/certificate.json | cfssljson -bare certs/lora-app-server/api/server/lora-app-server-api-server

	# lora-app-server api client certificate (e.g. for loraserver)
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile client config/lora-app-server/api/client/certificate.json | cfssljson -bare certs/lora-app-server/api/client/lora-app-server-api-client

	# lora-app-server join api server certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile server config/lora-app-server/join-api/server/certificate.json | cfssljson -bare certs/lora-app-server/join-api/server/lora-app-server-join-api-server

	# lora-app-server join api client certificate (e.g. for loraserver)
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile client config/lora-app-server/join-api/client/certificate.json | cfssljson -bare certs/lora-app-server/join-api/client/lora-app-server-join-api-client

certs/lora-geo-server/api: certs/ca
	mkdir -p certs/lora-geo-server/api/server
	mkdir -p certs/lora-geo-server/api/client

	# lora-geo-server api server certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile server config/lora-geo-server/api/server/certificate.json | cfssljson -bare certs/lora-geo-server/api/server/lora-geo-server-api-server

	# lora-geo-server api client certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile client config/lora-geo-server/api/client/certificate.json | cfssljson -bare certs/lora-geo-server/api/client/lora-geo-server-api-client

certs/lora-gateway-bridge/basicstation: certs/ca
	mkdir -p certs/lora-gateway-bridge/basicstation/server
	mkdir -p certs/lora-gateway-bridge/basicstation/client

	# basicstation websocket server certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile server config/lora-gateway-bridge/basicstation/server/certificate.json | cfssljson -bare certs/lora-gateway-bridge/basicstation/server/basicstation-server

	# basicstation websocket client (gateway) certificate
	cfssl gencert -ca certs/ca/ca.pem -ca-key certs/ca/ca-key.pem -config config/ca-config.json -profile client config/lora-gateway-bridge/basicstation/client/certificate.json | cfssljson -bare certs/lora-gateway-bridge/basicstation/client/basicstation-client

