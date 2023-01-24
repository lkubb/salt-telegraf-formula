# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_plugins_pkgs_installed = tplroot ~ ".plugins._pkgs.installed" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_plugins_pkgs_installed }}

{%- set listen = telegraf | traverse("config:inputs:socket_listener", []) | map(attr="service_address") | list %}
{%- set ports = [] %}
{%- for addr in listen %}
{%-   if addr | regex_match(".*:[\d]+$") %}
{%-     do ports.append(addr.split(":") | last) %}
{%-   endif %}
{%- endfor %}

{#- Currently only automanage on RedHat #}
{%- if ports and grains["os_family"] == "RedHat" %}

Telegraf socket_listener service is known:
  firewalld.service:
    - name: telegraf_socket_listener
    - ports: {{ ports | json }}
    - require:
      - sls_plugins_pkgs_installed

Telegraf socket_listener ports are open:
  firewalld.present:
    - name: public
    - ports:
      - telegraf_socket_listener
    - require:
      - firewalld: telegraf_socket_listener
{%- endif %}
