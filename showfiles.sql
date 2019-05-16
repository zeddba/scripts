set pages 999 lines 400
col name format a100       
pause Showing 'select name from v$controlfile;' Press Enter to continue
select name from v$controlfile;
col member format a80
pause Showing 'select GROUP#, TYPE, MEMBER, IS_RECOVERY_DEST_FILE from v$logfile;' Press Enter to continue
select GROUP#, TYPE, MEMBER, IS_RECOVERY_DEST_FILE from v$logfile;
pause Showing 'select name from v$datafile;' Press Enter to continue
select name from v$datafile;
pause Showing 'select name from v$tempfile;' Press Enter to continue
select name from v$tempfile;
pause Press Enter to exit sqlplus
exit
