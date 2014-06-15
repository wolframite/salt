base:
  '*':
    - user
    - joe
    - stuffs
  
  'mail2.m18.org':
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
    - mysql
    - mysql.customer
    - ftp
    - mail
    - mail.opendkim

  'mail.m18.org':
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
    - mysql
    - mysql.customer
    - ftp
    - mail
    - mail.opendkim

  'utgard.m18.org':
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}

  'attic.m18.org':
    - user.customer
    - mysql.client
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
    - ftp
