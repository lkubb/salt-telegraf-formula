# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_plugins_pkgs_installed = tplroot ~ ".plugins._pkgs.installed" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_plugins_pkgs_installed }}

{%- if (telegraf | traverse("config:inputs:smart") is mapping
    and telegraf | traverse("config:inputs:smart:use_sudo"))
    or (telegraf | traverse("config:inputs:smart", []) | selectattr("use_sudo", "defined") | selectattr("use_sudo") | list)
%}

Sudo is installed for telegraf smart plugin:
  pkg.installed:
    - name: sudo

Telegraf user can execute smartctl as root without password:
  file.managed:
    - name: {{ telegraf.lookup.sudoers | path_join("90-telegraf-smart") }}
    - source: {{ files_switch(
                    ["etc/sudoers.d/90-telegraf-smart", "etc/sudoers.d/90-telegraf-smart.j2"],
                    config=telegraf,
                    lookup="Telegraf user can execute smartctl as root without password"
                 )
              }}
    - template: jinja
    - mode: '0440'
    - user: root
    - group: {{ telegraf.lookup.rootgroup }}
    - require:
      - sls: {{ sls_plugins_pkgs_installed }}
      - pkg: sudo
    - context:
        telegraf: {{ telegraf | json }}

{%- else %}

Telegraf user cannot execute smartctl as root without password:
  file.absent:
    - name: {{ telegraf.lookup.sudoers | path_join("90-telegraf-smart") }}
{%- endif %}
