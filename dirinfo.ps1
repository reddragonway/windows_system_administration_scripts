# Скрипт: "Dirinfo"
# Версия: 1.0
# Описание: Выводит информацию об указанной директории.    
$properties = @(
    'Name'
    @{
        Label = 'Size'
        Expression = {
            if ($_.Length -ge 1GB)
            {
                '{0:F2} GB' -f ($_.Length / 1GB)
            }
            elseif ($_.Length -ge 1MB)
            {
                '{0:F2} MB' -f ($_.Length / 1MB)
            }
            elseif ($_.Length -ge 1KB)
            {
                '{0:F2} KB' -f ($_.Length / 1KB)
            }
            else
            {
                '{0} bytes' -f $_.Length
            }
        }
    }
)
while ($true)
{
    try 
        {$pathfordir = read-host "Введите путь к директории: "  
        $isfolder = test-path $pathfordir 
            if ($isfolder -eq "True")
                { break } 
            else 
                {write-host ""
                 write-host "Внимание!!! Указанная директория не существует. Попробуйте ввести путь еще раз." -ForegroundColor Red
                 write-host ""}
        }
    catch [system.exception] 
        {write-host "Внимание!!! Системная ошибка. Попробуйте еще раз."}
}
write-host ""
write-host "=== ИНФОРМАЦИЯ О ДИРЕКТОРИИ ==="
write-host ""
write-host "В директории $pathfordir имеются следующие файлы:"
write-host ""
get-childItem $pathfordir -force | where-object {!$_.PSisContainer} | format-table -auto -Property $properties
write-host "В директории $pathfordir имеются следующие папки:"
write-host ""
$root=$pathfordir
get-childItem $root -recurse -force | where {$_.psIscontainer} | foreach {
   $count = get-childItem $_.fullname -recurse | where {$_.length} | measure-object -property length -Sum
   write-host($_.FullName)
   $fsize = '{0:F2}' -f (($count.Sum)/ 1Mb)
   write-host("Files: " + $count.count )
   write-host("Size: " + $fsize + " MB")
   write-host ""
}
$foldersize = (Get-ChildItem $pathfordir -recurse -Force | Measure-Object -Property Length -Sum).Sum / 1Mb
$foldersize = '{0:F2}' -f $foldersize
write-host ""
write-host "=== ИТОГО: ==="
write-host ""
write-host "Директория $pathfordir весит: $foldersize MB"
write-host ""
