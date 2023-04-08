# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_plugins_pkgs_installed = tplroot ~ ".plugins._pkgs.installed" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_plugins_pkgs_installed }}

{%- set listen = telegraf | traverse("config:inputs:influxdb_v2_listener", []) | map(attr="service_address") | list %}

{#- Currently only automanage on RedHat #}
{%- if listen and grains["os_family"] == "RedHat" %}

Telegraf influxdb_v2_listener service is known:
  firewalld.service:
    - name: telegraf_influxdb_v2_listener
    - ports:
{%-   for addr in listen %}
      - {{ addr.split(":") | last }}
{%-   endfor %}
    - require:
      - sls_plugins_pkgs_installed

Telegraf influxdb_v2_listener ports are open:
  firewalld.present:
    - name: public
    - ports:
      - telegraf_influxdb_v2_listener
    - require:
      - firewalld: telegraf_influxdb_v2_listener
{%- endif %}
