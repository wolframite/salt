php-base:
  pkg.installed:
    - pkgs:
      - php5-cli
      - php5-curl
      - php5-imagick
      - php5-mcrypt
      - php5-gd
      - php5-imap
      - php5-mysql
{% if grains['os'] == 'Ubuntu' and grains['osrelease']|int() > 13 %}
      - php5-readline
      - php5-json
{% endif %}
