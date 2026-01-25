new:
	DIR=$$(mktemp -d) && cd $$DIR && pwd && tar -xf /Volumes/git/github/2025/gedcom-parse/gedcom-parse-0.90.0.tar.gz  && cd gedcom-parse-0.90.0 && find "$$(pwd)" -maxdepth 1 \
		&& \
	if [ -f "t/src/portability.c" ]; then \
		if ! grep -q '__aarch64__' "t/src/portability.c"; then \
			tmp=$$(mktemp); \
			awk '/^#if SIZEOF_VOID_P == 4/ { \
				print "#if defined(__aarch64__) || defined(__arm64__) || defined(__x86_64__)"; \
				print "# define SIZEOF_VOID_P 8"; \
				print "#endif"; \
			} {print $$0}' "t/src/portability.c" > $$tmp && mv $$tmp "t/src/portability.c"; \
		fi; \
	fi && \
	for ENC_FILE in src/encoding.c gedcom/encoding.c; do \
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
	for f in $$(find t/src -name '*.c'); do \
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
	done \
	&& unset CFLAGS CPPFLAGS LDFLAGS && \
	export CC=clang CXX=clang++ SDKROOT=$$(xcrun --show-sdk-path) CFLAGS="-std=gnu89 -DSIZEOF_VOID_P=8" && \
	./configure && \
	make && \
	echo "Your build is in: " $$(PWD) \
	&& du -sh \
	&& t/src/testgedcom t/input/allged.ged
