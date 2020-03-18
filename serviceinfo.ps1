# Скрипт: "Serviceinfo"
# Версия: 1.0
# Скрипт выводит информацию о состоянии запрошенной пользователем службы на хостах из списка компьютеров, указанных в файле computers.txt
# Для успешной работы скрипта необходимо создать на рабочем столе файл computers.txt и указать там имена хостов (не IP-адреса!!!). 
$user = $env:username
$file = "C:\Documents and Settings\$user\Desktop\computers.txt"
$computers = get-content $file
$global:counter_notinstalled = 0
$global:counter_notworking = 0 
$global:counter_working = 0
$global:counter_fail_ping = 0
write-host ""
$service = read-host "Введите название службы: " 
write-host ""
write-host "===НАЧИНАЕМ ПРОВЕРКУ===" -ForegroundColor Green 
write-host ""
function ping_computers {
    ForEach ($pc in $computers)
    {
        if (test-connection -ComputerName $pc -Count 1 -quiet) 
        {
            get_serviceinfo
        }
        else 
        {
            write-host ""
            write-host "$pc не пингуется. Получение информации о состоянии службы невозможно :(" -ForegroundColor Red
            write-host ""
            $global:counter_fail_ping++
        }
    }
}
function get_serviceinfo {
$a = get-service -computername $pc | where {$_.Name -like $service}
    foreach ($item in $a)
	{
		if ($item.Status -eq $null)
        {
            write-host $pc $item.Name $service "Отсутствует `n" -NoNewline -ForegroundColor Red
			$global:counter_notinstalled++
			break			
        }
 		if ($item.Status -eq "Running")
		{
			write-host $pc $item.Name $item.Status "`n" -NoNewline -ForegroundColor Green
            $global:counter_working++
        }
		else
		{
			write-host $pc $item.Name $item.Status "`n" -NoNewline 
			$global:counter_notworking++
		}
	}
}
ping_computers
Write-Host ""
write-host "===ИТОГО===" -ForegroundColor Green
if ($global:counter_working -gt 0) 
{Write-Host "Количество хостов, где служба запущена: $global:counter_working" -ForegroundColor Green}
if ($global:counter_notworking -gt 0) 
{Write-Host "Количество хостов, где служба не запущена: $global:counter_notworking"}
if ($global:counter_notinstalled -gt 0) 
{Write-Host "Количество хостов, где служба не установлена: $global:counter_notinstalled" -ForegroundColor Red}
if ($global:counter_fail_ping -gt 0) 
{Write-Host "Количество хостов, которые не пингуются: $global:counter_fail_ping" -ForegroundColor Red}
write-host ""



