#!/bin/bash
#############################################################################
#
# Shell script to take image copy
#
# usage: ./<scriptname> as oracle
#
# Author : Zahid Anwar - ZedDBA - zeddba.com
# Date: 17/05/2019
# Version: 1.1
#
# History
#
# 1.0	10/10/2017	ZA	Initial Script
# 1.1	17/05/2019	ZA	Add ZEDDBA as author
#
#############################################################################
# Set the Oracle User environment
#############################################################################

export PATH=$PATH:/usr/local/bin/

echo -e "-----------------------"
echo -e "Step 1: Set environment"
echo -e "-----------------------"

echo -e "\nSetting the Database Environment using oraenv..."
export ORAENV_ASK=NO
export ORACLE_SID=ZEDDBA
. oraenv

echo -e "\nORACLE_SID:  ${ORACLE_SID}"
echo -e "ORACLE_HOME: ${ORACLE_HOME}"

echo -e "\nPress Enter to continue"
read var_continue

echo -e "------------------------------"
echo -e "Step 2: Take Image Copy Backup"
echo -e "------------------------------"

echo -e "\nCotent of 4_image_copy.cmd file:\n"
more /media/sf_Software/scripts/demo/4_image_copy.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'rman target / cmdfile=/media/sf_Software/scripts/demo/4_image_copy.cmd'"
$ORACLE_HOME/bin/rman target / cmdfile=/media/sf_Software/scripts/demo/4_image_copy.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------------"
echo -e "Step 3: Updating and viewing demo log"
echo -e "-------------------------------------"

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "To updated and view demo log"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
insert into demo_log values (sysdate, 'Image Copy');
commit;
@/media/sf_Software/scripts/demo/demo_log.sql
EOF

echo -e "\nPress Enter to exit shell script"
read var_continue
