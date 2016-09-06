all: evt
evt: libuvtls.a

libuvtls.a: uv_tls.c evt_tls.c uv_tls.h evt_tls.h
	$(CC) -g -Wall -c uv_tls.c evt_tls.c -lssl -lcrypto -lrt -luv
	ar -cvq libuvtls.a *.o

clean:
	rm -f *.o
	rm -f libuvtls.a
