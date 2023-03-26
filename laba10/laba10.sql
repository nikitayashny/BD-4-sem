use UNIVER;

----1(1)
exec SP_HELPINDEX 'AUDITORIUM'--в запросе видно, какой класт., а какой нет
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
( Артикул_товара int,
Наименование_товара nvarchar(500),
Цена int)

SET nocount on
DECLARE @str int = 0
WHILE @str < 1000
begin
INSERT #products(Артикул_товара,Наименование_товара,Цена)
values (floor(500*rand()),replicate('Амортизатор',1), floor(rand()*15))
IF (@str % 100 = 0)
print @str
SET @str += 1
end
SELECT * FROM #products
SELECT * FROM #products where Артикул_товара between 100 and 400 order by Артикул_товара

checkpoint; --фиксация БД
DBCC DROPCLEANBUFFERS;

CREATE clustered index #products_cl on #products(Артикул_товара asc)

--2
CREATE TABLE #orders
( Артикул_заказанной_детали int,
Примечание nvarchar(500),
Цена_заказанной_детали int)

SET nocount on
DECLARE @str1 int = 0
WHILE @str1 < 10000
begin
INSERT #orders(Артикул_заказанной_детали,Примечание,Цена_заказанной_детали)
values (floor(500*rand()),replicate('Мерседес',1), floor(rand()*15))
IF (@str1 % 1000 = 0)
print @str1
SET @str1 += 1
end
SELECT * FROM #orders order by Артикул_заказанной_детали,Цена_заказанной_детали
SELECT * FROM #orders where Артикул_заказанной_детали < 100 and Цена_заказанной_детали < 10
checkpoint; --фиксация БД
DBCC DROPCLEANBUFFERS;
CREATE index #order on #orders(Артикул_заказанной_детали, Цена_заказанной_детали)

----3
CREATE TABLE #job
( Название_должности nvarchar(500),
Отдел nvarchar(500),
Срок_контракта int)
SET nocount on
DECLARE @str2 int = 0
WHILE @str2 < 10000
begin
INSERT #job(Название_должности,Отдел,Срок_контракта)
values (replicate('Учитель',1),replicate('Образование',1), floor(rand()*5))
IF (@str2 % 1000 = 0)
print @str2
SET @str2 += 1
end

SELECT * FROM #job
SELECT * FROM #job where Срок_контракта > 3
checkpoint; --фиксация БД
DBCC DROPCLEANBUFFERS;
CREATE index #job on #job(Срок_контракта) INCLUDE (Название_должности)

----4
CREATE TABLE #requisites
( Номер_реквизита int,
Телефон nvarchar(500),
Email nvarchar(500),
VK nvarchar(500))

set nocount on
DECLARE @str3 int = 0
WHILE @str3 < 10000
begin
INSERT #requisites(Номер_реквизита,Телефон,Email,VK)
values (floor(rand()*7595),replicate('+375295684775',1),replicate('duvhas@mail.ru',1), replicate('Вадим Лавров',1) )
IF(@str3 % 1000 = 0)
print @str3
SET @str3 +=1
end
SELECT * FROM #requisites where Номер_реквизита between 100 and 1000
SELECT * FROM #requisites where Номер_реквизита > 200 and Номер_реквизита<2000
SELECT * FROM #requisites where Номер_реквизита = 944

CREATE index #requisites on #requisites(Номер_реквизита) where Номер_реквизита > 200 and Номер_реквизита < 2000


----5--------------—
DROP TABLE #requisites

CREATE TABLE #requisites
( Номер_реквизита int,
Телефон nvarchar(500),
Email nvarchar(500),
VK nvarchar(500))

set nocount on
DECLARE @str4 int = 0
WHILE @str4 < 10000
begin
INSERT #requisites(Номер_реквизита,Телефон,Email,VK)
values (floor(rand()*7595),replicate('+375295684775',1),replicate('duvhas@mail.ru',1), replicate('Вадим Лавров',1) )
IF(@str4 % 1000 = 0)
print @str4
SET @str4 +=1
end

SELECT * FROM #requisites

CREATE
index #requisites_N on #requisites(Номер_реквизита)
insert top(10000) #requisites(Номер_реквизита,Телефон,Email,VK) select Номер_реквизита,Телефон,Email,VK from #requisites

SELECT name[Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(),
OBJECT_ID(N'dbo.#requisites'), NULL,NULL,NULL) ss
JOIN sys.indexes ii on ss.object_id = ii.object_id and ss.index_id = ii.index_id WHERE name is not null


Alter index #requisites_N on #requisites reorganize


Alter index #requisites_N on #requisites rebuild with (online = off)

---6
Drop index #requisites_N on #requisites

Create index #requisites_Na on #requisites(Номер_реквизита) with (fillfactor = 65)
Insert top(50)percent INTO #requisites(Номер_реквизита,Телефон,Email,VK)
SELECT Номер_реквизита,Телефон,Email,VK FROM #requisites

SELECT name[Индекс], avg_fragmentation_in_percent[Фрагментация(%)]
From sys.dm_db_index_physical_stats(DB_ID(N'#requisites'),
OBJECT_ID(N'#requisites_Na'),NULL,NULL,NULL) ss JOIN sys.indexes ii
ON ss.object_id = ii.object_id and ss.index_id = ii.index_id
WHERE name is not null