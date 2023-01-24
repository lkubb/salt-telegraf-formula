# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

{#-
    Some plugins need packages or further configuration.
    This is currently limited to input plugins by choice.
#}

{%- set include_states = [tplroot ~ ".plugins._pkgs.installed"] %}
{%- for plugin in telegraf | traverse("config:inputs", {}) %}
{%-   set plugin_sls = tplroot ~ ".plugins." ~ plugin ~ ".setup" %}
{%-   if salt["state.sls_exists"](plugin_sls) %}
{%-     do include_states.append(plugin_sls) %}
{%-   endif %}
{%- endfor %}

include: {{ include_states | json }}

# Ensure this file can be required
All Telegraf plugin requisites are setup:
  test.nop:
    - require:
{%- for sls in include_states %}
      - sls: {{ sls }}
{%- endfor %}
