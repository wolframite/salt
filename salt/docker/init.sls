{% if grains['os'] == 'Ubuntu' and grains['osrelease']|int() >= 13 and grains['osrelease']|int() <= 14 %}

docker_repo_ubuntu:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb http://get.docker.io/ubuntu docker main
    - file: /etc/apt/sources.list.d/docker.list
    - keyid: 36A1D7869245C8950F966E92D8576A8BA88D21E9
    - keyserver: keyserver.ubuntu.com

docker-install:
  pkg.installed:
    - name: lxc-docker
    - refresh: True
    - require: 
      - pkgrepo: docker_repo_ubuntu

{% endif %}
