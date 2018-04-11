#!/bin/bash

systemctl enable postgresql
systemctl start postgresql

sudo -u postgres psql postgres -c "alter user postgres with password 'postpass'"

/root/start-agent.sh "$@"
