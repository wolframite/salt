include: 
  - webserver

apache:
  pkg:
    - installed
    - pkgs:
      - apache2
      - apache2-utils
  service:
    - running
    - name: apache2
    - require: [ file: www_root, pkg: apache ]
