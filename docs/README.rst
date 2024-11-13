.. _readme:

Telegraf Formula
================

|img_sr| |img_pc|

.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release
.. |img_pc| image:: https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white
   :alt: pre-commit
   :scale: 100%
   :target: https://github.com/pre-commit/pre-commit

Manage Telegraf with Salt.

.. contents:: **Table of Contents**
   :depth: 1

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltproject.io/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

If you need (non-default) configuration, please refer to:

- `how to configure the formula with map.jinja <map.jinja.rst>`_
- the ``pillar.example`` file
- the `Special notes`_ section

Special notes
-------------


Configuration
-------------
An example pillar is provided, please see `pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in `map.jinja`.


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


``telegraf.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^^
This state will install the configured telegraf repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``telegraf.plugins``
^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins._pkgs``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.fail2ban``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.http_listener_v2``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.http_listener_v2.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.influxdb_v2_listener``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.influxdb_v2_listener.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.smart``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.socket_listener``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.socket_listener.setup``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.config``
^^^^^^^^^^^^^^^^^^^
Manages the telegraf service configuration.
Has a dependency on `telegraf.package`_.


``telegraf.service``
^^^^^^^^^^^^^^^^^^^^
Starts the telegraf service and enables it at boot time.
Has a dependency on `telegraf.config`_.


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
Has a dependency on `telegraf.config.clean`_.


``telegraf.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This state will remove the configured telegraf repository.
This works for apt/dnf/yum/zypper-based distributions only by default.


``telegraf.plugins.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins._pkgs.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.fail2ban.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.plugins.smart.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



``telegraf.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^
Removes the configuration of the telegraf service and has a
dependency on `telegraf.service.clean`_.


``telegraf.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^
Stops the telegraf service and disables it at boot time.



Contributing to this repo
-------------------------

Commit messages
^^^^^^^^^^^^^^^

**Commit message formatting is significant!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``. ::

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.
