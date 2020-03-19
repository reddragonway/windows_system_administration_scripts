rem Собираем информацию о пользователе и рабочей станции. Пишем данные в файл на удаленном сервере.
@echo off
set logfile="\\сервер\общая_папка\%username%.txt"
echo === INFO USER === > %logfile%
echo Date: %date% >> %logfile%
echo Time: %time:~-11,8% >> %logfile%
echo User name: %username% >> %logfile%
echo Hostname: %computername% >> %logfile%
echo IP-address: >> %logfile%
ipconfig|find "IPv4-" >> %logfile%
ver|find "5.1" && echo OS version: Windows XP >> %logfile%
ver|find "6.1" && echo OS version: Windows 7 >> %logfile%
echo OS architecture: >> %logfile%
wmic os get OSArchitecture /value >> %logfile%
