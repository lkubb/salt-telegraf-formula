# vim: ft=sls

{#-
    Starts the telegraf service and enables it at boot time.
    Has a dependency on `telegraf.config`_.
#}

include:
  - .running
