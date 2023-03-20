use UNIVER

--1
create view [Преподаватель]
as select TEACHER.TEACHER [Код],
TEACHER.TEACHER_NAME [Имя преподавателя],
TEACHER.GENDER [Пол],
TEACHER.PULPIT [Код кафедры]
from TEACHER;

SELECT * FROM [Преподаватель]

----2
create view [Количество кафедр]
as select FACULTY.FACULTY_NAME [Факультет],
count(PULPIT.PULPIT)[Количество кафедр]
from FACULTY inner join PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY 
group by FACULTY_NAME

SELECT * FROM [Количество кафедр]

----3
create view [Аудитории]
as select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_TYPE[Наименование аудитории]
FROM AUDITORIUM
where AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'

alter view [Аудитории]
as select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_NAME[Наименование аудитории],
AUDITORIUM.AUDITORIUM_TYPE[Тип аудитории],
AUDITORIUM.AUDITORIUM_CAPACITY[Вместимость аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%'

insert into [Аудитории] values ('101-3', '101-3','ЛК-К', 30)

update [Аудитории] set [Код]='100-1' where [Наименование аудитории]='101-3'

delete from [Аудитории] where [Наименование аудитории]='101-3'

SELECT * FROM [Аудитории]

----4
create view [Лекционные_аудитории]
as select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_NAME[Наименование аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' WITH CHECK OPTION

alter view [Лекционные_аудитории]
as select AUDITORIUM.AUDITORIUM[Код],
AUDITORIUM.AUDITORIUM_NAME[Наименование аудитории],
AUDITORIUM.AUDITORIUM_TYPE[Тип аудитории]
FROM AUDITORIUM
WHERE AUDITORIUM.AUDITORIUM_TYPE like 'ЛК%' WITH CHECK OPTION

--insert into [Лекционные_аудитории] values ('101-3', '101-3','ЛБ-К')--не уд check option

insert into [Лекционные_аудитории] values ('101-3', '101-3','ЛК-К')
update [Лекционные_аудитории] set [Код]='100-4' where [Наименование аудитории]='101-3'
delete from [Лекционные_аудитории] where [Код]='100-4'

SELECT * FROM [Лекционные_аудитории]

----5
CREATE VIEW [Дисциплины]
as select top 150 SUBJECT.SUBJECT[Код],
SUBJECT.SUBJECT_NAME[Наименование дисциплины],
SUBJECT.PULPIT[Код кафедры]
FROM SUBJECT
ORDER BY SUBJECT.SUBJECT

SELECT * FROM [Дисциплины]

----6
alter view [Количество кафедр] WITH SCHEMABINDING
as select FACULTY.FACULTY_NAME [Факультет],
count(PULPIT.PULPIT)[Количество кафедр]
from dbo.FACULTY inner join dbo.PULPIT
on FACULTY.FACULTY=PULPIT.FACULTY
group by FACULTY_NAME

SELECT * FROM [Количество кафедр]
