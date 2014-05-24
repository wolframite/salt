joe:
  pkg.installed

/etc/joe/joerc:
  file.managed:
    - source: salt://joe/joerc
    - mode: 644
    - user: root
    - group: root
    - require: 
      - pkg: joe

/etc/joe/ftyperc:
  file.managed:
    - source: salt://joe/ftyperc
    - mode: 644
    - user: root
    - group: root
    - require: 
      - pkg: joe
