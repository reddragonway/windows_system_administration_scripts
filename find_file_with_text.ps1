# Скрипт для поиска файла по ключевому слову
$path = "Сюда нужно ввести путь к директории поиска" 
Write-Host "== |НАЙТИ ИМЯ ФАЙЛА ПО КЛЮЧЕВОМУ СЛОВУ| =="
Write-Host ""
Write-Host "Директория поиска: $path"
Write-Host ""
$keyword = Read-Host "Введите ключевое слово для поиска (или Q для выхода)"
While ($keyword -ne "q" -OR $keyword -ne "Q") {
    IF ([string]::IsNullOrWhitespace($keyword)) {
        While ([string]::IsNullOrWhitespace($keyword)) {
            Write-Host ""
            Write-Host "Нельзя вводить пустую строку!"
            $keyword = Read-Host "Введите ключевое слово для поиска (или Q для выхода)"
            Write-Host ""
            IF ($keyword -eq "q" -OR $keyword -eq "Q") {exit} 
        }
} 
    Get-ChildItem -Path $path -Recurse -File | Select-String $keyword | Get-ChildItem
    Write-Host ""
    $keyword = Read-Host "Введите ключевое слово для поиска (или Q для выхода)"
    Write-Host ""
}

