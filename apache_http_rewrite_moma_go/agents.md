LoadModule proxy_module         libexec/apache2/mod_proxy.so
LoadModule proxy_http_module    libexec/apache2/mod_proxy_http.so
LoadModule rewrite_module       libexec/apache2/mod_rewrite.so

<VirtualHost *:80>
    ServerName go
    ServerAlias localhost moma

    ProxyRequests Off
    ProxyPreserveHost On

    RewriteEngine On

    # --- shortcut: go/hungry ---
    RewriteCond %{HTTP_HOST} ^go$
    RewriteRule ^/hungry/?$ http://canteen.example.com/menu [P,L]

    # --- shortcut: go/docs ---
    RewriteCond %{HTTP_HOST} ^go$
    RewriteRule ^/docs/?$ https://docs.example.com [P,L]

    # --- fallback: local site ---
    DocumentRoot "/usr/local/var/www"
    <Directory "/usr/local/var/www">
        Require all granted
    </Directory>
</VirtualHost>