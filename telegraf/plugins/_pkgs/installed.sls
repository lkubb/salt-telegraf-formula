# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

include:
  - {{ sls_package_install }}

{%- set install_pkgs = [] %}
{%- for plugin in telegraf | traverse("config:inputs", {}) %}
{%-   if "pkgs" in telegraf.lookup.plugins.get(plugin, {}) %}
{%-     do install_pkgs.extend(telegraf.lookup.plugins[plugin].pkgs) %}
{%-   endif %}
{%- endfor %}

{%- if install_pkgs %}

Miscellaneous packages required for plugins are installed:
  pkg.installed:
    - pkgs: {{ install_pkgs | json }}
{%- else %}

# Ensure this file can be required
There are no telegraf plugins with package requisites:
  test.nop:
{%- endif %}
    - require:
      - sls: {{ sls_package_install }}
