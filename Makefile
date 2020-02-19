INTERP = python3
CC = gcc
CFLAGS = -Wall -Werror -O2
LDFLAGS = -I includes/
DEPS = includes/append.h
OBJ = src/append.o


%.o: %.c $(DEPS)
	$(CC) $(CFLAGS) $(LDFLAGS) -c -o $@ $<

append: $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) main.c -o $@ $^

append.so: src/append.c
	$(CC) $(CFLAGS) $(LDFLAGS) -shared -o $@ -fPIC $^

install:
	mkdir lib
	mkdir bin
	mv append bin/
	mv append.so lib/

clean:
	rm -rf lib bin
	rm $(OBJ)
