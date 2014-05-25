{% if 'customers' in pillar %}
include:
  - user.customer

{% for user, userinfo in pillar['customers'].iteritems() %}
{% if salt['grains.get']('id', '') == userinfo['server'] %}
{% for db, pw in userinfo['databases'].iteritems() %}

db_{{ user }}:
  mysql_user.present:
    - name: {{ user }}
    - host: localhost
    - password: {{ pw }}

  mysql_database.present:
    - name: {{ db }}

  mysql_grants.present:
    - grant: select,insert,update
    - database: {{ db }}.*
    - user: {{ user }}
    - host: localhost
    - grant_option: False

{% endfor %}
{% endif %}
{% endfor %}
{% endif %}