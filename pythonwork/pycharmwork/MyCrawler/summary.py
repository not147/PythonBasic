from bs4 import BeautifulSoup
from urllib.request import urlopen
import requests

# 오늘의 날씨
# https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=서울날씨
def weather():
    print("\t >> 오늘의 날씨 요약 \n")

    loc = ['서울', '부산', '제주도', '광주', '대전', '경기도']
    for i in loc:
        try:
            url = 'https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query={}날씨'.format(i)
            html = requests.get(url)
            soup = BeautifulSoup(html.text, 'html.parser')
            temps = soup.find('span', 'todaytemp').get_text()
            msg = soup.find('p', 'cast_txt').get_text()
        except Exception as e:
            print("오류 : ", e)
        else:
            print('----> {}날씨:{} ℃ \t {}'.format(i, temps, msg))

# 오늘의 코로나 현황
# http://ncov.mohw.go.kr
def corona():
    print("\t >> 오늘의 국내 코로나 현황 요약 \n")
    # html = requests.get('http://ncov.mohw.go.kr')
    # soup = BeautifulSoup(html.text, 'html.parser')
    html = urlopen('http://ncov.mohw.go.kr')
    soup = BeautifulSoup(html, 'html.parser')
    temps = soup.find('span', "before").get_text()
    cast = soup.find('span', "num").get_text()

    print("--> 오늘의 신규 확진자 :" + temps + "\n" + "--> 현재까지 확진자 :" + cast)

# 오늘의 핫토픽
# https://www.naver.com 연합뉴스 크롤링
def news():
    print("\t >> 오늘의 핫 토픽 헤드라인 \n")
    html = requests.get("https://www.naver.com/")
    soup = BeautifulSoup(html.text, "html.parser")
    for i in soup.find_all("a", "issue"):
        print("--->", i.get_text())

# 오늘의 음원 Top10
# https://search.naver.com/search.naver?sm=tab_hty.top&where=nexearch&query=음원차트&oquery=멜론차트&tqi=UrZ0HsprvN8ssK5ZP%2BsssssstVh-314088
def music():
    print("\t >> 오늘의 음원 종합 TOP 10 \n")