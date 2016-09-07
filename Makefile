all: evt
evt: out/libuvtls.a

out/libuvtls.a: uv_tls.c evt_tls.c uv_tls.h evt_tls.h
	mkdir -p out
	$(CC) -g -Wall -c uv_tls.c evt_tls.c -lssl -lcrypto -lrt -luv
	ar -cvq out/libuvtls.a *.o

tests: evt samples/tls_client_test.c samples/tls_server_test.c gen_cert
	$(CC) -g -Wall samples/tls_client_test.c -lssl -lcrypto -lrt -luv -I. -luvtls -Lout -o samples/tls_client_test
	$(CC) -g -Wall samples/tls_server_test.c -lssl -lcrypto -lrt -luv -I. -luvtls -Lout -o samples/tls_server_test

gen_cert:
	openssl req -x509 -newkey rsa:2048 -nodes -keyout samples/server-key.pem  \
	      -out samples/server-cert.pem -config samples/ssl_test.cnf
	-cp -rf samples/server-cert.pem samples/server-key.pem samples/

clean:
	rm -f *.o
	rm -fr out
