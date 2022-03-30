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

kdb meta-set spec:$CURRENT_PATH/databases array '#0'
kdb set user:$CURRENT_PATH/databases/\#0/name 'mydb'
test $(kdb get $CURRENT_PATH/databases/\#0/engine) == 'django.db.backends.sqlite3'

kdb set user:$CURRENT_PATH/databases/\#0/engine 'django.db.backends.oracle'
kdb set user:$CURRENT_PATH/databases/\#0/user 'toad'
kdb set user:$CURRENT_PATH/databases/\#0/password 'xyz'

err=0
kdb set user:$CURRENT_PATH/databases/\#0/engine 'not.an.engine' || err=1
test $err -ne 0

kdb meta-set user:$CURRENT_PATH/apps array '#2'
kdb set user:$CURRENT_PATH/allowed_hosts/\#0 'myapp1'
kdb set user:$CURRENT_PATH/allowed_hosts/\#1 'myapp2'
kdb set user:$CURRENT_PATH/allowed_hosts/\#2 'myapp3'

