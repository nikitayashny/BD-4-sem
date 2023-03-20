use UNIVER;

--1  На основе таблиц AUDITORIUM_ TYPE и AUDITORIUM сформировать перечень кодов 
--аудиторий и соответствующих им наименований типов аудиторий
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM_TYPE inner join AUDITORIUM
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE

---2 сформировать перечень кодов аудиторий и соответствующих им наименований типов аудиторий, 
-- выбрав только те аудитории, в наименовании которых присутствует подстрока компьютер
select AUDITORIUM.AUDITORIUM_NAME, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
from AUDITORIUM_TYPE inner join AUDITORIUM
on AUDITORIUM_TYPE.AUDITORIUM_TYPE = AUDITORIUM.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%'

--3 сформировать перечень студентов, полу-чивших экзаменационные оценки от 6 до 8. 
--Результирующий набор должен содержать столбцы: Факультет, Кафедра, Специаль-ность, 
--Дисциплина, Имя Студента, Оцен-ка. В столбце Оценка должны быть записа-ны экзаменационные оценки прописью: шесть, семь, восемь. 
--Результат отсортировать в порядке убыва-ния по столбцу PROGRESS.NOTE.
--Использовать соединение INNER JOIN, предикат BETWEEN и выражение CASE

select FACULTY.FACULTY, PULPIT.PULPIT, GROUPS.PROFESSION, SUBJECT.SUBJECT, STUDENT.NAME,
case
when (PROGRESS.NOTE = 6) then 'шесть'
when (PROGRESS.NOTE = 7) then 'семь'
when (PROGRESS.NOTE = 8) then 'восемь'
end Оценка
from STUDENT inner join PROGRESS on STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
	inner join SUBJECT on PROGRESS.SUBJECT = SUBJECT.SUBJECT
	inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PULPIT on SUBJECT.PULPIT = PULPIT.PULPIT
	inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
where PROGRESS.NOTE between 6 and 8
order by PROGRESS.NOTE desc

--4 получить полный перечень кафедр и препо-давателей на этих кафедрах. 
--Результирующий набор должен содержать два столбца: Кафедра и Преподаватель.
--Если на кафедре нет преподавателей, то в столбце Преподаватель должна быть выве-дена строка ***. 
--Примечание: использовать соединение таблиц LEFT OUTER JOIN и функцию isnull

SELECT PULPIT.PULPIT, isnull (TEACHER.TEACHER_NAME,'***')Преподаватель
FROM TEACHER right outer join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT

--5
--− запрос, результат которого содержит дан-ные левой (в операции FULL OUTER JOIN) таблицы и не содержит данные правой; 
--− запрос, результат которого содержит дан-ные правой таблицы и не содержащие данные левой; 
--− запрос, результат которого содержит дан-ные правой таблицы и левой таблиц;
--Использовать в запросах выражение IS NULL и IS NOT NULL

select TEACHER.TEACHER_NAME, PULPIT.PULPIT
from TEACHER full outer join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT
where PULPIT.PULPIT is null;

select TEACHER.TEACHER_NAME, PULPIT.PULPIT
from PULPIT full outer join TEACHER
on PULPIT.PULPIT = TEACHER.PULPIT
where TEACHER is null;

select PULPIT.PULPIT, TEACHER.TEACHER_NAME
from TEACHER full outer join PULPIT
on PULPIT.PULPIT = TEACHER.PULPIT
where TEACHER.TEACHER_NAME is not null;

--6
--Разработать SELECT-запрос на основе CROSS JOIN-соединения таблиц AUDITO-RIUM_TYPE и AUDITORIUM, 
--формиру-ющего результат, аналогичный результату запроса в задании 1
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME
From AUDITORIUM CROSS JOIN AUDITORIUM_TYPE
where AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
