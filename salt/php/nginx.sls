include:
  - php
  - webserver.nginx

php-nginx:
  pkg.installed:
    - name: php5-fpm
    - require:   
      - pkg: php-base

extend:
  nginx:
    service:
      - watch:
        - pkg: php-nginx
