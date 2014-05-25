mysql_install:
  pkg.installed:
    - pkgs:
      - mysql-server
      - mysql-client
      - python-mysqldb

{{ pillar['mysql_config_file'] }}:
  file.replace:
    - pattern: 'max_allowed_packet[\s]+\=.*'
    - repl: {{ pillar['mysql_config_file_max_allowed_packet']  }}

mysql:
  service.running:
    - enable: True
    - watch: [ pkg: mysql_install, file: {{ pillar['mysql_config_file'] }} ]

salt-mysql-settings:
  file.append:
    - name: /etc/salt/minion
    - text: "mysql.default_file: /etc/mysql/debian.cnf"
