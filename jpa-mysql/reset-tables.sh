#!/usr/bin/env bash

docker exec -i mysql mysql -uroot -psecret < mysql/reset-tables.sql
