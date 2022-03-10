#!/bin/bash
set -euox pipefail

wait_time=30s

echo "sqlservr daemon is starting in parallel. Waiting for it to be ready for $wait_time..."
sleep $wait_time
echo "done waiting..."

/opt/mssql-tools/bin/sqlcmd -S 0.0.0.0 -U sa -P ${SA_PASSWORD} -i ./init.sql

echo "init completed"
