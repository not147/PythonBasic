from summary import weather, corona, news, music
import datetime

def greeting():
    now = datetime.datetime.now()
    now_str = now.strftime("%Y년 %m월 %d일 %H시 %M분 입니다.")

    print("\t\t 환영합니다.\t\t" + now_str)
    print("\t\t\t\t 오늘의 주요 정보를 요약해 드리겠습니다. \n")


if __name__ == '__main__':
    greeting()

    while True:
        print("=======================================================================")
        print("1.  날씨")
        print("2.  코로나 현황")
        print("3.  핫 토픽")
        print("4.  음원 랭킹")

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


