#!/usr/bin/env bash

set -e

BUILDER="${BUILDER:-podman}"

$BUILDER exec -i mysql mysql -uroot -psecret < mysql/reset-tables.sql
