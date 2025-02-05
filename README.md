# Sirius Flutter App

Sirius is a project that involves both an Odoo module and a Flutter app. The Odoo module acts as a "configurator", and the app consumes that configuration from an API, then uses that configuration to configure its UI and construct the needed XMLRPC calls to read, create, modify and delete data.
This repository contains the code for the FLutter App.

## Technical details
These are the more relevant packages:
- [get_it](https://pub.dev/packages/get_it): Service locator
- [watch_it](https://pub.dev/packages/watch_it): State management
- [odoo_repository](https://pub.dev/packages/odoo_repository) or [odoo_rpc](https://pub.dev/packages/odoo_rpc) (to be defined): Odoo communication

## Sponsorship
This project is sponsored by [Faster Empleo](https://faster.es)
