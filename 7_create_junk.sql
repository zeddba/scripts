create tablespace junk datafile size 2G;
create table junk tablespace junk as
select * from dba_objects
union all select * from dba_objects
union all select * from dba_objects
union all select * from dba_objects
union all select * from dba_objects
union all select * from dba_objects
union all select * from dba_objects;
alter table junk nologging;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
insert /*+ append */ into junk value (select * from junk);
commit;
select bytes/1024/1024 from dba_segments where owner ='SYS' and segment_name='JUNK';
exit
