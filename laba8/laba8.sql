use UNIVER

--1
create view [�������������]
as select TEACHER.TEACHER [���],
TEACHER.TEACHER_NAME [��� �������������],
TEACHER.GENDER [���],
TEACHER.PULPIT [��� �������]
from TEACHER;

SELECT * FROM [�������������]

----2
create view [���������� ������]
as select FACULTY.FACULTY_NAME [���������],
count(PULPIT.PULPIT)[���������� ������]
from FACULTY inner join PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY 
group by FACULTY_NAME

SELECT * FROM [���������� ������]

----3
create view [���������]
as select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_TYPE[������������ ���������]
FROM AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like '��%'

alter view [���������]
as select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_NAME[������������ ���������],
AUDITORIUM.AUDITORIUM_TYPE[��� ���������],
AUDITORIUM.AUDITORIUM_CAPACITY[����������� ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%'

insert into [���������] values ('101-3', '101-3','��-�', 30)

update [���������] set [���]='100-1' where [������������ ���������]='101-3'

delete from [���������] where [������������ ���������]='101-3'

SELECT * FROM [���������]

----4
create view [����������_���������]
as select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_NAME[������������ ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%' WITH CHECK OPTION

alter view [����������_���������]
as select AUDITORIUM.AUDITORIUM[���],
AUDITORIUM.AUDITORIUM_NAME[������������ ���������],
AUDITORIUM.AUDITORIUM_TYPE[��� ���������]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like '��%' WITH CHECK OPTION

--insert into [����������_���������] values ('101-3', '101-3','��-�')--�� �� check option

insert into [����������_���������] values ('101-3', '101-3','��-�')
update [����������_���������] set [���]='100-4' where [������������ ���������]='101-3'
delete from [����������_���������] where [���]='100-4'

SELECT * FROM [����������_���������]

----5
CREATE VIEW [����������]
as select top 150 SUBJECT.SUBJECT[���],
SUBJECT.SUBJECT_NAME[������������ ����������],
SUBJECT.PULPIT[��� �������]
FROM SUBJECT
ORDER BY SUBJECT.SUBJECT

SELECT * FROM [����������]

----6
alter view [���������� ������] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [���������],
count(PULPIT.PULPIT)[���������� ������]
from dbo.FACULTY inner join dbo.PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY
group by FACULTY_NAME

SELECT * FROM [���������� ������]
