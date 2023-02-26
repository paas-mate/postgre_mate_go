#!/bin/bash

POSTGRE_DATA=$POSTGRE_HOME/data
POSTGRE_MATE=$POSTGRE_HOME/mate
HBA_CONF=$POSTGRE_DATA/pg_hba.conf
mkdir -p $POSTGRE_DATA
echo 'local   all             all                                     trust' >$HBA_CONF
echo 'host    all             all             127.0.0.1/32            trust' >>$HBA_CONF
echo "host    all             all             ::1/128                 trust" >>$HBA_CONF
echo "local   replication     all                                     trust" >>$HBA_CONF
echo "host    replication     all             127.0.0.1/32            trust" >>$HBA_CONF
echo "host    replication     all             ::1/128                 trust" >>$HBA_CONF
echo "host    replication     all             ::1/128                 trust" >>$HBA_CONF
echo "host    all             all              0.0.0.0/0              ${REMOTE_AUTH_TYPE:-trust}"   >>$HBA_CONF
echo "host    all             all              ::/0                   ${REMOTE_AUTH_TYPE:-trust}"   >>$HBA_CONF
# postgre need to init as non-root user
$POSTGRE_HOME/bin/initdb -U postgres -D $POSTGRE_DATA --no-locale --encoding=UTF8
cp $POSTGRE_MATE/conf/postgresql.conf  $POSTGRE_DATA/postgresql.conf

$POSTGRE_HOME/bin/pg_ctl -D $POSTGRE_DATA start
psql -U postgres -f $POSTGRE_MATE/sql/init_database.sql
