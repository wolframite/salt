{% if 'customers' in pillar %}
include:
  - user.customer

{% for user, userinfo in pillar['customers'].iteritems() %}
{% if salt['grains.get']('id', '') == userinfo['dbserver'] %}
{% for db, pw in userinfo['databases'].iteritems() %}

check_for_userdb_{{ db }}:
  mysql_database.present:
    - name: {{ db }}

db_{{ user }}_{{ db }}:
  mysql_user.present:
    - name: {{ user }}
{% if userinfo['dbserver'] != userinfo['server'] %}
    - host: {{ userinfo['remotehost'] }}
{% else %}
    - host: localhost
{% endif %}
    - password: {{ pw }}
    - require: 
      - mysql_database: check_for_userdb_{{ db }}

  mysql_grants.present:
    - grant: all privileges
    - database: {{ db }}.*
    - user: {{ user }}
{% if userinfo['dbserver'] != userinfo['server'] %}
    - host: {{ userinfo['remotehost'] }} 
{% else %}
    - host: localhost
{% endif %}
    - grant_option: False
    - require: [ mysql_database: check_for_userdb_{{ db }}, mysql_user: db_{{ user }}_{{ db }} ]
{% endfor %}
{% endif %}
{% endfor %}
{% endif %}
