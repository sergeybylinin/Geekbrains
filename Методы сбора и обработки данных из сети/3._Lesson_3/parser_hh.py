from bs4 import BeautifulSoup as bs
import requests
import pandas as pd

text = 'Data scientist'
url = 'https://hh.ru'
page = 0
params = {'L_save_area': 'true',
          'clusters': 'true',
          'enable_snippets': 'true',
          'showClusters': 'true',
          'page': page,
          'text': text
          }
headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36'}


def salary(el):
    def int_salary(st):
        return int(''.join([i for i in st if i in '0123456789']))

    min_salary, max_salary, currency = None, None, None

    if el.find('–') > -1:
        min_sal, arg, max_sal = el.partition('–')
        min_salary = int_salary(min_sal)
        max_salary = int_salary(max_sal)

    elif el.startswith('до'):
        max_salary = int_salary(el)

    elif el.startswith('от'):
        min_salary = int_salary(el)

    currency = el[el.rfind(' ') + 1:].rstrip('.')

    return min_salary, max_salary, currency


vacancy_ls = []
vacancy_list = True
while vacancy_list:
    response = requests.get(url + '/search/vacancy', params=params, headers=headers)
    dom = bs(response.text, 'html.parser')
    vacancy_list = dom.find_all('div', {'class': 'vacancy-serp-item'})
    for vacancy in vacancy_list:
        vacancy_data = {}
        vacancy_name = vacancy.find('a', {'class': 'bloko-link'}).text
        serial_link = vacancy.find('a', {'class': 'bloko-link'})['href']
        try:
            vacancy_salary = vacancy.find('span', {'data-qa': 'vacancy-serp__vacancy-compensation',
                                                   'class': 'bloko-section-header-3_lite'}).getText()
            min_salary, max_salary, currency = salary(vacancy_salary)
        except:
            min_salary, max_salary, currency = None, None, None

        vacancy_data['name'] = vacancy_name
        vacancy_data['link'] = serial_link
        vacancy_data['min_salary'] = min_salary
        vacancy_data['max_salary'] = max_salary
        vacancy_data['currency'] = currency

        if vacancy_data not in vacancy_ls:
            vacancy_ls.append(vacancy_data)

    page += 1
    params['page'] = page

df = pd.DataFrame(vacancy_ls)
df.to_csv('hh.csv')
