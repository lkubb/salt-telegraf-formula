# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_service_clean }}

telegraf-config-clean-file-absent:
  file.absent:
    - name: {{ telegraf.lookup.config }}
    - require:
      - sls: {{ sls_service_clean }}
