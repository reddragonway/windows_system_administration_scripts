$path = "\\сервер\папка_для_скриншотов\$env:username"
# Проверяем наличие директории для скриншотов (если нет, то создаем)
If (!(test-path $path)) {
New-Item -ItemType Directory -Force -Path $path
}
Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
# Получаем разрешение экрана
$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
# Создаем графический объект
$graphic = [System.Drawing.Graphics]::FromImage($image)
$point = New-Object System.Drawing.Point(0, 0)
$graphic.CopyFromScreen($point, $point, $image.Size);
$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position, [System.Windows.Forms.Cursor]::Current.Size)
# Получаем скриншот экрана
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds)
$screen_file = "$path\" + $env:username + "_" + "$((get-date).tostring('dd.MM.yyyy-HH.mm.ss')).png"
# Сохранить скриншот в png файл
$image.Save($screen_file, [System.Drawing.Imaging.ImageFormat]::Png)