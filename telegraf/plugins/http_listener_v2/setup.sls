# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_plugins_pkgs_installed = tplroot ~ ".plugins._pkgs.installed" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_plugins_pkgs_installed }}

{%- set listen = telegraf | traverse("config:inputs:http_listener_v2", []) | map(attr="service_address") | list %}

{#- Currently only automanage on RedHat #}
{%- if listen and grains["os_family"] == "RedHat" %}

Telegraf http_listener_v2 service is known:
  firewalld.service:
    - name: telegraf_http_listener_v2
    - ports:
{%-   for addr in listen %}
      - {{ addr.split(":") | last }}
{%-   endfor %}
    - require:
      - sls_plugins_pkgs_installed

Telegraf http_listener_v2 ports are open:
  firewalld.present:
    - name: public
    - ports:
      - telegraf_http_listener_v2
    - require:
      - firewalld: telegraf_http_listener_v2
{%- endif %}
