SELECT ����������.�����, ����������.���������, ����.�������, �������.������_�������, �������.���_�������, �������.����������_����_�������
FROM     ����� INNER JOIN
                  ������� ON �����.id_������� = �������.id_������� INNER JOIN
                  ���������� ON �����.id_���������� = ����������.id_���������� INNER JOIN
                  ���� ON ����������.id_���������� = ����.id_��������
WHERE  (����������.����� = N'back') AND (����������.��������� = N'middle')