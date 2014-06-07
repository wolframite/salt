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

{% if 'subdomains' in userinfo %}
/var/www/{{ domain }}/subdomains:
  file.directory:     
    - user: root      
    - group: root     
    - mode: 755       
    - makedirs: true  
    - require: 
      - file: /var/www/{{ domain }}
{% endif %}

{{ user }}-{{ domain }}-home:
  user.present:
    - name: {{ user }}
    - home: /var/www/{{ domain }}
    - require: [ file: /var/www/{{ domain }} ]

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

{% if 'subdomains' in userinfo %}
{% for subdomain, domain in userinfo['subdomains'].iteritems() %}

/var/www/{{ domain }}/subdomains/{{ subdomain }}:
  file.directory:   
    - user: root    
    - group: root   
    - mode: 755     
    - makedirs: true
    - require: 
      - file: /var/www/{{ domain }}/subdomains

/var/www/{{ domain }}/subdomains/{{ subdomain }}/public:
  file.directory:     
    - user: {{ user }}      
    - group: www-data     
    - mode: 750       
    - makedirs: true
    - require: 
      - file: /var/www/{{ domain }}/subdomains/{{ subdomain }}

/var/www/{{ domain }}/subdomains/{{ subdomain }}/log:
  file.directory:     
    - user: www-data
    - group: {{ user }}  
    - mode: 750   
    - makedirs: true  
    - require: 
      - file: /var/www/{{ domain }}/subdomains/{{ subdomain }}

/etc/apache2/sites-available/{{ domain }}_{{ subdomain }}:
  file:
    - managed
    - source: salt://webserver/tpl_apache_subdomain
    - template: jinja
    - defaults:
        domain_name: {{ domain }}
        server_admin: {{ userinfo['email'] }}
        subdomain_name: {{ subdomain }}

/etc/apache2/sites-enabled/{{ domain }}_{{ subdomain }}.conf:
  file.symlink:
    - target: /etc/apache2/sites-available/{{ domain }}_{{ subdomain }}
    - require: 
      - file: /etc/apache2/sites-available/{{ domain }}_{{ subdomain }}

{% endfor %}
{% endif %}

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
