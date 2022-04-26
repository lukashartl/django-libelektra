#!/bin/bash

set -ex

SPEC_PATH=$(dirname $(realpath $0))
CURRENT_PATH=/sw/django/\#0/current

sudo kdb mount "${SPEC_PATH}/django.spec.ni" spec:$CURRENT_PATH ni
kdb meta-set spec:$CURRENT_PATH mountpoint django.spec.ni

# DEBUG

kdb meta-set spec:$CURRENT_PATH/debug type boolean
kdb meta-set spec:$CURRENT_PATH/debug default 0
kdb meta-set spec:$CURRENT_PATH/debug env "DJANGO_DEBUG"
kdb meta-set spec:$CURRENT_PATH/debug description "enable django debug mode"

# ALLOWED_HOSTS

kdb meta-set spec:$CURRENT_PATH/allowed_hosts array ''
kdb meta-set spec:$CURRENT_PATH/allowed_hosts require true
kdb meta-set spec:$CURRENT_PATH/allowed_hosts description 'from where to accept requests (load balancer, ...)'
kdb meta-set spec:$CURRENT_PATH/allowed_hosts/\# type string

# INSTALLED_APPS

kdb meta-set spec:$CURRENT_PATH/apps array ''
kdb meta-set spec:$CURRENT_PATH/apps description 'apps to enable'
kdb meta-set spec:$CURRENT_PATH/apps/\# type string

# DATABASES

kdb meta-set spec:$CURRENT_PATH/databases array ''

kdb meta-set spec:$CURRENT_PATH/databases/\#/engine type enum
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine check/enum '#4'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine check/enum/\#0 'django.db.backends.postgresql'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine check/enum/\#1 'django.db.backends.mysql'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine check/enum/\#2 'django.db.backends.oracle'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine check/enum/\#3 'django.db.backends.sqlite3'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine default 'django.db.backends.sqlite3'
kdb meta-set spec:$CURRENT_PATH/databases/\#/engine description "engine to use for the db connection"

kdb meta-set spec:$CURRENT_PATH/databases/\#/name type string
kdb meta-set spec:$CURRENT_PATH/databases/\#/name require true
kdb meta-set spec:$CURRENT_PATH/databases/\#/name description "name or path for the database"

kdb meta-set spec:$CURRENT_PATH/databases/\#/user type string
kdb meta-set spec:$CURRENT_PATH/databases/\#/user description "username for the database"

kdb meta-set spec:$CURRENT_PATH/databases/\#/password type string
kdb meta-set spec:$CURRENT_PATH/databases/\#/password description "password for the database"

kdb meta-set spec:$CURRENT_PATH/databases/\#/host type string
kdb meta-set spec:$CURRENT_PATH/databases/\#/host description "hostname of the database"

kdb meta-set spec:$CURRENT_PATH/databases/\#/port type short
kdb meta-set spec:$CURRENT_PATH/databases/\#/port example 3306
kdb meta-set spec:$CURRENT_PATH/databases/\#/port description "port of the database"
kdb meta-set spec:$CURRENT_PATH/databases/\#/port check/port ''

# CSRF_TRUSTED_ORIGINS
# let's assume we want the same as in allowed_hosts (to fullfill the requirements for assignment H1)

kdb meta-set spec:$CURRENT_PATH/csrf_origins array ''
kdb meta-set spec:$CURRENT_PATH/csrf_origins/\# type string
kdb meta-set spec:$CURRENT_PATH/csrf_origins/\# fallback/\#0 "${CURRENT_PATH}/allowed_hosts/#0"

sudo kdb umount spec:$CURRENT_PATH
