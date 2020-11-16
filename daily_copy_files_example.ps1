# Скрипт для ежедневной заливки файлов с R0630000 в папку pu_doc для персучета 
# Шаг1: Проверяем не запускался ли скрипт ранее в текущий день (в этом случае уже будет создана папка в архиве). 
# Если так, то переносим все файлы с сервера R0630000 в папку E:\Disk-P\pu_doc\Files_R0630000 (с перезаписью текущих), пишем в лог и выходим из программы.
$logfile = "D:\pu_doc_auto_script\pu_doc_log\pu_doc_log.txt"
$isdir = Test-Path -Path "E:\Disk-P\pu_doc\Files_R0630000\Old\$(((Get-Date).AddDays(-1)).ToString('yyyy-MM-dd'))" 
if (test-connection r0630000 -Count 2) { 
    if ($isdir) {
        Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Директория уже существует. Копируем файлы с сервера R0630000" >> $logfile
        Copy-Item -Force \\r0630000\SHDIR\post\*.* -Destination E:\Disk-P\pu_doc\Files_R0630000 -Verbose 4>&1 2>&1 >> $logfile
        #  Копируем файлы с определенными именем с сервера R0630000 в сетевую папку отдела ОСВ.
        if (test-connection 10.63.0.29 -Count 2) {
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_egrzagsp*.*" -Destination \\10.63.0.29\Osv\ОСВ\Списки_ЕГР_ЗАГС -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
        } 
        else {
            Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка при повторном запуске (за день). Нет связи с сервером sw06300008025" >> $logfile
        } 
        # Тоже самое но для отдела Инвестирования
        if (test-connection 10.63.0.25 -Count 2) {
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63-DTHSPC*.*" -Destination \\10.63.0.25\Inv\Списки_умерших -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_DTHSPC*.*" -Destination \\10.63.0.25\Inv\Списки_умерших -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_USPN*.*" -Destination \\10.63.0.25\Inv\Файлы_с_заявлениями_по_инвестированию -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
        } 
        else {
            Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка при повторном запуске (за день). Нет связи с сервером sw06300008print" >> $logfile
        }
        Move-Item -Force \\r0630000\SHDIR\post\*.*  -Destination D:\pu_doc_auto_script\pu_doc_backup\$((Get-Date).ToString('yyyy-MM-dd')) -Verbose 4>&1 2>&1 >> $logfile
        Copy-Item -Force $logfile  -Destination D:\Disk-L\scripts_logs\pu_doc_log
        exit
    }
}  
else {
    Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка при повторном запуске (за день). Нет связи с сервером R0630000. Выход из программы." >> $logfile
    Copy-Item -Force $logfile  -Destination D:\Disk-L\scripts_logs\pu_doc_log 
    exit
    } 
# Шаг 2: создаем  в каталоге E:\Disk-P\pu_doc\Files_R0630000\Old папку с датой предыдущего дня и 
# переносим туда все файлы начинающиеся с "63" из каталога E:\Disk-P\pu_doc\Files_R0630000
Write-Output "" >> $logfile
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Начинается работа программы." >> $logfile
New-Item -ItemType Directory -Path "E:\Disk-P\pu_doc\Files_R0630000\Old\$(((Get-Date).AddDays(-1)).ToString('yyyy-MM-dd'))" -Verbose 4>&1 2>&1 >> $logfile
Move-Item E:\Disk-P\pu_doc\Files_R0630000\*.*  -Include "63*.*" -Destination E:\Disk-P\pu_doc\Files_R0630000\Old\$(((Get-Date).AddDays(-1)).ToString('yyyy-MM-dd')) -ErrorAction Ignore  -Verbose 4>&1 2>&1 >> $logfile
Move-Item E:\Disk-P\pu_doc\Files_R0630000\*.*  -Include "mz*.*" -Destination E:\Disk-P\pu_doc\Files_R0630000\Old\$(((Get-Date).AddDays(-1)).ToString('yyyy-MM-dd')) -ErrorAction Ignore  -Verbose 4>&1 2>&1 >> $logfile
# Шаг 3: проверяем связь с сервером R0630000. Если связь с сервером есть, то копируем с него все файлы в папку E:\Disk-P\pu_doc\Files_R0630000, делаем бэкап и пишем лог.
# В противном случае выходим из программы.
if (test-connection r0630000 -Count 2) { 
    Write-Output "$(Get-Date -Format t) Проверка связи: связь с сервером R0630000 установлена." >> $logfile
    Get-ChildItem -Path \\R0630000\SHDIR\post >> $logfile
    Copy-Item \\r0630000\SHDIR\post\*.*  -Destination E:\Disk-P\pu_doc\Files_R0630000 -Verbose 4>&1 2>&1 >> $logfile
    #  Копируем файлы с определенными именем с сервера R0630000 в сетевую папку отдела ОСВ.
    if (test-connection 10.63.0.29 -Count 2) {
        Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_egrzagsp*.*" -Destination \\10.63.0.29\Osv\ОСВ\Списки_ЕГР_ЗАГС -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
    } 
    else {
        Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка. Нет связи с сервером sw06300008025" >> $logfile
    }
    # Тоже самое но для отдела Инвестирования
    if (test-connection 10.63.0.25 -Count 2) {
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63-DTHSPC*.*" -Destination \\10.63.0.25\Inv\Списки_умерших -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_DTHSPC*.*" -Destination \\10.63.0.25\Inv\Списки_умерших -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
            Copy-Item \\r0630000\SHDIR\post\*.* -Force -Include "63_USPN*.*" -Destination \\10.63.0.25\Inv\Файлы_с_заявлениями_по_инвестированию -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
    } 
    else {
            Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка при повторном запуске (за день). Нет связи с сервером sw06300008print" >> $logfile
    } 
    New-Item -ItemType Directory -Path "D:\pu_doc_auto_script\pu_doc_backup\$((Get-Date).ToString('yyyy-MM-dd'))" -Verbose 4>&1 2>&1 >> $logfile
    Move-Item \\r0630000\SHDIR\post\*.*  -Destination D:\pu_doc_auto_script\pu_doc_backup\$((Get-Date).ToString('yyyy-MM-dd')) -Verbose 4>&1 2>&1 >> $logfile
    Copy-Item -Force $logfile  -Destination D:\Disk-L\scripts_logs\pu_doc_log
    exit
    } 
else {
    Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка. Нет связи с сервером R0630000. Выход из программы." >> $logfile
    Copy-Item -Force $logfile  -Destination D:\Disk-L\scripts_logs\pu_doc_log 
    exit 
    }
