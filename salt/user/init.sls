adm:
  group.present

users:
  group.present

sudo:
  pkg.installed

tmux:
  pkg.installed

whuesken:
  user.present:
    - fullname: "Wolfram Huesken"
    - shell: /bin/bash
    - home: /home/whuesken
    - groups:
      - adm
      - users
      - sudo
    - require: [ group: adm, group: users, pkg: sudo ]
  ssh_auth:
    - present
    - user: whuesken
    - source: salt://user/whuesken.pub
    - require:
      - user: whuesken

/home/whuesken/.tmux.conf:
  file:
    - managed
    - source: salt://user/tmux.conf
    - mode: 644
    - user: whuesken
    - group: whuesken
    - require: [ user: whuesken, pkg: tmux ]

/etc/sudoers.d/90-vault-tec:
  file:
    - managed
    - source: salt://user/sudo_vault
    - mode: 440
    - require: 
      - pkg: sudo
