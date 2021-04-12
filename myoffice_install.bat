chcp 1251 >nul
start \\сервер\общая_папка\картинка.jpg
if not exist \\сервер\общая_папка\office-reports\%username%-uninstall.txt (wmic product where name="МойОфис" call uninstall /nointeractive 2> \\сервер\общая_папка\office-reports\%username%-uninstall.txt)
if not exist \\сервер\общая_папка\office-reports\%username%.txt ( start \\сервер\общая_папка\myoffice\setup.msi /qn 2> \\сервер\общая_папка\office-reports\%username%.txt ) else exit