chcp 1251 >nul
start \\������\�����_�����\��������.jpg
if not exist \\������\�����_�����\office-reports\%username%-uninstall.txt (wmic product where name="�������" call uninstall /nointeractive 2> \\������\�����_�����\office-reports\%username%-uninstall.txt)
if not exist \\������\�����_�����\office-reports\%username%.txt ( start \\������\�����_�����\myoffice\setup.msi /qn 2> \\������\�����_�����\office-reports\%username%.txt ) else exit