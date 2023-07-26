```sh
# Create the SSL Certificate
mkdir /etc/ssl/private
chmod 700 /etc/ssl/private

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt

# openssl: This is the basic command line tool for creating and managing OpenSSL certificates, keys, and other files.
# req: This subcommand specifies that you want to use X.509 certificate signing request (CSR) management.
# -x509: This further modifies the previous subcommand by telling the utility that you want to make a self-signed certificate instead of generating a certificate signing request, as would normally happen.
# -nodes: This tells OpenSSL to skip the option to secure your certificate with a passphrase.
# -days 365: This option sets the length of time that the certificate will be considered valid.
# -newkey rsa:2048: This specifies that you want to generate a new certificate and a new key at the same time.
# -keyout: This line tells OpenSSL where to place the generated private key file that you are creating.
# -out: This tells OpenSSL where to place the certificate that you are creating.

openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

# Configure Nginx to Use SSL
#!/etc/nginx/conf.d/ssl.conf
server {
    listen 443 http2 ssl;
    listen [::]:443 http2 ssl;

    server_name your_server_ip;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_dhparam /etc/ssl/certs/dhparam.pem;

    ########################################################################
    # from https://cipherlist.eu/                                            #
    ########################################################################
    
    ssl_protocols TLSv1.3;# Requires nginx >= 1.13.0 else use TLSv1.2
    ssl_prefer_server_ciphers on;
    ssl_ciphers EECDH+AESGCM:EDH+AESGCM;
    ssl_ecdh_curve secp384r1; # Requires nginx >= 1.1.0
    ssl_session_timeout  10m;
    ssl_session_cache shared:SSL:10m;
    ssl_session_tickets off; # Requires nginx >= 1.5.9
    ssl_stapling on; # Requires nginx >= 1.3.7
    ssl_stapling_verify on; # Requires nginx => 1.3.7
    resolver 8.8.8.8 8.8.4.4 valid=300s;
    resolver_timeout 5s;
    # Disable preloading HSTS for now.  You can use the commented out header line that includes
    # the "preload" directive if you understand the implications.
    #add_header Strict-Transport-Security "max-age=63072000; includeSubDomains; preload";
    add_header X-Frame-Options DENY;
    add_header X-Content-Type-Options nosniff;
    add_header X-XSS-Protection "1; mode=block";
    ##################################
    # END https://cipherlist.eu/ BLOCK #
    ##################################
    root /usr/share/nginx/html;

    location / {
    }

    error_page 404 /404.html;
    location = /404.html {
    }

    error_page 500 502 503 504 /50x.html;
    location = /50x.html {
    }
}


