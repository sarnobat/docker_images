.PHONY: all clean

SRCDIR = /tmp/gedcom-parse-0.90.0
PORTFILE = $(SRCDIR)/t/src/portability.c
ENC_FILE1 = $(SRCDIR)/src/encoding.c
ENC_FILE2 = $(SRCDIR)/gedcom/encoding.c
CFILES = $(shell find $(SRCDIR)/t/src -name '*.c')

all:
	@echo "==> Entering $(SRCDIR)"
	cd $(SRCDIR) && \
	if [ -f "$(PORTFILE)" ]; then \
		if ! grep -q '__aarch64__' "$(PORTFILE)"; then \
			tmp=$$(mktemp); \
			awk '/^#if SIZEOF_VOID_P == 4/ { \
				print "#if defined(__aarch64__) || defined(__arm64__) || defined(__x86_64__)"; \
				print "# define SIZEOF_VOID_P 8"; \
				print "#endif"; \
			} {print $$0}' "$(PORTFILE)" > $$tmp && mv $$tmp "$(PORTFILE)"; \
		fi; \
	fi && \
	for ENC_FILE in $(ENC_FILE1) $(ENC_FILE2); do \
		if [ -f "$$ENC_FILE" ]; then \
			if ! grep -q 'return "ASCII";' "$$ENC_FILE"; then \
				tmp=$$(mktemp); \
				awk '\
				/char\* get_encoding/ { f=1; print; next } \
				/{/ { if(f){ print; print "    add_encoding(\"ASCII\", \"1\", \"ASCII\");"; print "    add_encoding(\"UTF-8\", \"1\", \"UTF-8\");"; f=0; next } } \
				{print}' "$$ENC_FILE" > $$tmp && mv $$tmp "$$ENC_FILE"; \
			fi; \
		fi; \
	done && \
	for f in $(CFILES); do \
		[ -f "$$f" ] || continue; \
		if grep -Eq '\bstrcmp\b|\bstrncmp\b' "$$f" && ! grep -q '<string.h>' "$$f"; then \
			tmp=$$(mktemp); printf '#include <string.h>\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
		if grep -Eq '\bcalloc\b|\bfree\b|\bexit\b' "$$f" && ! grep -q '<stdlib.h>' "$$f"; then \
			tmp=$$(mktemp); printf '#include <stdlib.h>\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
		if grep -Eq '\boutput\b' "$$f" && ! grep -q '"output.h"' "$$f"; then \
			tmp=$$(mktemp); printf '#include "output.h"\n' > $$tmp; cat "$$f" >> $$tmp; mv $$tmp "$$f"; \
		fi; \
	done && \
	unset CFLAGS CPPFLAGS LDFLAGS && \
	export CC=clang CXX=clang++ SDKROOT=$$(xcrun --show-sdk-path) CFLAGS="-std=gnu89 -DSIZEOF_VOID_P=8" && \
	./configure && \
	make \
	&& echo "Your file is called: $(SRCDIR)/t/src/testgedcom"

clean:
	cd $(SRCDIR) && make clean


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
