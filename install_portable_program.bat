@echo off
rem ������ ��������� ����� ������������ ���������
chcp 1251 >nul
rem ��������� ���������� � ���������� ��� ����������� (� ����� ������ �� ������� ����� �)
set old_dir="M:\Programs\ExampleProgramPortable"
rem ��������� ���������� ���� ���������� ��������� (� ����� ������ � ������ ����� �)
set new_dir="C:\ExampleProgramPortable"
rem ���� ���������� ��� ���������� ����� ������ � ��� (����, �����, ���� ���������� ������ ������������), � ��������� ������ �������� ��������� � ���������� new_dir
rem �������� ����� ��������� � ����� ����� ��� ���� �������������, ����� ������� �� ������� ����
rem ��������������� ����� ���������� (���� �����)
rem ������ ������ � ���
If Exist "%new_dir%\*.*" (
echo %date% %time:~-11,8% DIR exist already >> M:\logs\%username%.txt
) Else (
xcopy %old_dir% %new_dir% /i /e /h /y
xcopy "C:\ExampleProgramPortable\example_program.lnk" C:\Users\Public\Desktop
rename "C:\Users\Public\Desktop\example_program.lnk" ���������.lnk
echo %date% %time:~-11,8% Example Program install successful >> M:\logs\%username%.txt
)
