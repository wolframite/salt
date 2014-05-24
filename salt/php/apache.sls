include:
  - php
  - webserver.apache

php-apache:
  pkg.installed:
    - name: php5
    - require:   
      - pkg: php-base

extend:
  apache:
    service:
      - watch:
        - pkg: php-apache
