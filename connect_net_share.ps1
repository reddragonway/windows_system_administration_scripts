$CurrentUser = $env:UserName # определяем имя пользователя
$logfile = "\\сервер\папка\$CurrentUser.txt" # путь к лог файлу
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Начинается работа скрипта по подключению сетевого диска <имя диска>..." >> $logfile # начинаем писать лог
try # проверяем на ошибки
{
$net = $(New-Object -ComObject WScript.Network); # создаем обьект
$net.MapNetworkDrive(“Y:”, “\\сервер\папка”); # указываем букву сетевого диска (н-р, "Y:") и путь к расшаренному ресурсу
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Сетевой диск подключен. Успешное завершение работы скрипта." >> $logfile # пишем в лог успешное выполнение скрипта
}
catch # если поймали ошибку
{
  Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Внимание!!! Ошибка." >> $logfile # пишем в лог об ошибке
  Write-Output $error[0].Exception >> $logfile # выводим в лог конкретную ошибку
}