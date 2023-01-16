# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

Telegraf secrets are managed:
  file.managed:
    - name: {{ telegraf.lookup.envfile }}
    - source: {{ files_switch(['etc/default/telegraf'],
                              lookup='Telegraf secrets are managed'
                 )
              }}
    - template: jinja
    - mode: '0640'
    - user: root
    - group: {{ telegraf.lookup.group }}
    - require:
      - sls: {{ sls_package_install }}
    - context:
        telegraf: {{ telegraf | json }}

Telegraf configuration is managed:
  file.serialize:
    - name: {{ telegraf.lookup.config }}
    - serializer: toml
    - mode: '0640'
    - user: root
    - group: {{ telegraf.lookup.group }}
    - makedirs: True
    - require:
      - sls: {{ sls_package_install }}
      - file: {{ telegraf.lookup.envfile }}
    - dataset: {{ telegraf.config | json }}
