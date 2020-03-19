@ echo off
rem проверяем есть ли пользователь "root" на компьютере
net user root toor 2>nul
rem если нет, создаем пользователя "root" с паролем "toor", добавляем в группу "Администраторы", ставим галочку "Пароль никогда не истекает", пишем лог.  
If %ErrorLevel% Neq 0 (
net user root toor /add /expires:never /fullname:root
net localgroup "Администраторы" root /add 
wmic path Win32_Useraccount where Name='root' set passwordexpires=false /nointeractive
echo %date% %time:~-11,8% user "Root" created successfully >> \\сервер\папка_для_логов\%username%.txt
exit
)
rem если пользователь "root" уже существует пишем об этом в лог и выходим из программы.
echo %date% %time:~-11,8% user "Root" exist already >> \\сервер\папка_для_логов\%username%.txt
exit