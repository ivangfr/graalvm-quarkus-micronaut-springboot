#!/usr/bin/env bash

docker exec -i mysql mysql -uroot -psecret bookdb < mysql/init-db.sql
