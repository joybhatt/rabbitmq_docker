#!/bin/bash

awk -v id=$1 '/^rabbitmq-plugins/ {system ("sudo docker  exec "id" /usr/sbin/"$0)}' config.conf
