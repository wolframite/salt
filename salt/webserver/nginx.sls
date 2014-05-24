include: 
  - webserver

nginx:
  pkg:
    - installed
    - pkgs:
      - nginx
      - apache2-utils
  service:
    - running
    - require: [ pkg: nginx, file: www_root ]
