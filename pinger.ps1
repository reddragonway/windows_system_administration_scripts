# Скрипт: "Pinger"
# Версия: 1.0
# Описание: Пингует поочередно список компьютеров, указанных в файле computers.txt,
# и выдает сообщение о доступности или недоступности хостов. Для успешной работы скрипта
# необходимо создать на рабочем столе файл computers.txt и указать там имена хостов (не IP-адреса!!!). 
$user = $env:username
$file = "C:\Documents and Settings\$user\Desktop\computers.txt"
$computers = get-content $file
$failcounter=0
write-host ""
write-host "===НАЧИНАЕМ ПИНГОВАТЬ===" -ForegroundColor Green 
write-host ""
foreach ($pc in $computers)
    { 
    if (test-connection -ComputerName $pc -Count 2 -Quiet) 
        {
         write-host "$pc успешно пингуется" -ForegroundColor Green
        } 
    else       
        { 
            write-host "$pc не пингуется" -ForegroundColor Red
            $failcounter++
        }     
    }

if ($failcounter -eq 0) 
    {
write-host ""
write-host "===ИТОГО===" -ForegroundColor Green
write-host "Все компьютеры успешно пингуются. Можно не волноваться :)" -ForegroundColor Green
    }
else 
    {
write-host ""
write-host "===ВНИМАНИЕ===" -ForegroundColor Red
write-host "Количество проблемных компьютеров: $failcounter" -ForegroundColor Red
    }
write-host ""
