@echo off
rem меняем кодировку чтобы использовать кириллицу
chcp 1251 >nul
rem указываем директорию с программой для копирования (в нашем случае на сетевом диске М)
set old_dir="M:\Programs\ExampleProgramPortable"
rem указываем директорию куда копировать программу (в нашем случае в корень диска С)
set new_dir="C:\ExampleProgramPortable"
rem если директория уже существует пишем запись в лог (дата, время, файл называется именем пользователя), в противном случае копируем программу в директорию new_dir
rem копируем ярлык программы в общую папку для всех пользователей, чтобы вывести на рабочий стол
rem переименовываем ярлык кириллицей (если нужно)
rem делаем запись в лог
If Exist "%new_dir%\*.*" (
echo %date% %time:~-11,8% DIR exist already >> M:\logs\%username%.txt
) Else (
xcopy %old_dir% %new_dir% /i /e /h /y
xcopy "C:\ExampleProgramPortable\example_program.lnk" C:\Users\Public\Desktop
rename "C:\Users\Public\Desktop\example_program.lnk" Программа.lnk
echo %date% %time:~-11,8% Example Program install successful >> M:\logs\%username%.txt
)
