run:
	cd /Volumes/git/github/2025/gedcom-parse && /tmp/gedcom-parse-0.90.0/t/src/testgedcom gedcom-parse-0.90.0/t/input/allged.ged

repair_others:
	cd ~/trash/ && ln -s /Volumes/git/github/2025/gedcom-parse/gedcom-parse-0.90.0
	cd /Volumes/git/github/2025/depot_parent/c/7_gedcom && ln -sf ~/sarnobat.git/2023/genealogy/rohidekar.ged

build:
	echo "We don't need Docker. This works on Mac OS."
# 	cp /Volumes/git/github/2025/gedcom-parse/gedcom-parse-0.90.0/t/src/standalone.c /tmp/gedcom-parse-0.90.0/t/src/standalone.c
	cd /Volumes/git/github/2025/gedcom-parse && make init \
		&& cp -v /Volumes/git/github/2025/gedcom-parse/gedcom-parse-0.90.0/t/src/standalone.c /tmp/gedcom-parse-0.90.0/t/src/standalone.c \
		&& sleep 5 \
		&& make && make test && ./testgedcom gedcom-parse-0.90.0/t/input/allged.ged
	@echo "TODO: get this working: ~/sarnobat.git/2023/genealogy/rohidekar.ged"
	@echo "'/Users/sarnobat/github/2025/gedcom-parse/gedcom-parse-0.90.0/gedcom flex bison lex yacc here.2025-02-13.txt'"
	
	