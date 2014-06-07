include:
  - mail

opendkim_packages:
  pkg:
    - installed
    - pkgs:
      - opendkim 
      - opendkim-tools
    - require: 
      - pkg: postfix
    - service:
      - running
      - name: opendkim
    - watch: 
      - file: /etc/opendkim.conf

opendkim_no_socket:
  file.append:
    - name: /etc/default/opendkim
    - text: 'SOCKET="inet:12345@localhost"'

/etc/opendkim.conf:
  file.managed:
    - source: salt://mail/opendkim.conf

opendkim_folders:
  file.directory:
    - user: root
    - group: root
    - name: /etc/opendkim/keys
    - mode: 755
    - makedirs: true

opendkim_keytable:
  file.managed:   
    - user: root  
    - group: root 
    - name: /etc/opendkim/KeyTable
    - require: 
      - file: opendkim_folders

opendkim_signingtable:
  file.managed:   
    - user: root  
    - group: root 
    - name: /etc/opendkim/SigningTable
    - require: 
      - file: opendkim_folders

opendkim_trustedhosts:
  file.managed:   
    - user: root  
    - group: root 
    - name: /etc/opendkim/TrustedHosts
    - require: 
      - file: opendkim_folders

opendkim_trustedhosts_add_basics:
  file.append:
    - name: /etc/opendkim/TrustedHosts
    - text: [ '127.0.0.1', 'localhost' ]

activate_opendkim_postfix: 
  file.append:
    - name: /etc/postfix/main.cf
    - text: [ 'smtpd_milters = inet:localhost:12345', 'non_smtpd_milters = inet:localhost:12345' ]

{% for user, userinfo in pillar['customers'].iteritems() %}
{% for domain in userinfo['domains'] %}
{% if userinfo['opendkim'] == True %}
{% if salt['grains.get']('id', '') == userinfo['server'] %}

create_keys_folder_{{ domain }}:
  file.directory:
    - user: root 
    - group: root
    - name: /etc/opendkim/keys/{{ domain }}
    - mode: 755
    - makedirs: true

{% if salt['file.file_exists']('/etc/opendkim/keys/' + domain + '/mail.txt') == False %}
create_domain_key_{{ domain }}:
  cmd.run:
    - name: opendkim-genkey -s mail -d {{ domain }}
    - cwd: /etc/opendkim/keys/{{ domain }}
  
set_mode_domain_key_{{ domain }}:
  cmd.run: 
    - name: 'find -name mail.private | xargs chmod 600'
    - cwd: /etc/opendkim/keys/{{ domain }}

set_owner_domain_key_{{ domain }}:
  cmd.run:
    - name: 'find -name mail.private | xargs chown opendkim:opendkim'
    - cwd: /etc/opendkim/keys/{{ domain }}
{% endif %} 

{% set domain_key_entry = 'mail._domainkey.' + domain + ' ' + domain + ':mail:/etc/opendkim/keys/' + domain + '/mail.private' %}
opendkim_keytable_{{ domain }}:
  file.append:
    - name: /etc/opendkim/KeyTable
    - text: {{ domain_key_entry }}

{% set signing_table_entry = '*@' + domain + ' mail._domainkey.' + domain %}
opendkim_signingtable_{{ domain }}:
  file.append:
    - name: /etc/opendkim/SigningTable
    - text: "{{ signing_table_entry }}"

{% set trusted_host_entry = '*.' + domain %}
opendkim_trustedhosts_{{ domain }}:
  file.append:
    - name: /etc/opendkim/TrustedHosts
    - text: "{{ trusted_host_entry }}"

{% endif %}
{% endif %}
{% endfor %}
{% endfor %}
