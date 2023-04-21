USE UNIVER;

--1. ����������� ��������, ����������� ������ ��������� �� ������� ����.
--� ����� ������ ���� �������� ������� �������� ��������� �� ������� SUBJECT � ���� ������ ����� �������.
--������������ ���������� ������� RTRIM.
DECLARE @tv nvarchar(20), @t char(300)= '';
DECLARE Discipl CURSOR for select SUBJECT.SUBJECT FROM SUBJECT
where SUBJECT.PULPIT like '%����%';
OPEN Discipl;
FETCH Discipl into @tv;
print '������ ���������: ';
while @@FETCH_STATUS = 0
	begin
		set @t = rtrim(@tv) + ',' + @t; --������� �������� ������� �� ������
		FETCH Discipl into @tv;
	end
print @t;
CLOSE Discipl

--2. ����������� ��������, ��������������� ������� ����������� ������� �� ���������� �� ������� ���� ������ UNIVER
--local
DECLARE Audit CURSOR LOCAL
for SELECT AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM;
DECLARE @tv1 nvarchar(20), @capacity int;
OPEN Audit;
FETCH Audit into @tv1, @capacity;
print '1.' + @tv1 + cast(@capacity as nvarchar(20));
go

DECLARE @tv1 nvarchar(20), @capacity int;
fetch Audit into @tv1, @capacity;
print '2.' + @tv1 + cast(@capacity as nvarchar(20));
go

--global
DECLARE Audit CURSOR GLOBAL
for select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM;
DECLARE @tv1 nvarchar(20), @capacity int;
OPEN Audit;
FETCH Audit into @tv1,@capacity
print '1. ' + @tv1 + cast(@capacity as nvarchar(20));
go
DECLARE @tv1 nvarchar(20), @capacity int;
FETCH Audit into @tv1,@capacity;
print '2. ' + @tv1 + cast(@capacity as nvarchar(20));
close Audit;
deallocate Audit;
go

--3. ����������� ��������, ��������������� ������� ����������� �������� �� ������������ �� ������� ���� ������ UNIVER
--static
DECLARE @tid nvarchar(20), @tnm nvarchar(50), @tgn nvarchar(10);
DECLARE Audit CURSOR LOCAL STATIC
for select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_NAME,AUDITORIUM.AUDITORIUM_CAPACITY
FROM AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY = 15;
OPEN Audit;
print '���������� �����: ' + cast(@@CURSOR_ROWS as nvarchar(5));
UPDATE AUDITORIUM set AUDITORIUM_CAPACITY = 100 where AUDITORIUM = '206-1';
DELETE AUDITORIUM where AUDITORIUM = '301-1';
INSERT AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME,AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
values ('100-3', '100-3','��-�', 50);
FETCH Audit into @tid,@tnm,@tgn;
WHILE @@FETCH_STATUS = 0
begin
print @tid + '' + @tnm + ' ' + @tgn;
fetch Audit into @tid,@tnm,@tgn;
end;
CLOSE Audit;

--dynamic
DECLARE @tid nvarchar(20), @tnm nvarchar(50), @tgn nvarchar(10);
DECLARE Audit CURSOR LOCAL DYNAMIC
for select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_NAME,AUDITORIUM.AUDITORIUM_CAPACITY
FROM AUDITORIUM where AUDITORIUM.AUDITORIUM_CAPACITY = 15;
OPEN Audit;
print '���������� �����: ' + cast(@@CURSOR_ROWS as nvarchar(5));
UPDATE AUDITORIUM set AUDITORIUM_CAPACITY = 100 where AUDITORIUM = '206-1';
DELETE AUDITORIUM where AUDITORIUM = '301-1';
INSERT AUDITORIUM(AUDITORIUM, AUDITORIUM_NAME,AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
values ('300-1', '300-1','��-�', 30);
FETCH Audit into @tid,@tnm,@tgn;
WHILE @@FETCH_STATUS = 0
begin
print @tid + '' + @tnm + ' ' + @tgn;
fetch Audit into @tid,@tnm,@tgn;
end;
CLOSE Audit;

--4. ����������� ��������, ������������-��� �������� ��������� � �������������� ������ ������� � ��������� SCROLL �� ������� ���� ������ UNIVER.
--������������ ��� ��������� �������� ����� � ��������� FETCH
SELECT AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
DECLARE @tc nvarchar(20),@cp int ;
DECLARE AUDITOR cursor local dynamic scroll
for select row_number() over (order by AUDITORIUM_NAME),AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM
OPEN AUDITOR;
FETCH LAST from AUDITOR into @tc,@cp;
print '��������� ������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH first from AUDITOR into @tc,@cp;
print '������ ������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH absolute 4 from AUDITOR into @tc,@cp;
print '4 ������ �� ������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH relative 3 from AUDITOR into @tc,@cp;
print '3 ������ �� �������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH relative -5 from AUDITOR into @tc,@cp;
print '-5 ����� �� �������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH absolute -10 from AUDITOR into @tc,@cp;
print '-10 ����� �� �����: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH next from AUDITOR into @tc,@cp;
print '��������� ������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);
FETCH prior from AUDITOR into @tc,@cp;
print '���������� ������: ' + cast(@cp as nvarchar(20))+ ' ' + rtrim (@tc);

CLOSE AUDITOR;

--5. ������� ������, ��������������� ���������� ����������� CURRENT OF � ������ WHERE � �������������� ���������� UPDATE � DELETE.
DECLARE @tn nvarchar(20), @tc1 nvarchar(20), @tk int;
DECLARE AUDITOR2 cursor local dynamic
for select AUDITORIUM.AUDITORIUM,AUDITORIUM.AUDITORIUM_TYPE,AUDITORIUM.AUDITORIUM_CAPACITY FROM AUDITORIUM for update;
OPEN AUDITOR2;
fetch AUDITOR2 into @tn,@tc1,@tk;
DELETE AUDITORIUM where CURRENT OF AUDITOR2;
fetch AUDITOR2 into @tn,@tc1,@tk;
UPDATE AUDITORIUM set AUDITORIUM_CAPACITY = AUDITORIUM_CAPACITY + 5 where CURRENT OF AUDITOR2;
CLOSE AUDITOR2;

--6(1) ����������� SELECT-������, � ����-��� �������� �� ������� PROGRESS ��������� ������,
--���������� ���������� � ���������, ���������� ������ ���� 4 
--(������������ ����������� ������ PROGRESS, STUDENT, GROUPS). 
select PROGRESS.NOTE,STUDENT.NAME,GROUPS.IDGROUP FROM GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT where (PROGRESS.NOTE < 5)

DECLARE @nt int,@st nvarchar(20), @gr int;
DECLARE PROGR1 cursor local dynamic
for select PROGRESS.NOTE,STUDENT.NAME,GROUPS.IDGROUP FROM GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT where (PROGRESS.NOTE < 5) FOR UPDATE;
OPEN PROGR1;
fetch PROGR1 into @nt,@st,@gr ;
DELETE top(10) PROGRESS where CURRENT OF PROGR1;
close PROGR1

--6(2) ����������� SELECT-������, � ������� �������� � ������� PROGRESS ��� �������� 
--� ���������� ������� IDSTUDENT �������������� ������ (������������� �� �������).
select PROGRESS.NOTE,STUDENT.NAME,GROUPS.IDGROUP,STUDENT.IDSTUDENT FROM GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT where (PROGRESS.IDSTUDENT in (1067))

DECLARE @nt1 int,@st1 nvarchar(20), @gr1 int;
DECLARE PROGR1 cursor dynamic 
for select PROGRESS.NOTE,STUDENT.NAME,GROUPS.IDGROUP FROM GROUPS inner join STUDENT
on GROUPS.IDGROUP = STUDENT.IDGROUP inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT where (PROGRESS.IDSTUDENT = (1067)) FOR UPDATE;
OPEN PROGR1;
fetch PROGR1 into @nt1,@st1,@gr1 ;
UPDATE PROGRESS set NOTE = NOTE + 1 where CURRENT OF PROGR1;
close PROGR1