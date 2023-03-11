#!/bin/bash

DIR="$( cd "$( dirname "$0"  )" && pwd  )"
bash -x $DIR/start-postgre.sh
tail -f /dev/null
