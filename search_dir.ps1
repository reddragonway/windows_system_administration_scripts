# Скрипт для поиска директории на локальных дисках 
$CurrentUser = $env:UserName # определяем имя пользователя
$logfile = "\\сервер\сетевая_папка\search_dir\$CurrentUser.txt" # определяем путь к лог-файлу
# проверяем не создавался ли лог-файл ранее, если создавался то удаляем и создаем новый
IF (Test-Path -Path "$logfile") { 
Remove-Item -Path "$logfile" -Force 
}
$disks=@('C:\','D:\','E:\','F:\','G:\') # создаем массив путей к локальным дискам
foreach ($disk in $disks) # проверяем каждый локальный путь. Если путь существует то производим поиск нужной директории и пишем данные в лог
{ 
IF (Test-Path -Path "$disk") {
Write-Output "Путь $disk существует. Производим поиск директории ЮРИСТЫ:" >> $logfile
Get-ChildItem -Recurse -Filter "имя_папки_которую_надо_найти" -Directory -ErrorAction SilentlyContinue -Path "$disk" >> $logfile
Get-ChildItem -Recurse -Include "имя_файла.расширение" -ErrorAction SilentlyContinue -Path "$disk" >> $logfile # пробуем найти также файл который точно был в искомой папке (если надо)
} 
ELSE {Write-Output "Путь $disk не найден." >> $logfile} # если пути нет, то пишем об этом в лог
}
