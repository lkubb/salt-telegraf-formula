# vim: ft=sls

{#-
    *Meta-state*.

    This installs the telegraf package,
    manages the telegraf configuration file
    and then starts the associated telegraf service.
#}

include:
  - .package
  - .plugins
  - .config
  - .service
