postfix: 
  pkg:
    - installed
  service:   
    - running
  file: 
    - managed
    - name: /etc/postfix/main.cf
  watch: 
    - file: /etc/postfix/main.cf
