base:
  '*':
    - user
    - joe
    - stuffs
  
  'mail.e36.sg':
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
