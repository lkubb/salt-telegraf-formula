# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
{%- if telegraf.lookup.pkg_manager in ['apt', 'dnf', 'yum', 'zypper'] %}
  - {{ slsdotpath }}.install
{%- elif salt['state.sls_exists'](slsdotpath ~ '.' ~ telegraf.lookup.pkg_manager) %}
  - {{ slsdotpath }}.{{ telegraf.lookup.pkg_manager }}
{%- else %}
  []
{%- endif %}
