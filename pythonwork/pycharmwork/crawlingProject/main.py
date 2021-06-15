# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

import datetime
from summary import weather, corona, news, music

def greeting():
    now = datetime.datetime.now()
    nowDate = now.strftime('%Y년 %m월 %d일 %H시 %M분 입니다.')

    print('   환영합니다, ' + nowDate)
    print('      오늘의 주요 정보를 요약해 드리겠습니다.\n')

if __name__ == '__main__':
    greeting()

    while True:
        print("=========================================")
        print("1. 날씨")
        print("2. 코로나 현황")
        print("3. 핫 토픽")
        print("4. 음원정보")

        menu = input("메뉴 입력 : ")

        if menu == "1":
            weather()
        elif menu == "2":
            corona()
        elif menu == "3":
            news()
        elif menu == "4":
            music()
        else:
            break

