# vim: ft=sls

{#-
    Stops the telegraf service and disables it at boot time.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

Telegraf is dead:
  service.dead:
    - name: {{ telegraf.lookup.service.name }}
    - enable: false
