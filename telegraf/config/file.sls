# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- set sls_plugins_setup = tplroot ~ ".plugins.setup" %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}
{%- from tplroot ~ "/libtofsstack.jinja" import files_switch with context %}

include:
  - {{ sls_plugins_setup }}

Telegraf secrets are managed:
  file.managed:
    - name: {{ telegraf.lookup.envfile }}
    - source: {{ files_switch(
                    ["etc/default/telegraf"],
                    config=telegraf,
                    lookup="Telegraf secrets are managed",
                 )
              }}
    - template: jinja
    - mode: '0640'
    - user: root
    - group: {{ telegraf.lookup.group }}
    - require:
      - sls: {{ sls_plugins_setup }}
    - context:
        telegraf: {{ telegraf | json }}

Telegraf configuration is managed:
  file.serialize:
    - name: {{ telegraf.lookup.config }}
    - serializer: toml
    - mode: '0640'
    - user: root
    - group: {{ telegraf.lookup.group }}
    - makedirs: true
    - require:
      - sls: {{ sls_plugins_setup }}
      - file: {{ telegraf.lookup.envfile }}
    - dataset: {{ telegraf.config | json }}
