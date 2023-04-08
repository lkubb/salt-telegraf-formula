# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

Telegraf user cannot execute fail2ban-client as root without password:
  file.absent:
    - name: {{ telegraf.lookup.sudoers | path_join("90-telegraf-fail2ban") }}
