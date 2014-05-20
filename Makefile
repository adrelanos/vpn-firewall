#!/usr/bin/make -f

DESTDIR ?= /

all:
	@echo "make all is not required."

install:
	for d in bin boot dev etc home lib opt sbin srv sys usr var; do if [ -d $${d} ]; then cp -R $${d} ${DESTDIR}; fi; done

clean:
	git clean -df

.PHONY: clean install
