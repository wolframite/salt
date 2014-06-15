customers:
  jpachulke:
    server: mail.m18.org
    dbserver: mail.m18.org
    remotehost: 1.2.3.4
    fullname: josef.pachulke
    shell: /usr/sbin/nologin
    email: josef.pachulke@glasshole.com
    opendkim: True
    domains:
      - josefpachulke.com
    subdomains: { mycoolsubdomain: josefpachulke.com, testdomain: josefpachulke.com }
    aliases: 
      josefpachulke.com: josef-pachulke.com www.josefpachulke.com
    databases: { josefpachulke: supersecretpw }
    groups: 
     - users
     - hosting
