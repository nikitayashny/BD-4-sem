use UNIVER;

----1(1)
exec SP_HELPINDEX 'AUDITORIUM'--� ������� �����, ����� �����., � ����� ���
exec SP_HELPINDEX 'AUDITORIUM_TYPE'
exec SP_HELPINDEX 'FACULTY'
exec SP_HELPINDEX 'PULPIT'
exec SP_HELPINDEX 'PROFESSION'
exec SP_HELPINDEX 'TEACHER'
exec SP_HELPINDEX 'SUBJECT'
exec SP_HELPINDEX 'GROUPS'
exec SP_HELPINDEX 'STUDENT'
exec SP_HELPINDEX 'PROGRESS'

----1(2)
CREATE TABLE #products
( �������_������ int,
������������_������ nvarchar(500),
���� int)

SET nocount on
DECLARE @str int = 0
WHILE @str < 1000
begin
INSERT #products(�������_������,������������_������,����)
values (floor(500*rand()),replicate('�����������',1), floor(rand()*15))
IF (@str % 100 = 0)
print @str
SET @str += 1
end
SELECT * FROM #products
SELECT * FROM #products where �������_������ between 100 and 400 order by �������_������

checkpoint; --�������� ��
DBCC DROPCLEANBUFFERS;

CREATE clustered index #products_cl on #products(�������_������ asc)

--2
CREATE TABLE #orders
( �������_����������_������ int,
���������� nvarchar(500),
����_����������_������ int)

SET nocount on
DECLARE @str1 int = 0
WHILE @str1 < 10000
begin
INSERT #orders(�������_����������_������,����������,����_����������_������)
values (floor(500*rand()),replicate('��������',1), floor(rand()*15))
IF (@str1 % 1000 = 0)
print @str1
SET @str1 += 1
end
SELECT * FROM #orders order by �������_����������_������,����_����������_������
SELECT * FROM #orders where �������_����������_������ < 100 and ����_����������_������ < 10
checkpoint; --�������� ��
DBCC DROPCLEANBUFFERS;
CREATE index #order on #orders(�������_����������_������, ����_����������_������)

----3
CREATE TABLE #job
( ��������_��������� nvarchar(500),
����� nvarchar(500),
����_��������� int)
SET nocount on
DECLARE @str2 int = 0
WHILE @str2 < 10000
begin
INSERT #job(��������_���������,�����,����_���������)
values (replicate('�������',1),replicate('�����������',1), floor(rand()*5))
IF (@str2 % 1000 = 0)
print @str2
SET @str2 += 1
end

SELECT * FROM #job
SELECT * FROM #job where ����_��������� > 3
checkpoint; --�������� ��
DBCC DROPCLEANBUFFERS;
CREATE index #job on #job(����_���������) INCLUDE (��������_���������)

----4
CREATE TABLE #requisites
( �����_��������� int,
������� nvarchar(500),
Email nvarchar(500),
VK nvarchar(500))

set nocount on
DECLARE @str3 int = 0
WHILE @str3 < 10000
begin
INSERT #requisites(�����_���������,�������,Email,VK)
values (floor(rand()*7595),replicate('+375295684775',1),replicate('duvhas@mail.ru',1), replicate('����� ������',1) )
IF(@str3 % 1000 = 0)
print @str3
SET @str3 +=1
end
SELECT * FROM #requisites where �����_��������� between 100 and 1000
SELECT * FROM #requisites where �����_��������� > 200 and �����_���������<2000
SELECT * FROM #requisites where �����_��������� = 944

CREATE index #requisites on #requisites(�����_���������) where �����_��������� > 200 and �����_��������� < 2000


----5--------------�
DROP TABLE #requisites

CREATE TABLE #requisites
( �����_��������� int,
������� nvarchar(500),
Email nvarchar(500),
VK nvarchar(500))

set nocount on
DECLARE @str4 int = 0
WHILE @str4 < 10000
begin
INSERT #requisites(�����_���������,�������,Email,VK)
values (floor(rand()*7595),replicate('+375295684775',1),replicate('duvhas@mail.ru',1), replicate('����� ������',1) )
IF(@str4 % 1000 = 0)
print @str4
SET @str4 +=1
end

SELECT * FROM #requisites

CREATE
index #requisites_N on #requisites(�����_���������)
insert top(10000) #requisites(�����_���������,�������,Email,VK) select �����_���������,�������,Email,VK from #requisites

SELECT name[������], avg_fragmentation_in_percent [������������ (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID(N'dbo.#requisites'), NULL,NULL,NULL) ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id WHERE name is not null


Alter index #requisites_N on #requisites reorganize


Alter index #requisites_N on #requisites rebuild with (online = off)

---6
Drop index #requisites_N on #requisites

Create index #requisites_Na on #requisites(�����_���������) with (fillfactor = 65)
Insert top(50)percent INTO #requisites(�����_���������,�������,Email,VK)
SELECT �����_���������,�������,Email,VK FROM #requisites

SELECT name[������], avg_fragmentation_in_percent[������������(%)]
From sys.dm_db_index_physical_stats(DB_ID(N'#requisites'),
OBJECT_ID(N'#requisites_Na'),NULL,NULL,NULL) ss JOIN sys.indexes ii
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id
WHERE name is not null