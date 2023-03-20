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
DECLARE @Общая_вместимость int = (SELECT sum(AUDITORIUM_CAPACITY) FROM AUDITORIUM) ,@Количество_аудиторий int,@Средняя_вместимость numeric(8,3),@Меньше_средней numeric(8,3),@Процент_аудиторий float(4)
IF @Общая_вместимость>200
begin
SELECT @Количество_аудиторий = (SELECT count(*) from AUDITORIUM),
@Средняя_вместимость = (SELECT cast(avg(AUDITORIUM_CAPACITY) as numeric(8,3)) from AUDITORIUM)
SET @Меньше_средней = (SELECT cast(COUNT (AUDITORIUM) as numeric(8,3)) FROM AUDITORIUM WHERE AUDITORIUM.AUDITORIUM_CAPACITY < @Средняя_вместимость)
SET @Процент_аудиторий = ((@Меньше_средней/@Количество_аудиторий)*100)
SELECT @Общая_вместимость [Общая вместимость],@Количество_аудиторий[Количество аудиторий],@Средняя_вместимость[Средняя вместимость],@Меньше_средней[Меньше средней],@Процент_аудиторий[Процент аудиторий]
end
else print @Общая_вместимость

----3
PRINT @@ROWCOUNT --число обработанных строк
PRINT @@VERSION --версия SQL Server'
PRINT @@SPID --возвращает системный идентификатор процесса, назначенный сервером те-кущему подключению
PRINT @@ERROR --код последней ошибки
PRINT @@SERVERNAME --имя сервера
PRINT @@TRANCOUNT --возвращает уровень вложенности транзакции
PRINT @@FETCH_STATUS --проверка результата считывания строк результирующего набора
PRINT @@NESTLEVEL --уровень вложенности текущей проце-дуры

----4(1) на 1 условие(2 и 0.1)(0,826822), на 2 условие (2 и 3)(20), на 3 условие (3 и 3)(2,718...)
DECLARE @t int = 2, @x float = 0.1, @z float
if (@t > @x)
SET @z = power(sin(@t),2)---в радианах
else if (@t < @x)
SET @z = 4 * (@t + @x)
else if (@t = @x)
SET @z = 1 - exp(@x - 2)
PRINT '@z = ' + cast(@z as nvarchar(20))

----4(2)
PRINT replace('Макейчик Татьяна Леонидовна','Татьяна Леонидовна','Т.Л.')

----4(3)
DECLARE @year date = (SELECT top 1 STUDENT.BDAY FROM STUDENT where STUDENT.BDAY like '%-04-%'),@stud nvarchar(20) = (SELECT top 1 STUDENT.NAME FROM STUDENT where STUDENT.BDAY like '%-04-%')
PRINT convert(nvarchar(20),@stud) +
',' + convert(nvarchar(20),(2023 - convert(int,substring(convert(nvarchar(20),@year),1,4))))

----4(4)
DECLARE @day date = (SELECT PROGRESS.PDATE FROM PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT where STUDENT.IDGROUP = 15)
SELECT @day[Дата],DATENAME(weekday,@day)[День недели]---может принимать 1 параметром год, день, месяц

----5
DECLARE @student int = (SELECT count(STUDENT.IDSTUDENT) FROM STUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP where GROUPS.COURSE = 1)
SELECT @student [Количество студентов]
IF(@student < 50)
begin
PRINT 'Кол-во студентов на данном курсе меньше 50'
PRINT 'Кол-во: ' + cast(@student as varchar(10))
end
ELSE
begin
PRINT 'Кол-во студентов на данном курсе больше 50'
PRINT 'Кол-во: ' + cast(@student as varchar(10))
end

----6
SELECT FACULTY.FACULTY,CASE
WHEN NOTE between 4 and 5 then '4-5'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE = 10 then '10'
END Оценка,count(*)[Количество]
FROM PROGRESS inner join STUDENT on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT inner join GROUPS on STUDENT.IDGROUP = GROUPS.IDGROUP inner join FACULTY on GROUPS.FACULTY = FACULTY.FACULTY
where FACULTY.FACULTY like '%ИДиП%'
GROUP BY FACULTY.FACULTY,CASE
WHEN NOTE between 4 and 5 then '4-5'
WHEN NOTE between 6 and 7 then '6-7'
WHEN NOTE between 8 and 9 then '8-9'
WHEN NOTE = 10 then '10'
end

----7
CREATE TABLE #products
( Артикул_товара int,
Наименование_товара nvarchar(500),
Цена int)

SET nocount on
DECLARE @str int = 0
WHILE @str < 10
begin
INSERT #products(Артикул_товара,Наименование_товара,Цена)
values (floor(500*rand()),replicate('Амортизатор',1), floor(rand()*15))
IF (@str % 10 = 0)
print @str
SET @str += 1
end

SELECT Артикул_товара,Наименование_товара, Цена FROM #products

----8
DECLARE @ret int = 10
PRINT @ret + 20
PRINT @ret + 30
RETURN---немедленное завершение
PRINT @ret + 40

----9
begin TRY
UPDATE ЗАКАЗЫ set Номер_заказа = 8
where Цена_заказанной_детали = 51
end try
begin CATCH
PRINT ERROR_NUMBER()
PRINT ERROR_MESSAGE()
PRINT ERROR_LINE()
PRINT ERROR_PROCEDURE()
PRINT ERROR_SEVERITY()
PRINT ERROR_STATE()
end catch