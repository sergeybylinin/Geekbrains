from lxml import html
from pprint import pprint
import requests

header = {'User-Arent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.212 Safari/537.36'}

responce = requests.get('https://lenta.ru/')
dom = html.fromstring(responce.text)

news = []

news_lenta_ru = dom.xpath("//section[contains(@class,'js-top-seven')]/div[contains(@class,'span4')]/div[contains(@class,'item')]")

for item in news_lenta_ru:
    one_news = {}
    one_news['link'] = item.xpath('.//a[contains (@href,"news")]/@href')[0]
    one_news['text'] = item.xpath('.//a[contains (@href,"news")]/text()')[0].replace('\xa0', ' ')
    one_news['date'] = item.xpath('.//time/@datetime')[0][1:]
    one_news['source'] = 'lenta.ru'

news.append(one_news)

pprint(news)