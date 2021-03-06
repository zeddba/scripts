#!/bin/bash
#############################################################################
#
# Shell script to take incremental level 1 with block change tracking
#
# usage: ./<scriptname> as oracle
#
# Author : Zahid Anwar - ZedDBA - zeddba.com
# Date: 22/05/2019
# Version: 1.1
#
# History
#
# 1.0	10/10/2017	ZA	Initial Script
# 1.1	22/05/2019	ZA	Add ZEDDBA as author
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

echo -e "-----------------------------------------------------------"
echo -e "Step 2: Take Incremental Level 1 with Block Change Tracking"
echo -e "-----------------------------------------------------------"

echo -e "\nClearing all backups..."
$ORACLE_HOME/bin/rman target / cmdfile=/media/sf_Software/scripts/demo/delete_all_backups.cmd > /dev/null 2>&1

echo -e "\nCreating junk!"
$ORACLE_HOME/bin/sqlplus -s / as sysdba @/media/sf_Software/scripts/demo/7_create_junk.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "\nContent of 7_incremental_level_1_with_BCT.cmd file:\n"
more /media/sf_Software/scripts/demo/7_incremental_level_1_with_BCT.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'rman target / cmdfile=/media/sf_Software/scripts/demo/7_incremental_level_1_with_BCT.cmd'"
$ORACLE_HOME/bin/rman target / cmdfile=/media/sf_Software/scripts/demo/7_incremental_level_1_with_BCT.cmd

echo -e "\nPress Enter to continue"
read var_continue

echo -e "\nFiles size on disk:"
ls -ltrh /u01/app/oracle/fast_recovery_area/ZEDDBA/backupset/*

echo -e "\nPress Enter to continue"
read var_continue

echo -e "\nDropping junk!"
$ORACLE_HOME/bin/sqlplus -s / as sysdba @/media/sf_Software/scripts/demo/7_drop_junk.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------------"
echo -e "Step 3: Updating and viewing demo log"
echo -e "-------------------------------------"

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "To updated and view demo log"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
insert into demo_log values (sysdate, 'Incremental Level 1 with BCT');
commit;
@/media/sf_Software/scripts/demo/demo_log.sql
EOF

echo -e "\nPress Enter to exit shell script"
read var_continue
