# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_config_clean }}
  - {{ slsdotpath }}.repo.clean

telegraf-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ telegraf.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
