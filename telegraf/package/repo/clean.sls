# vim: ft=sls

{#-
    This state will remove the configured telegraf repository.
    This works for apt/dnf/yum/zypper-based distributions only by default.
#}

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as telegraf with context %}


{%- if telegraf.lookup.pkg_manager not in ["apt", "dnf", "yum", "zypper"] %}
{%-   if salt["state.sls_exists"](slsdotpath ~ "." ~ telegraf.lookup.pkg_manager ~ ".clean") %}

include:
  - {{ slsdotpath ~ "." ~ telegraf.lookup.pkg_manager ~ ".clean" }}
{%-   endif %}

{%- else %}
{%-   for reponame, enabled in telegraf.lookup.enablerepo.items() %}
{%-     if enabled %}

Telegraf {{ reponame }} repository is absent:
  pkgrepo.absent:
{%-       for conf in ["name", "ppa", "ppa_auth", "keyid", "keyid_ppa", "copr"] %}
{%-         if conf in telegraf.lookup.repos[reponame] %}
    - {{ conf }}: {{ telegraf.lookup.repos[reponame][conf] }}
{%-         endif %}
{%-       endfor %}
{%-     endif %}
{%-   endfor %}
{%- endif %}
