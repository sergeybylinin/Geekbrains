from pymongo import MongoClient
from parser_hh import vacancy_ls
from pprint import pprint

client = MongoClient('127.0.0.1', 27017)

db = client['vacancy']

db.data_scientist.drop()
data_scientist = db.data_scientist


def check_in(el, collection):
    if collection.find_one(el) is None:
        collection.insert_one(el)
    return collection


for vacancy in vacancy_ls:
    check_in(vacancy, data_scientist)


def search_by_salary(salary, collection):
    for vacancy in collection.find({'max_salary': {'$gte': salary}}):  # больше или равно
        yield vacancy


pprint(list(search_by_salary(150000, data_scientist)))
