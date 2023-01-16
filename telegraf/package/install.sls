# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ slsdotpath }}.repo

Telegraf is installed:
  pkg.installed:
    - pkgs:
      - {{ telegraf.lookup.pkg.name }}
      - {{ telegraf.lookup.pip_pkg }}

TOML module is installed for Telegraf:
  pip.installed:
    - name: toml
    - require:
      - Telegraf is installed
