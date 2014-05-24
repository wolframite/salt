include: 
  - webserver
  - user.customer

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

{% if 'customers' in pillar %}
{% set reload_apache = False  %}
{% for user, userinfo in pillar['customers'].iteritems() %}
{% if salt['grains.get']('id', '') == userinfo['server'] %}
{% set reload_apache = True  %}

{% for domain in userinfo['domains'] %}

/etc/apache2/sites-available/{{ domain }}:
  file:
    - managed
    - source: salt://webserver/tpl_apache
    - template: jinja
    - defaults:
        domain_name: {{ domain }}
        server_admin: {{ userinfo['email'] }}

/var/www/{{ domain }}:
  file.directory:     
    - user: root      
    - group: root     
    - mode: 755       
    - makedirs: true  

/var/www/{{ domain }}/public:
  file.directory:   
    - user: {{ user }}
    - group: www-data 
    - mode: 750       
    - makedirs: true  
    - require:
      - user: {{ user }}

/var/www/{{ domain }}/log:
  file.directory:   
    - user: www-data
    - group: {{ user }}
    - mode: 750        
    - makedirs: true   
    - require:
      - user: {{ user }}

/var/www/{{ domain }}/private:
  file.directory:
    - user: {{ user }}
    - group: {{ user }}
    - mode: 700        
    - makedirs: true   
    - require:
      - user: {{ user }}

/etc/apache2/sites-enabled/{{ domain }}.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/{{ domain }}

{% endfor %}
{% endif %}
{% endfor %}

{% if reload_apache == True  %}
extend:
  apache:
    service:
      - watch:
        - file: /etc/apache2/sites-available/*

{% endif %}
{% endif %}
