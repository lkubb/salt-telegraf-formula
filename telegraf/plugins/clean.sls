# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

{%- set include_states = [tplroot ~ ".plugins._pkgs.clean"] %}
{%- for plugin in telegraf | traverse("config:inputs", {}) %}
{%-   set plugin_sls = tplroot ~ ".plugins." ~ plugin ~ ".clean" %}
{%-   if salt["state.sls_exists"](slsdotpath ~ "." ~ plugin ~ ".clean") %}
{%-     do include_states.append(plugin_sls) %}
{%-   endif %}
{%- endfor %}

include: {{ include_states | json }}

# Ensure this file can be required
All Telegraf plugin requisites are cleaned:
  test.nop:
    - require:
{%- for sls in include_states %}
      - sls: {{ sls }}
{%- endfor %}
