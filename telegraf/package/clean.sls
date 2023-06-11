# vim: ft=sls

{#-
    Removes the telegraf package.
    Has a dependency on `telegraf.config.clean`_.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_config_clean = tplroot ~ ".config.clean" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_config_clean }}
  - {{ slsdotpath }}.repo.clean

Telegraf is removed:
  pkg.removed:
    - name: {{ telegraf.lookup.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
