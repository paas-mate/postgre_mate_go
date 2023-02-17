#!/bin/bash

POSTGRE_DATA=$POSTGRE_HOME/data
POSTGRE_MATE=$POSTGRE_HOME/mate
HBA_CONF=$POSTGRE_DATA/pg_hba.conf
echo 'local   all             all                                     trust' >$HBA_CONF
echo 'host    all             all             127.0.0.1/32            trust' >>$HBA_CONF
mkdir -p $POSTGRE_DATA
chown -R postgres:postgres $POSTGRE_DATA
# postgre need to init as non-root user
su postgres -c "$POSTGRE_HOME/bin/initdb -U postgres -D $POSTGRE_DATA --no-locale --encoding=UTF8"
cp $POSTGRE_MATE/conf/postgresql.conf  $POSTGRE_DATA/postgresql.conf
su postgres -c "$POSTGRE_HOME/bin/pg_ctl -D $POSTGRE_DATA start"
psql -U postgres -f $POSTGRE_MATE/sql/init_database.sql
