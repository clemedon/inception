#!/bin/sh

set -euo pipefail

# Enable openrc
openrc && touch /run/openrc/softlevel

# Initialize MariaDB
/tmp/init-db.sh

# Start MariaDB
mysqld_safe --datadir='/var/lib/mysql'
