#!/usr/bin/env bash
docker exec -i mysql mysql -u root --password=secret bookdb < mysql/init-db.sql