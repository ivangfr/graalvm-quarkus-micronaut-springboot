#!/usr/bin/env bash

podman exec -i mysql mysql -uroot -psecret < mysql/reset-tables.sql
