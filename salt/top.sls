base:
  '*':
    - user
    - joe
    - stuffs
  
  'mail.e36.sg':
    - docker
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
    - mysql
    - ftp

  'mail.m18.org':
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - mysql   
    - ftp

  'mail.vault-tec.de':
    - webserver.{{ pillar['webserver'][grains['id']] }}

  'utgard.m18.org':
    - user.customer
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
