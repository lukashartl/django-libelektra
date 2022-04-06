#!/bin/bash

set -ex

CURRENT_PATH=/sw/django/\#0/current

sudo kdb mount django.spec.ni spec:$CURRENT_PATH ni
