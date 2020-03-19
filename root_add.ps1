# Скрипт для автоматического добавления пользователя с правами локального администратора на компьютере.
$ComputerName = $Env:COMPUTERNAME # Имя компьютера
$CurrentUser = $env:UserName # Имя текущего пользователя
$UserName = 'root' # Имя создаваемого пользователя (для примера взят пользователь "root")
$GroupName = 'Администраторы'# Группа в которую нужно добавить пользователя (для примера взята группа "Администраторы")
# Проверяем существует ли пользователь. Если существует пишем в лог и выходим из программы. 
if ([ADSI]::Exists("WinNT://$ComputerName/$UserName"))
{
    Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Ошибка! Пользователь $UserName на рабочей станции $ComputerName уже существует. Выход из программы." >> \\сервер\root_add_log\$CurrentUser.txt # Пишем лог 
    break
}
$Computer = [ADSI]"WinNT://$ComputerName,computer" # Получаем объект компьютера
$User = $Computer.Create('User', $UserName) # Создаём пользователя
$User.SetPassword('toor') # Устанавливаем пароль (для примера взят классический пароль "toor"). 
$User.UserFlags.Value = $User.UserFlags.Value -bor 0x10000 # Задаём срок действия пароля - не ограничен
$User.SetInfo() # сохранить сделанные изменения
$Group = [ADSI]"WinNT://$ComputerName/$GroupName, group" # Получаем объект группы
$Group.Add("WinNT://$UserName, user") # Добавляем пользователя в группу
Write-Output "$((Get-Date).ToString('dd.MM.yyyy')) $(Get-Date -Format t) Пользователь $UserName успешно добавлен на рабочей станции $ComputerName. Выход из программы." >> \\сервер\root_add_log\$CurrentUser.txt # Пишем лог 