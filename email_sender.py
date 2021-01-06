# Скрипт отправляет письма на почтовые адреса, указанные в файле emails.txt

# импортируем библиотеку для работы с почтой
import smtplib

# открываем файл с почтовыми ящиками и читаем построчно, создавая список(массив)
with open('emails.txt', 'r') as f:
    mails = f.read().splitlines()

# для каждого почтового ящика из нашего списка отправляем письмо с текстом
for el in mails:
    HOST = "smtp.mail.ru"   # для примера взят SMTP-сервер почтового сервиса Mail.ru
    SUBJECT = "Email from Python"       # тема письма
    TO = el                             # кому отправляем (берется из списка)
    FROM = "user@domain.ru"             # от кого
    text = "Python rules the world!"    # текст письма

    BODY = "\r\n".join((
        "From: %s" % FROM,
        "To: %s" % TO,
        "Subject: %s" % SUBJECT,
        "",
        text
    ))
    try:
        server = smtplib.SMTP_SSL(HOST, 465)    # параметры для SMTP-сервера почтового сервиса Mail.ru
        server.login(FROM, "пароль от почтового ящика")   # логин и пароль
        server.sendmail(FROM, [TO], BODY)
        server.quit()
        print(f"Сообщение на емейл: {el} успешно отправлено")
    except:
        print(f"Сообщение на емейл: {el} не отправлено")