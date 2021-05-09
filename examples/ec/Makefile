CFLAGS=-O3
LDFLAGS=-lpthread -libverbs -lzmq 

LIBS = /usr/lib/libisal.a
INC = 

all: ec_simple_example

ec_simple_example: ec_simple_example.c ${LIBS}
	gcc -o ec_simple_example ec_simple_example.c ${CFLAGS} ${INC} ${LIBS} ${LDFLAGS}

clean:
	rm ec_simple_example