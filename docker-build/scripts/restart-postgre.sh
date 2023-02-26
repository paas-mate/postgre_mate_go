#!/bin/bash

POSTGRE_PID=`ps -ef | grep /usr/lib/postgresql/15/bin/postgres | grep -v grep | awk '{print $2}'`
if [ -n "$POSTGRE_PID" ]; then
    kill -9 $POSTGRE_PID
fi
$POSTGRE_HOME/bin/pg_ctl -D $POSTGRE_DATA start
