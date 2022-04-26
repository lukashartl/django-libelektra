#!/bin/bash

set -ex

CURRENT_PATH=/sw/django/\#0/current

sudo kdb mount `pwd`/django.spec.ni spec:$CURRENT_PATH ni
sudo kdb spec-mount $CURRENT_PATH ni

kdb set user:$CURRENT_PATH/debug 1
test $(kdb get user:$CURRENT_PATH/debug) == 1

kdb meta-set user:$CURRENT_PATH/allowed_hosts array '#0'
kdb set user:$CURRENT_PATH/allowed_hosts/\#0 'localhost'

kdb meta-set user:$CURRENT_PATH/csrf_origins array '#0'
test $(kdb get $CURRENT_PATH/csrf_origins/\#0) == 'localhost'

kdb meta-set user:$CURRENT_PATH/databases array '#0'
kdb set user:$CURRENT_PATH/databases/\#0 'default'
test $(kdb get $CURRENT_PATH/databases/\#0/engine) == 'django.db.backends.sqlite3'

kdb set user:$CURRENT_PATH/databases/\#0/engine 'django.db.backends.sqlite3'
kdb set user:$CURRENT_PATH/databases/\#0/name 'my_cool_db.sqlite3'
kdb set user:$CURRENT_PATH/databases/\#0/user ''
kdb set user:$CURRENT_PATH/databases/\#0/password ''
kdb set user:$CURRENT_PATH/databases/\#0/port 0

err=0
kdb set user:$CURRENT_PATH/databases/\#0/engine 'not.an.engine' || err=1
test $err -ne 0

kdb meta-set user:$CURRENT_PATH/apps array '#5'
kdb set user:$CURRENT_PATH/apps/\#0 'django.contrib.admin'
kdb set user:$CURRENT_PATH/apps/\#1 'django.contrib.auth'
kdb set user:$CURRENT_PATH/apps/\#2 'django.contrib.contenttypes'
kdb set user:$CURRENT_PATH/apps/\#3 'django.contrib.sessions'
kdb set user:$CURRENT_PATH/apps/\#4 'django.contrib.messages'
kdb set user:$CURRENT_PATH/apps/\#5 'django.contrib.staticfiles'
