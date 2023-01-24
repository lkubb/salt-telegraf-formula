# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

Telegraf is dead:
  service.dead:
    - name: {{ telegraf.lookup.service.name }}
    - enable: False
