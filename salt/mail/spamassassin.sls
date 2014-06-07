include: 
  - mail

spamd_pkgs:
  pkg:
    - installed
    - pkgs:
      - spamassassin 
      - spamc
    - require: 
      - pkg: postfix
