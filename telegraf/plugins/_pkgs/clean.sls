# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_config_clean }}

{%- set clean_pkgs = [] %}
{%- for plugin in telegraf | traverse("config:inputs", {}) %}
{%-   if plugin in telegraf.lookup.plugins %}
{%-     do clean_pkgs.extend(telegraf.lookup.plugins[plugin].pkgs) %}
{%-   endif %}
{%- endfor %}

{%- if clean_pkgs %}

Miscellaneous packages required for plugins are removed:
  pkg.absent:
    - pkgs: {{ clean_pkgs | json }}
{%- else %}

# Ensure this file can be required
There are no telegraf plugins with package requisites to cleanup:
  test.nop:
{%- endif %}
    - require:
      - sls: {{ sls_config_clean }}
