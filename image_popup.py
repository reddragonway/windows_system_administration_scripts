from tkinter import * # импортируем модуль tkinter
from PIL import ImageTk, Image # импортируем модуль PIL (Pillow)
root = Tk()

root.title("Тут пишем заголовок окна") # создаем заголовок окна
root.geometry("1000x558+480+250") # определяем размеры основного окна и его позицию на экране
canv = Canvas(root, width=1000, height=558) # создаем холст
canv.grid(row=2, column=3)

img = ImageTk.PhotoImage(Image.open("image.jpg"))  # используем PIL (Pillow), добавляем картинку-поздравление
canv.create_image(0, 0, anchor=NW, image=img) # позиция на холсте картинки-поздравления

mainloop()
