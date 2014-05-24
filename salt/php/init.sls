php-base:
  pkg.installed:
    - pkgs:
      - php5-cli
      - php5-curl
      - php5-imagick
      - php5-mcrypt
      - php5-gd
      - php5-imap
{% if grains['os'] == 'Ubuntu' %}      
      - php5-readline
      - php5-json
{% endif %}
