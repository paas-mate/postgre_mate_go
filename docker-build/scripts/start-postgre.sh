#!/bin/bash

# postgre need to init as non-root user
$POSTGRE_HOME/bin/initdb -U postgres -D $POSTGRE_DATA --no-locale --encoding=UTF8
PG_CONF=$POSTGRE_DATA/postgresql.conf
echo "listen_addresses = '*'" >$PG_CONF
echo "timezone = 'UTC'" >>$PG_CONF
echo "lc_messages = 'C'" >>$PG_CONF
echo "lc_monetary = 'C'" >>$PG_CONF
echo "lc_numeric = 'C'" >>$PG_CONF
echo "lc_time = 'C'" >>$PG_CONF
echo "log_timezone = 'UTC'" >>$PG_CONF
echo "datestyle = 'iso, mdy'" >>$PG_CONF
echo "default_text_search_config = 'pg_catalog.english'" >>$PG_CONF
echo "max_wal_size = 1GB" >>$PG_CONF
echo "min_wal_size = 80MB" >>$PG_CONF
HBA_CONF=$POSTGRE_DATA/pg_hba.conf
echo 'local   all             all                                     trust' >$HBA_CONF
echo 'host    all             all             127.0.0.1/32            trust' >>$HBA_CONF
echo "host    all             all             ::1/128                 trust" >>$HBA_CONF
echo "local   replication     all                                     trust" >>$HBA_CONF
echo "host    replication     all             127.0.0.1/32            trust" >>$HBA_CONF
echo "host    replication     all             ::1/128                 trust" >>$HBA_CONF
echo "host    replication     all             ::1/128                 trust" >>$HBA_CONF
echo "host    all             all              0.0.0.0/0              ${REMOTE_AUTH_TYPE:-trust}"   >>$HBA_CONF
echo "host    all             all              ::/0                   ${REMOTE_AUTH_TYPE:-trust}"   >>$HBA_CONF

$POSTGRE_HOME/bin/pg_ctl -D $POSTGRE_DATA start
psql -U postgres -f $POSTGRE_HOME/mate/sql/init_database.sql
