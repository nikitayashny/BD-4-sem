use master  
create database Y_MyBase on primary
( name = N'Y_MyBase_mdf', filename = N'C:\BD\Y_MyBase_mdf.mdf', 
   size = 10240Kb, maxsize=UNLIMITED, filegrowth=1024Kb),
( name = N'Y_MyBase_ndf', filename = N'C:\BD\Y_MyBase_ndf.ndf', 
   size = 10240KB, maxsize=1Gb, filegrowth=25%),
filegroup FG1
( name = N'Y_MyBase_fg1_1', filename = N'C:\BD\Y_MyBase_fgq-11.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Y_MyBase_fg1_2', filename = N'C:\BD\Y_MyBase_fgq-21.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
   filegroup FG2
( name = N'Y_MyBase_fg12_1', filename = N'C:\BD\Y_MyBase_fgq-12.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Y_MyBase_fg12_2', filename = N'C:\BD\Y_MyBase_fgq-22.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
  filegroup FG3
( name = N'Y_MyBase_fg3_1', filename = N'C:\BD\Y_MyBase_fgq-13.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Y_MyBase_fg3_2', filename = N'C:\BD\Y_MyBase_fgq-23.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
   filegroup FG4
( name = N'Y_MyBase_fg4_1', filename = N'C:\BD\Y_MyBase_fgq-14.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Y_MyBase_fg4_2', filename = N'C:\BD\Y_MyBase_fgq-24.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
   filegroup FG5
( name = N'Y_MyBase_fg5_1', filename = N'C:\BD\Y_MyBase_fgq-15.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%),
( name = N'Y_MyBase_fg5_2', filename = N'C:\BD\Y_MyBase_fgq-25.ndf', 
   size = 10240Kb, maxsize=1Gb, filegrowth=25%)
log on
( name = N'Y_MyBase_log', filename=N'C:\BD\Y_MyBase_log.ldf',       
   size=10240Kb,  maxsize=2048Gb, filegrowth=10%)

use Y_MyBase;

CREATE table АДРЕСА
(
	id_адреса int primary key,
	Город nvarchar(50),
	Улица nvarchar(50),
	Номер_дома int,
	Квартира int
) on FG1;
CREATE table ЛЮДИ
(
	id_человека int primary key references АДРЕСА(id_адреса),
	Фамилия nvarchar(50),
	Имя nvarchar(50),
	Отчество nvarchar(50),
	Семейное_положение nvarchar(50),
	Дата_рождения date,
	Образование nvarchar(50)
) on FG2;
CREATE TABLE СОТРУДНИКИ
(
	id_сотрудника int primary key references ЛЮДИ(id_человека),
	Стаж int,
	Отдел nvarchar(50),
	Должность nvarchar(50)
) on FG3;
CREATE TABLE ОТПУСКА
(
	id_отпуска int primary key,
	Период_отпуска date,
	Вид_отпуска nvarchar(50),
	Количество_дней_отпуска int
) on FG4;
CREATE TABLE СВЯЗИ
(
	id_связи int primary key,
	id_сотрудника int foreign key references СОТРУДНИКИ(id_сотрудника),
	id_отпуска int foreign key references ОТПУСКА(id_отпуска)
) on FG5;

ALTER table СОТРУДНИКИ ADD Дата_поступления date;
ALTER table СОТРУДНИКИ DROP Column Дата_поступления;
ALTER Table СОТРУДНИКИ ADD ПОЛ nchar(1) default 'м' check (ПОЛ in ('м', 'ж')); 

INSERT into АДРЕСА (id_адреса, Город, Улица, Номер_дома, Квартира)
	values (1, 'Минск', 'Каменногорская', 6, 14),
		   (2, 'Минск', 'Каменногорская', 6, 14),
		   (3, 'Минск', 'Матусевича', 6, 83)
INSERT into ЛЮДИ (id_человека, Фамилия, Имя, Отчество, Семейное_положение, Дата_рождения, Образование)
	values (1, 'Яшный', 'Никита', 'Сергеевич', 'Не женат', '2004-10-10', 'Высшее'),
		   (2, 'Борисова', 'Арина', 'Дмитриевна', 'Не замужем', '2004-04-05', 'Высшее'),
		   (3, 'Поздняков', 'Максим', 'Игоревич', 'Не женат', '2004-11-02', 'Высшее')
INSERT into СОТРУДНИКИ (id_сотрудника, Стаж, Отдел, Должность, ПОЛ)
	values (1, 2, 'front', 'middle', 'м'),
		   (2, 1, 'front', 'junior', 'ж'),
		   (3, 2, 'back', 'middle', 'м')
INSERT into ОТПУСКА (id_отпуска, Период_отпуска, Вид_отпуска, Количество_дней_отпуска)
	values (1, '2023-07-07', 'Отдых', 30),
		   (2, '2023-07-07', 'Отдых', 31),
		   (3, '2023-06-06', 'Отдых', 25)
INSERT into СВЯЗИ (id_связи, id_сотрудника, id_отпуска)
	values (1, 1, 2),
		   (2, 2, 3),
		   (3, 3, 1)

select * from СОТРУДНИКИ
select Фамилия, имя from ЛЮДИ 
select count(*) from ЛЮДИ

UPDATE ОТПУСКА set Количество_дней_отпуска = Количество_дней_отпуска + 1 Where Вид_отпуска = 'Отдых';
select Количество_дней_отпуска from ОТПУСКА