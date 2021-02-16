# Скрипт для отправки письма с приложением на определенный е-мейл. 
# Опционально, умеет формировать zip-архив перед отправкой. 
# Для корректной работы функции архивирования нужен Powershell 5.1 и выше.

# Путь к лог файлу
$logfile = "\\путь_к_папке_с_логами\логфайл.txt" 

# Пишем в лог (начало)
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Запуск выполнения скрипта..." >> $logfile

# Первая часть: формируем приложение для отправки письма
# Копируем необходимые файлы в директорию скрипта
Copy-Item C:\папка -Recurse -Force -Destination С:\папка_с_вложением_для_отправки -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
Copy-Item С:\нужный_файл.doc -Force -Destination С:\папка_с_вложением_для_отправки -ErrorAction Ignore -Verbose 4>&1 2>&1 >> $logfile
# Создаем архив
try {
Compress-Archive -LiteralPath 'С:\папка_с_вложением_для_отправки\папка','С:\папка_с_вложением_для_отправки\нужный_файл.doc' -DestinationPath 'С:\папка_с_вложением_для_отправки\вложение.zip' 
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) ZIP-архив создан" >> $logfile
}
catch {
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка при создании ZIP-архива" >> $logfile
}

# Вторая часть: отправляем письмо
#Адрес SMTP сервера для отправки
$smtp_server = "ip-адрес SMTP-сервера" 
#Порт сервера
$port = 25
#От кого
$from = "login@domen.ru" 
#Кому
$to = "vasya_pupkin@domen.ru" 
#Тема письма
$subject = "Очень важное письмо"
#Логин и пароль от ящика с которого отправляем письмо 
$login = "логин"
$password = "пароль"
#Путь до файла 
$file = "С:\папка_с_вложением_для_отправки\вложение.zip"
#Создаем два экземпляра класса
$attachment = New-object Net.Mail.Attachment($file)
$message = New-Object System.Net.Mail.MailMessage
#Формируем данные для отправки
$message.From = $from
$message.To.Add($to) 
$message.Subject = $subject 
$message.IsBodyHTML = $true 
$message.Body = "Добрый день! <br> <br> Направляю письмо с прилоежением <br> <br> С Уважением, <br>"
#Добавляем файл
$message.Attachments.Add($attachment) 
#Создаем экземпляр класса подключения к SMTP серверу 
$smtp = New-Object Net.Mail.SmtpClient($smtp_server, $port)
#Раскомментировать если сервер использует SSL 
#$smtp.EnableSSL = $true 
#Создаем экземпляр класса для авторизации на почтовом сервере 
$smtp.Credentials = New-Object System.Net.NetworkCredential($login, $password);
#Отправляем письмо, пишем в лог, освобождаем память
try{
$smtp.Send($message)
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Сообщение успешно отправлено" >> $logfile
}
catch {
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка! Сбой при отправке сообщения" >> $logfile
}
$attachment.Dispose()

# Очищаем директорию от лишних файлов
Remove-Item -Path "С:\папка_с_вложением_для_отправки\папка" -Recurse -Force -ErrorAction Ignore
Remove-Item -Path "С:\папка_с_вложением_для_отправки\нужный_файл.doc" -Force -ErrorAction Ignore
Remove-Item -Path "С:\папка_с_вложением_для_отправки\вложение.zip" -Force -ErrorAction Ignore

# Пишем в лог (конец)
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Скрипт завершил работу" >> $logfile
Copy-Item -Force $logfile  -Destination D:\бэкап_логов
