base:
  '*':
    - user
    - joe
  
  'mail.e36.sg':
    - docker
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}

  'mail.m18.org':
    - webserver.{{ pillar['webserver'][grains['id']] }}

  'mail.vault-tec.de':
    - webserver.{{ pillar['webserver'][grains['id']] }}

  'utgard.m18.org':
    - webserver.{{ pillar['webserver'][grains['id']] }}
    - php.{{ pillar['webserver'][grains['id']] }}
