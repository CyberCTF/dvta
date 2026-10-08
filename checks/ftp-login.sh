#!/bin/sh
# DVTA's FTP server takes the credentials the client uses for the admin's CSV upload
# (dvta / p@ssw0rd): it lists its folder and accepts an upload, as the client's export does.
set -u
curl -sS --max-time 30 --user 'dvta:p@ssw0rd' ftp://win01/ >/dev/null 2>&1 || { echo "ftp login as dvta"; exit 1; }
printf 'id,check\n1,isoloom\n' > /tmp/isoloom-ftp-check.csv
curl -sS --max-time 30 --user 'dvta:p@ssw0rd' -T /tmp/isoloom-ftp-check.csv ftp://win01/ >/dev/null 2>&1 || { echo "ftp upload as dvta"; exit 1; }
echo "FTP accepts the client's credentials and uploads"
