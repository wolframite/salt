vsftpd:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/vsftpd.conf

vsftpd-banner:
  file.replace:
    - name: /etc/vsftpd.conf
    - pattern: '\#?ftpd_banner[\s]?\=.*'
    - repl: 'ftpd_banner=Shake it baby!'
    - require:
      - pkg: vsftpd

vsftpd-passv-ports:
  file.append:
    - name: /etc/vsftpd.conf
    - text: [ pasv_min_port=49152, pasv_max_port=65534 ]

/etc/shells:
  file.append:
    - text: "/bin/false"
