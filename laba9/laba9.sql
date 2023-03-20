use UNIVER

----1
DECLARE @ch char(5)='HELLO',
@vch varchar(5)= 'WORLD',
@dt datetime,
@time time,
@i int,
@si smallint,
@ti tinyint,
@nmrc numeric(12,5)
SET @dt = getdate()
SET @time = '04:26:08.447'

SELECT @i = 1, @si = -2,@nmrc = 1458796.12547
SELECT @ch ch,@vch vch,@dt dt,@time t
PRINT @i
PRINT @si
PRINT @ti
PRINT @nmrc

----2
DECLARE @�����_����������� int = (SELECT sum(AUDITORIUM_CAPACITY) FROM AUDITORIUM) ,@����������_��������� int,@�������_����������� numeric(8,3),@������_������� numeric(8,3),@�������_��������� float(4)
IF @�����_�����������>200
begin
SELECT @����������_��������� = (SELECT count(*) from AUDITORIUM),
@�������_����������� = (SELECT cast(avg(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM)
SET @������_������� = (SELECT cast(COUNT (AUDITORIUM) as numeric(8,3)) FROM AUDITORIUM WHERE AUDITORIUM.AUDITORIUM_CAPACITY < @�������_�����������)
SET @�������_��������� = ((@������_�������/@����������_���������)*100)
SELECT @�����_����������� [����� �����������],@����������_���������[���������� ���������],@�������_�����������[������� �����������],@������_�������[������ �������],@�������_���������[������� ���������]
end
else print @�����_�����������

----3
PRINT @@ROWCOUNT --����� ������������ �����
PRINT @@VERSION --������ SQL Server'
PRINT @@SPID --���������� ��������� ������������� ��������, ����������� �������� ��-������ �����������
PRINT @@ERROR --��� ��������� ������
PRINT @@SERVERNAME --��� �������
PRINT @@TRANCOUNT --���������� ������� ����������� ����������
PRINT @@FETCH_STATUS --�������� ���������� ���������� ����� ��������������� ������
PRINT @@NESTLEVEL --������� ����������� ������� �����-����

----4(1) �� 1 �������(2 � 0.1)(0,826822), �� 2 ������� (2 � 3)(20), �� 3 ������� (3 � 3)(2,718...)
DECLARE @t int = 2, @x float = 0.1, @z float
if (@t > @x)
SET @z = power(sin(@t),2)---� ��������
else if (@t < @x)
SET @z = 4 * (@t + @x)
else if (@t = @x)
SET @z = 1 - exp(@x - 2)
PRINT '@z = ' + cast(@z as nvarchar(20))

----4(2)
PRINT replace('�������� ������� ����������','������� ����������','�.�.')

----4(3)
DECLARE @year date = (SELECT top 1 STUDENT.BDAY FROM STUDENT where STUDENT.BDAY like '%-04-%'),@stud nvarchar(20) = (SELECT top 1 STUDENT.NAME FROM STUDENT where STUDENT.BDAY like '%-04-%')
PRINT convert(nvarchar(20),@stud) +
',' + convert(nvarchar(20),(2023 - convert(int,substring(convert(nvarchar(20),@year),1,4))))

----4(4)
DECLARE @day date = (SELECT PROGRESS.PDATE FROM PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT where STUDENT.IDGROUP = 15)
SELECT @day[����],DATENAME(weekday,@day)[���� ������]---����� ��������� 1 ���������� ���, ����, �����

----5
DECLARE @student int = (SELECT count(STUDENT.IDSTUDENT) FROM STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP where GROUPS.COURSE = 1)
SELECT @student [���������� ���������]
IF(@student < 50)
begin
PRINT '���-�� ��������� �� ������ ����� ������ 50'
PRINT '���-��: ' + cast(@student as varchar(10))
end
ELSE
begin
PRINT '���-�� ��������� �� ������ ����� ������ 50'
PRINT '���-��: ' + cast(@student as varchar(10))
end

----6
SELECT FACULTY.FACULTY,CASE
WHEN NOTE between 4 and 5 then '4-5'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE = 10 then '10'
END ������,count(*)[����������]
FROM PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY like '%����%'
GROUP BY FACULTY.FACULTY,CASE
WHEN NOTE between 4 and 5 then '4-5'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE = 10 then '10'
end

----7
CREATE TABLE #products
( �������_������ int,
������������_������ nvarchar(500),
���� int)

SET nocount on
DECLARE @str int = 0
WHILE @str < 10
begin
INSERT #products(�������_������,������������_������,����)
values (floor(500*rand()),replicate('�����������',1), floor(rand()*15))
IF (@str % 10 = 0)
print @str
SET @str += 1
end

SELECT �������_������,������������_������, ���� FROM #products

----8
DECLARE @ret int = 10
PRINT @ret + 20
PRINT @ret + 30
RETURN---����������� ����������
PRINT @ret + 40

----9
begin TRY
UPDATE ������ set �����_������ = 8
where ����_����������_������ = 51
end try
begin CATCH
PRINT ERROR_NUMBER()
PRINT ERROR_MESSAGE()
PRINT ERROR_LINE()
PRINT ERROR_PROCEDURE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
end catch