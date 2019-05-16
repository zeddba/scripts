#!/bin/bash
#############################################################################
#
# Shell script to create database ZEDDBA
#
# usage: ./<scriptname> as oracle
#
# Created: Zahid Anwar
# Date: 08/10/2017
# Version: 1.0
#
# History
#
# 1.0	08/10/2017	ZA	Initial Script
# 1.1	10/10/2017	ZA	Add datapatch
#
#############################################################################
# Set the Oracle User environment
#############################################################################

export PATH=$PATH:/usr/local/bin/

echo -e "------------------------------"
echo -e "Step 1: Add Database to oratab"
echo -e "------------------------------"

echo -e "\nPress Enter to continue"
read var_continue

echo -e "adding ZEDDBA to oratab..."
echo "ZEDDBA:/u01/app/oracle/product/12.2.0/dbhome_1:N" >> /etc/oratab

echo -e "\nDatabases in oratab:"
more /etc/oratab | grep -v '#' | grep -v "^[[:space:]]*$"

echo -e "\nSetting the Database Environment using oraenv..."
export ORAENV_ASK=NO
export ORACLE_SID=ZEDDBA
. oraenv

echo -e "\nORACLE_SID:  ${ORACLE_SID}"
echo -e "ORACLE_HOME: ${ORACLE_HOME}"

echo -e "\nPress Enter to continue"
read var_continue

echo -e "--------------------"
echo -e "Step 2: Create pfile"
echo -e "--------------------"

echo -e "\nPress Enter to continue"
read var_continue

cp -p /media/sf_Software/scripts/initZEDDBA.ora $ORACLE_HOME/dbs
chmod 644 $ORACLE_HOME/dbs/initZEDDBA.ora
chown oracle:oinstall $ORACLE_HOME/dbs/initZEDDBA.ora

echo -e "Content of pfile just created:\n"

more $ORACLE_HOME/dbs/initZEDDBA.ora

echo -e "\nPress Enter to continue"
read var_continue

echo -e "--------------------------------"
echo -e "Step 3: Create spfile from pfile"
echo -e "--------------------------------"

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "And running 'create spfile from pfile;'"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
create spfile from pfile;
EOF

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------------"
echo -e "Step 4: Start the instance in nomount"
echo -e "-------------------------------------"

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "And running 'startup nomount;'\n"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
startup nomount;
EOF

echo -e "\nPress Enter to continue"
read var_continue

echo -e "-------------------------------------------------------"
echo -e "Step 5: Create database using create database statement"
echo -e "-------------------------------------------------------"

echo -e "\nPress Enter to continue"
read var_continue

cp -p /media/sf_Software/scripts/createZEDDBA.sql $ORACLE_HOME/dbs
chmod 644 $ORACLE_HOME/dbs/createZEDDBA.sql
chown oracle:oinstall $ORACLE_HOME/dbs/createZEDDBA.sql

echo -e "Content of createZEDDBA.sql just created:\n"

more $ORACLE_HOME/dbs/createZEDDBA.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "And running '@?/dbs/createZEDDBA.sql'\n"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
@?/dbs/createZEDDBA.sql
EOF

echo -e "\nPress Enter to continue"
read var_continue

echo -e "----------------------------"
echo -e "Step 6: Show database layout"
echo -e "----------------------------"

echo -e "\nPress Enter to continue"
read var_continue

cp -p /media/sf_Software/scripts/showfiles.sql $ORACLE_HOME/dbs
chmod 644 $ORACLE_HOME/dbs/showfiles.sql
chown oracle:oinstall $ORACLE_HOME/dbs/showfiles.sql

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "And running '@?/dbs/showfiles.sql'\n"
$ORACLE_HOME/bin/sqlplus -s / as sysdba @?/dbs/showfiles.sql

echo -e "\nPress Enter to continue"
read var_continue

echo -e "----------------------------------------------------"
echo -e "Step 7: run catalog.sql, catproc.sql, datapatch, etc"
echo -e "----------------------------------------------------"

echo -e "\nPress Enter to continue"
read var_continue

cp -p /media/sf_Software/scripts/catalog_catproc.sql $ORACLE_HOME/dbs
chmod 644 $ORACLE_HOME/dbs/catalog_catproc.sql
chown oracle:oinstall $ORACLE_HOME/dbs/catalog_catproc.sql

starttime=`date +"%d-%m-%Y_%H_%M"`

echo -e "Calling 'sqlplus / as sysdba'"
echo -e "And running '@?/dbs/catalog_catproc.sql'\n"
$ORACLE_HOME/bin/sqlplus -s / as sysdba <<EOF
@?/dbs/catalog_catproc.sql
EOF

$ORACLE_HOME/OPatch/datapatch -verbose

endtime=`date +"%d-%m-%Y_%H_%M"`

echo -e "Start Time: ${starttime}"
echo -e "En Time:    ${endtime}"

echo -e "\nPress Enter to exit shell script"
read var_continue
