set serveroutput on 
declare 
f utl_file.file_type;
line varchar(1000);
id customer.cid%type;
name customer.cname%type;
add customer.address%type;
credit customer.credit_rating%type;
begin
f:= utl_file.fopen('DATABASE','customer.csv','r');
if utl_file.is_open(f) then
utl_file.get_line(f,line,1000);
loop begin
utl_file.get_line(f,line,1000);
if line is null then exit;
end if;
id:= regexp_substr(line,'[^,]+',1,1);
name:= regexp_substr(line,'[^,]+',1,2);
add:= regexp_substr(line,'[^,]+',1,3);
credit:= regexp_substr(line,'[^,]+',1,4);
insert into customer values(id,name,add,credit);
commit;
exception when no_data_found then exit;
end;
end loop;
end if;
--utl_file_fclose(f);
end;

/
