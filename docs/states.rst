Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``telegraf``
^^^^^^^^^^^^
*Meta-state*.

This installs the telegraf package,
manages the telegraf configuration file
and then starts the associated telegraf service.


``telegraf.package``
^^^^^^^^^^^^^^^^^^^^
Installs the telegraf package only.


``telegraf.package.install``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^
This state will install the configured telegraf repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``telegraf.config``
^^^^^^^^^^^^^^^^^^^
Manages the telegraf service configuration.
Has a dependency on `telegraf.package`_.


``telegraf.service``
^^^^^^^^^^^^^^^^^^^^
Starts the telegraf service and enables it at boot time.
Has a dependency on `telegraf.config`_.


``telegraf.plugins``
^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins._pkgs``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.http_listener_v2``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.http_listener_v2.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.influxdb_v2_listener``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.influxdb_v2_listener.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.smart``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.socket_listener``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.socket_listener.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.clean``
^^^^^^^^^^^^^^^^^^
*Meta-state*.

Undoes everything performed in the ``telegraf`` meta-state
in reverse order, i.e.
stops the service,
removes the configuration file and then
uninstalls the package.


``telegraf.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the telegraf package.
Has a depency on `telegraf.config.clean`_.


``telegraf.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This state will remove the configured telegraf repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``telegraf.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the telegraf service and has a
dependency on `telegraf.service.clean`_.


``telegraf.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the telegraf service and disables it at boot time.


``telegraf.plugins.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins._pkgs.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.smart.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



