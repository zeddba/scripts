#!/bin/bash
#############################################################################
#
# Shell script to enable archive log mode
#
# usage: ./<scriptname> as oracle
#
# Author : Zahid Anwar - ZedDBA - zeddba.com
# Date: 16/05/2019
# Version: 1.1
#
# History
#
# 1.0	10/10/2017	ZA	Initial Script
# 1.1	16/05/2019	ZA	Add ZEDDBA as author
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

echo -e "-----------------------------"
echo -e "Step 2: Create demo log table"
echo -e "-----------------------------"

echo -e "\nContent of 1_create_demo_table.sql file:\n"
more /media/sf_Software/scripts/demo/1_create_demo_table.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'sqlplus / as sysdba @1_create_demo_table.sql'"
$ORACLE_HOME/bin/sqlplus -s / as sysdba @1_create_demo_table.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------"
echo -e "Step 3: Enable Archive Log Mode"
echo -e "-------------------------------"

echo -e "\nContent of 1_enable_archive_log_mode.sql file:\n"
more /media/sf_Software/scripts/demo/1_enable_archive_log_mode.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'sqlplus / as sysdba @1_enable_archive_log_mode.sql'"
$ORACLE_HOME/bin/sqlplus -s / as sysdba @1_enable_archive_log_mode.sql

echo -e "\nPress Enter to exit shell script"
read var_continue
