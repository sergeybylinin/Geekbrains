from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.action_chains import ActionChains
from time import sleep
from datetime import date, timedelta
from pymongo import MongoClient


chrome_options = Options()
chrome_options.add_argument('start-maximized')

driver = webdriver.Chrome()
driver.get('https://mail.ru/')

elem = driver.find_element_by_class_name('email-input')
elem.send_keys('study.ai_172@mail.ru')

button = driver.find_element_by_xpath('//button[@data-testid = "enter-password"]')
button.click()
sleep(1)

elem = driver.find_element_by_name("password")
elem.send_keys('NextPassword172!')

button = driver.find_element_by_xpath('//button[@data-testid="login-to-mail"]')
button.click()
sleep(5)

dataset_items = driver.find_elements_by_xpath("//a[contains(@class, 'llc')]")
all_links_emails_list = list(map(lambda item: item.get_attribute('href'), dataset_items))

while True:
    actions = ActionChains(driver)
    actions.move_to_element(dataset_items[-1])
    actions.perform()
    sleep(5)
    dataset_items = driver.find_elements_by_xpath("//a[contains(@class, 'llc')]")
    links_emails_list = list(map(lambda item: item.get_attribute('href'), dataset_items))
    if links_emails_list[-1] not in all_links_emails_list:
        break
    else:
        all_links_emails_list.extend(links_emails_list)

def date_format(datetime):

    def int_format(number):
        if len(str(number)) < 2:
            number = f'0{number}'
        return number

    _date, arg, _time = datetime.partition(', ')
    day, arg, month = _date.partition(' ')

    if _date == 'Вчера':
        _date = date.today() - timedelta(days=1)
        return f'{_date}, {_time}'

    months = ["Января", "Февраля", "Марта", "Апреля", "Мая", "Июня",
              "Июля", "Августа", "Сентября", "Октября", "Ноября", "Декабря"]

    if month.isalpha():
        month = month.title()
        month = months.index(month) + 1

    day = int_format(day)
    month = int_format(month)

    return f'2021-{month}-{day}, {_time}'

emails = dict()
id = 0

for link in set(all_links_emails_list):
    if id == 2: break
    driver.get(link)
    sleep(3)
    email = dict()
    id += 1
    email['_id'] = id
    email['name'] = driver.find_element_by_class_name('letter-contact').get_attribute('title')
    datetime = driver.find_element_by_class_name('letter__date').text
    email['date'] = date_format(datetime)
    email['subject'] = driver.find_element_by_xpath('//h2').text
    email['text'] = driver.find_element_by_class_name('letter-body').text

    emails[str(id)] = email

client = MongoClient('localhost', 27017)

db = client['user17']

emails_db = db.emails_db

for i in emails:
    emails_db.insert_one(emails[i])