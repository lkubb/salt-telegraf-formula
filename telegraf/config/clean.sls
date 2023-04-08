# vim: ft=sls

{#-
    Removes the configuration of the telegraf service and has a
    dependency on `telegraf.service.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_service_clean = tplroot ~ ".service.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_service_clean }}

Telegraf configuration is absent:
  file.absent:
    - name: {{ telegraf.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
