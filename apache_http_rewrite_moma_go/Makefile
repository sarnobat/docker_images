.PHONY: all stop start restart logs

HTTPD_CONF := $(realpath httpd.conf)

all: restart
	open "http://go/hungry"
	
stop:
	-sudo apachectl -k stop

start:
	sudo httpd -f $(HTTPD_CONF) -k start

restart: stop start

logs:
	tail /private/var/log/apache2/access_log /private/var/log/apache2/error_log
