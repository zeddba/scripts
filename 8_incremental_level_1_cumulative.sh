#!/bin/bash
#############################################################################
#
# Shell script to take incremental level 1 cumulative
#
# usage: ./<scriptname> as oracle
#
# Author : Zahid Anwar - ZedDBA - zeddba.com
# Date: 29/05/2019
# Version: 1.1
#
# History
#
# 1.0	11/10/2017	ZA	Initial Script
# 1.1	29/05/2019	ZA	Add ZEDDBA as author
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

echo -e "-------------------------------------------------"
echo -e "Step 2: Take Incremental Level 1 Cumlative Backup"
echo -e "-------------------------------------------------"

echo -e "\nContent of 8_incremental_level_1_cumulative.cmd file:\n"
more /media/sf_Software/scripts/demo/8_incremental_level_1_cumulative.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'rman target / cmdfile=/media/sf_Software/scripts/demo/8_incremental_level_1_cumulative.cmd'"
$ORACLE_HOME/bin/rman target / cmdfile=/media/sf_Software/scripts/demo/8_incremental_level_1_cumulative.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "\nFiles size on disk:"
ls -ltrh /u01/app/oracle/fast_recovery_area/ZEDDBA/backupset/*

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------------"
echo -e "Step 3: Updating and viewing demo log"
echo -e "-------------------------------------"

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "To updated and view demo log"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
insert into demo_log values (sysdate, 'Incremental Level 1 Cumulative');
commit;
@/media/sf_Software/scripts/demo/demo_log.sql
EOF

echo -e "\nPress Enter to exit shell script"
read var_continue
