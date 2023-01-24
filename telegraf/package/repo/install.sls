# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}

{%- if grains['os'] in ['Debian', 'Ubuntu'] %}

Ensure Telegraf APT repository can be managed:
  pkg.installed:
    - pkgs:
      - python3-apt                   # required by Salt
{%-   if 'Ubuntu' == grains['os'] %}
      - python-software-properties    # to better support PPA repositories
{%-   endif %}
{%- endif %}

{%- for reponame, enabled in telegraf.lookup.enablerepo.items() %}
{%-   if enabled %}

Telegraf {{ reponame }} repository is available:
  pkgrepo.managed:
{%-     for conf, val in telegraf.lookup.repos[reponame].items() %}
    - {{ conf }}: {{ val }}
{%-     endfor %}
{%-     if telegraf.lookup.pkg_manager in ['dnf', 'yum', 'zypper'] %}
    - enabled: 1
{%-     endif %}
    - require_in:
      - Telegraf is installed

{%-   else %}

Telegraf {{ reponame }} repository is disabled:
  pkgrepo.absent:
{%-     for conf in ['name', 'ppa', 'ppa_auth', 'keyid', 'keyid_ppa', 'copr'] %}
{%-       if conf in telegraf.lookup.repos[reponame] %}
    - {{ conf }}: {{ telegraf.lookup.repos[reponame][conf] }}
{%-       endif %}
{%-     endfor %}
    - require_in:
      - Telegraf is installed
{%-   endif %}
{%- endfor %}
