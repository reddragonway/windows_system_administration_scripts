Set WshShell = CreateObject("WScript.Shell")
WshShell.Run chr(34) & "Диск:\путь_к_файлу\файл.bat" & Chr(34), 0
Set WshShell = Nothing
