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

CREATE table ������
(
	id_������ int primary key,
	����� nvarchar(50),
	����� nvarchar(50),
	�����_���� int,
	�������� int
) on FG1;
CREATE table ����
(
	id_�������� int primary key references ������(id_������),
	������� nvarchar(50),
	��� nvarchar(50),
	�������� nvarchar(50),
	��������_��������� nvarchar(50),
	����_�������� date,
	����������� nvarchar(50)
) on FG2;
CREATE TABLE ����������
(
	id_���������� int primary key references ����(id_��������),
	���� int,
	����� nvarchar(50),
	��������� nvarchar(50)
) on FG3;
CREATE TABLE �������
(
	id_������� int primary key,
	������_������� date,
	���_������� nvarchar(50),
	����������_����_������� int
) on FG4;
CREATE TABLE �����
(
	id_����� int primary key,
	id_���������� int foreign key references ����������(id_����������),
	id_������� int foreign key references �������(id_�������)
) on FG5;

ALTER table ���������� ADD ����_����������� date;
ALTER table ���������� DROP Column ����_�����������;
ALTER Table ���������� ADD ��� nchar(1) default '�' check (��� in ('�', '�')); 

INSERT into ������ (id_������, �����, �����, �����_����, ��������)
	values (1, '�����', '��������������', 6, 14),
		   (2, '�����', '��������������', 6, 14),
		   (3, '�����', '����������', 6, 83)
INSERT into ���� (id_��������, �������, ���, ��������, ��������_���������, ����_��������, �����������)
	values (1, '�����', '������', '���������', '�� �����', '2004-10-10', '������'),
		   (2, '��������', '�����', '����������', '�� �������', '2004-04-05', '������'),
		   (3, '���������', '������', '��������', '�� �����', '2004-11-02', '������')
INSERT into ���������� (id_����������, ����, �����, ���������, ���)
	values (1, 2, 'front', 'middle', '�'),
		   (2, 1, 'front', 'junior', '�'),
		   (3, 2, 'back', 'middle', '�')
INSERT into ������� (id_�������, ������_�������, ���_�������, ����������_����_�������)
	values (1, '2023-07-07', '�����', 30),
		   (2, '2023-07-07', '�����', 31),
		   (3, '2023-06-06', '�����', 25)
INSERT into ����� (id_�����, id_����������, id_�������)
	values (1, 1, 2),
		   (2, 2, 3),
		   (3, 3, 1)

select * from ����������
select �������, ��� from ���� 
select count(*) from ����

UPDATE ������� set ����������_����_������� = ����������_����_������� + 1 Where ���_������� = '�����';
select ����������_����_������� from �������