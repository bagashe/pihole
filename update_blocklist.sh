#!/bin/bash -e

# Passwordless `sudo` needs to be enabled for the user who will run this script.
# By default ...
#   * The user `pi` on Raspbian has passwordless sudo enabled.
#   * The user `ubuntu` on EC2 has passwordless sudo enabled.
# If you need to, you can enable passwordless sudo, by using the `visudo` command as follows.
# 1. `sudo visudo`
# 2. Add the following line at the end of the file - `$USER ALL=(ALL) NOPASSWD: ALL`
# 3. Save and exit. Now you have passwordless sudo for `$USER`

sudo /usr/bin/curl -# https://raw.githubusercontent.com/bagashe/pihole/master/adlists.list -O

while read list
do
  sudo sqlite3 /etc/pihole/gravity.db "insert or ignore into adlist (address, enabled) values (\"$list\", 1);"
done < ./adlists.list

/usr/local/bin/pihole -g
