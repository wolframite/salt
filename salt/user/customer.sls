hosting:
  group.present:
    - gid: 2557

{% set host_id = salt['grains.get']('id', '') %}

{% for user, userinfo in pillar['customers'].iteritems() %}
{% if host_id == userinfo['server'] %}

{{user}}:
  user.present:
    - fullname: {{ userinfo['fullname'] }}
    - shell: {{ userinfo['shell'] }}
    - groups: {{ userinfo['groups'] }}
    - createhome: False

{% endif %}
{% endfor %}
