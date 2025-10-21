# Simple Makefile for gedcom-parse on macOS
# Just run: make

SRCDIR = /tmp/gedcom-parse-0.90.0
PORTFILE = $(SRCDIR)/t/src/portability.c
CFILES = $(SRCDIR)/t/src/gomtest.c $(SRCDIR)/t/src/dump_gom.c $(SRCDIR)/t/src/update.c $(SRCDIR)/t/src/testintl.c

all:
	@echo "==> Entering $(SRCDIR)"
	cd $(SRCDIR) && \
	if [ -f "$(PORTFILE)" ]; then \
		echo "==> Patching portability.c"; \
		if ! grep -q '__aarch64__' "$(PORTFILE)"; then \
			tmp=$$(mktemp); \
			awk '/^#if SIZEOF_VOID_P == 4/ { \
				print "#if defined(__aarch64__) || defined(__arm64__) || defined(__x86_64__)"; \
				print "# define SIZEOF_VOID_P 8"; \
				print "#endif"; \
			} {print $$0}' "$(PORTFILE)" > $$tmp && mv $$tmp "$(PORTFILE)"; \
		fi; \
	fi && \
	for f in $(CFILES); do \
		[ -f "$$f" ] || continue; \
		if grep -Eq '\bstrcmp\b|\bstrncmp\b' "$$f" && ! grep -q '<string.h>' "$$f"; then \
			echo "==> Adding <string.h> to $${f##*/}"; \
			tmp=$$(mktemp); printf '#include <string.h>\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
		if grep -Eq '\bcalloc\b|\bfree\b|\bexit\b' "$$f" && ! grep -q '<stdlib.h>' "$$f"; then \
			echo "==> Adding <stdlib.h> to $${f##*/}"; \
			tmp=$$(mktemp); printf '#include <stdlib.h>\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
		if grep -Eq '\boutput\b' "$$f" && ! grep -q '"output.h"' "$$f"; then \
			echo "==> Adding \"output.h\" to $${f##*/}"; \
			tmp=$$(mktemp); printf '#include "output.h"\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
	done && \
	unset CFLAGS CPPFLAGS LDFLAGS && \
	export CC=clang CXX=clang++ SDKROOT=$$(xcrun --show-sdk-path) CFLAGS="-std=gnu89 -DSIZEOF_VOID_P=8" && \
	echo "==> Configuring..." && ./configure && \
	echo "==> Building..." && make


build:
	cd /tmp/gedcom-parse-0.90.0/ \
		&& sed -i.bak '/^#if SIZEOF_VOID_P == 4/ i\
#if defined(__aarch64__) || defined(__arm64__) || defined(__x86_64__)\
# define SIZEOF_VOID_P 8\
#endif' src/portability.c \
		&& unset CFLAGS CPPFLAGS LDFLAGS \
		&& export CC=clang CXX=clang++ SDKROOT=$(xcrun --show-sdk-path) CFLAGS="-std=gnu89 -DSIZEOF_VOID_P=8" \
		&& ./configure || cat /tmp/gedcom-parse-0.90.0/config.log \
		&& make

		
# 		&& ./configure \
# 		&& export CFLAGS="-arch arm64" && export LDFLAGS="-arch arm64" \
	
unzip:
	cp gedcom-parse-0.90.0.tar.gz /tmp/ \
		&& cd /tmp/ \
		&& tar -xf gedcom-parse-0.90.0.tar.gz \
		&& cd gedcom-parse-0.90.0/ \
		&& open .
download:		
	wget 'https://master.dl.sourceforge.net/project/gedcom-parse/gedcom-parse/0.90.0/gedcom-parse-0.90.0.tar.gz?viasf=1'
	echo "TODO 2025-10 get the old C library build working"