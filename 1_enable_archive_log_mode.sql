alter system set db_recovery_file_dest_size = 15G;
shutdown immediate;
startup mount;
alter database archivelog;
alter database open;
insert into demo_log values (sysdate, 'Enable Archive Log Mode');
commit;
@/media/sf_Software/scripts/demo/demo_log.sql
exit
