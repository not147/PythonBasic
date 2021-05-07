#### 기술 통계량 ####

### table()
aws <- read.delim("../data/AWS_sample.txt", sep="#")
head(aws)
str(aws)

table(aws$AWS_ID)
?table
table(aws$AWS_ID, aws$X.)
View(aws)

table(aws[, c("AWS_ID", "X.")])

aws[2500:3100, "X."] = "modified"
aws[2500:3100, "X."]
table(aws$AWS_ID, aws$X.)

prop.table(table(aws$AWS_ID))
prop.table(table(aws$AWS_ID)) * 100

paste0(prop.table(table(aws$AWS_ID)) * 100, "%")

### 기술통계 함수의 모듈화
# 각 컬럼 단위로 빈도와 최대 최소값 계산

test <- read.csv("../data/test.csv", header=T)
head(test)
length(test)
str(test)

table(test$A)
max(test$A)
min(test$A)

data_proc <- function(df){
  for(idx in 1:length(df)){
    cat(idx, "번째 컬럼의 빈도 분석 결과")
    print(table(df[idx]))
    cat("\n")
  }
  
  for(idx in 1:length(df)){
    f <- table(df[idx])
    cat(idx, "번째 컬럼의 최대/최소값 결과 : \t")
    cat("max=", max(f), ", min=", min(f), "\n")
  }
}

data_proc(test)


#### plyr, dplyr ####

### plyr
install.packages("plyr")
library(plyr)

x <- data.frame(id=c(1, 2, 3, 4, 5, 6), height=c(160, 171, 173, 162, 165, 170))
y <- data.frame(id=c(5, 4, 1, 3, 2, 7), weight=c(55, 73, 60, 57, 80, 91))
x
y
?plyr

# 데이터 병합
xy <- join(x, y, by="id", type="left")
xy

xy <- join(x, y, by="id", type="right")
xy

xy <- join(x, y, by="id", type="full")
xy

xy <- join(x, y, by="id", type="inner")
xy

# 다중 키
x <- data.frame(key1=c(1, 1, 2, 2, 3), key2=c('a', 'b', 'c', 'd', 'e'),
                val=c(10, 20, 30, 40, 50))

y <- data.frame(key1=c(3, 2, 2, 1, 1), key2=c('e', 'd', 'c', 'b', 'a'),
                val=c(500, 400, 300, 200, 100))

xy <- join(x, y, by=c("key1", "key2"))
xy


# 기술 통계량
# tapply : 집단 변수를 대상으로 한번에 하나의 통계량을 구할 때 사용(기본 함수)
# ddply : 한번에 여러 개의 통계량을 구할 때 사용 (plyr 패키지 함수 설치)

head(iris)
str(iris)
unique(iris$Species)
class(iris$Species)

tapply(iris$Sepal.Length, iris$Species, mean)
tapply(iris$Sepal.Length, iris$Species, sd)

?ddply
ddply(iris, .(Species), summarise, avg=mean(Sepal.Length))
ddply(iris, .(Species), summarise, avg=mean(Sepal.Length), std=sd(Sepal.Length),
      max=max(Sepal.Length), min=min(Sepal.Length))


### dplyr
install.packages("dplyr")
library(dplyr)
?dplyr

exam <- read.csv("../data/csv_exam.csv")
exam

### filter()
# 1반 학생들의 데이터 추출
exam[exam$class==1, ]
subset(exam, class==1)

filter(exam, class==1)
exam %>% filter(class==1)

# 2반이면서 영어점수가 80점이상인 데이터만 추출
exam[exam$class==2 & exam$english>=80, ]
exam %>% filter(class==2 & english>=80)

# 1, 3, 5반에 해당하는 데이터만 추출
exam %>% filter(class==1 | class==3 | class==5)
exam %>% filter(class %in% c(1, 3, 5))


### select()
# 수학점수만 추출
exam[, 3]
exam %>% select(math)

# 반, 수학, 영어점수 추출
exam[, c(2, 3, 4)]
exam %>% select(class, math, english)

# 수학점수를 제외한 나머지 컬럼 추출
exam %>% select(-math)

# 1반 학생들의 수학점수만 추출(2명만 표시) : select math from exam where class=1 limit 2;
exam %>% filter(class==1) %>% select(class, math) %>% head(2)



### arrange()
exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)



### mutate()
exam$sum <- exam$math + exam$english + exam$science
exam

exam$mean <- exam$sum/3
exam

exam <- exam[ , -c(6, 7)]  # 열 삭제 
exam

exam <- exam %>% mutate(sum=math+english+science, mean=sum/3)
exam



### summarize()
exam %>% summarise(mean_math = mean(math))



### groupby()
exam %>% group_by(class) %>% summarise(mean_math=mean(math), sum_math=sum(math),
                                       median_math=median(math), count=n())


### left_join(), bind_rows()
test1 <- data.frame(id=c(1, 2, 3, 4, 5), midterm=c(60, 70, 80, 90, 85))
test2 <- data.frame(id=c(1, 2, 3, 4, 5), midterm=c(70, 83, 65, 95, 80))

left_join(test1, test2, by="id")
bind_rows(test1, test2)



#### 연습문제1 ####
install.packages("ggplot2")
library(ggplot2)

head(ggplot2::mpg)
str(ggplot2::mpg)
class(ggplot2::mpg)

mpg <- as.data.frame(ggplot2::mpg)
tail(mpg)
names(mpg)
dim(mpg)
View(mpg)


# 배기량(displ)이 4이하인 차량의 모델명, 배기량, 생산년도 조회


# 통합연비 파생변수(total)를 만들고 통합연비로 내림차순 정렬을 한 후에 3개의 행만 선택해서 조회
# 통합연비 : total <- (cty + hwy)/2



# 회사별로 "suv"차량의 도시 및 고속도로 통합연비 평균을 구해 내림차순으로 정렬하고 1위~5위까지 조회



# 어떤 회사의 hwy연비가 가장 높은지 알아보려고 한다. hwy평균이 가장 높은 회사 세곳을 조회



# 어떤 회사에서 compact(경차) 차종을 가장 많이 생산하는지 알아보려고 한다. 각 회사별 경차 차종 수를 내림차순으로 조회



# 연료별 가격을 구해서 새로운 데이터프레임(fuel)으로 만든 후 기존 데이터셋과 병합하여 출력.
# c:CNG = 2.35, d:Disel = 2.38, e:Ethanol = 2.11, p:Premium = 2.76, r:Regular = 2.22
# unique(mpg$fl)



# 통합연비의 기준치를 통해 합격(pass)/불합격(fail)을 부여하는 test라는 이름의 파생변수를 생성. 이 때 기준은 20으로 한다.



# test에 대해 합격과 불합격을 받은 자동차가 각각 몇대인가?



# 통합연비등급을 A, B, C 세 등급으로 나누는 파생변수 추가:grade
# 30이상이면 A, 20~29는 B, 20미만이면 C등급으로 분류






#### 연습문제2 ####
# 미국 동북부 437개 지역의 인구 통계 정보
midwest <- as.data.frame(ggplot2::midwest)
str(midwest)


# 전체 인구대비 미성년 인구 백분율(ratio_child) 변수를 추가


# 미성년 인구 백분율이 가장 높은 상위 5개 지역(county)의 미성년 인구 백분율 출력


# 분류표의 기준에 따라 미성년 비율 등급 변수(grade)를 추가하고, 각 등급에 몇개의 지역이 있는지 조회
# 미성년 인구 백분율이 40이상이면 "large", 30이상이면 "middel", 그렇지않으면 "small"


# 전체 인구 대비 아시아인 인구 백분율(ratio_asian) 변수를 추가하고 하위 10개 지역의 state, county, 아시아인 인구 백분율을 출력





#### Data Preprocessing ####

#### 1. 데이터 탐색

### 변수명 바꾸기
df_raw <- data.frame(var1=c(1, 2, 3), var2=c(2, 3, 2))
df_raw

# 기본(내장)함수
df_raw1 <- df_raw
names(df_raw1) <- c("v1", "v2")
df_raw1

library(dplyr)
df_raw2 <- df_raw
df_raw2 <- rename(df_raw2, v1=var1, v2=var2)
df_raw2



#### 2. 결측치 처리
dataset1 <- read.csv("../data/dataset.csv", header=T)
str(dataset1)
head(dataset1)
View(dataset1)

# resident : 1 ~ 5까지의 값을 갖는 명목변수로 거주지를 나타낸다.
# gender : 1 ~ 2까지의 값을 갖는 명목변수로 남/녀를 나타냄
# job : 1 ~ 3까지의 값을 갖는 명목변수. 직업을 나타냄
# age : 양적변수(비율) : 2 ~ 69
# position : 1 ~ 5까지의 값을 갖는 명목변수. 직위를 나타냄
# price : 양적변수(비율) : 2.1 ~ 7.9
# survey : 만족도 조사 : 1 ~ 5까지 명목변수

y <- dataset1$price
plot(y)

attach(dataset1)
plot(price)

detach(dataset1)
plot(price)

# 결측치 확인
summary(dataset1$price)

# 결측치 제거
?sum
sum(dataset1$price, na.rm=T)
mean(dataset1$price, na.rm=T)

price2 <- na.omit(dataset1$price)
summary(price2)

# 결측치 대체 : 0으로 대체
price3 <- ifelse(is.na(dataset1$price), 0, dataset1$price)
summary(price3)
sum(price3)
mean(price3)

# 결측치 대체 : 평균으로 대체
price4 <- ifelse(is.na(dataset1$price), 
                 round(mean(dataset1$price, na.rm=T), 2), dataset1$price)
summary(price4)
sum(price4)
mean(price4)


#### 3. 이상치 처리
# 양적변수와 질적변수 구별
# 색깔(질적), 무게(양적), 소프트웨어버전(질적), 자동차년식(질적)
# 온도(양적), 스카우트 순위(질적)

# 질적변수 : 도수분포표, 분할표 => 막대 그래프(도수), 원도표, ...
table(dataset1$gender)
pie(table(dataset1$gender))

# 양적변수 : 산술평균, 조화평균, 중앙값 => 히스토그램, 상자도표, 시계열도표, 산포도
summary(dataset1$price)
length(dataset1$price)
str(dataset1)

plot(dataset1$price)
boxplot(dataset1$price)

# 이상치 처리
dataset2 <- subset(dataset1, price>=2 & price<=8)
length(dataset2$price)

plot(dataset2$price)
boxplot(dataset2$price)
summary(dataset2$price)

summary(dataset2$age)
plot(dataset2$age)
boxplot(dataset2$age)


#### 4. Feature Engineering
View(dataset2)

# 가독성을 위해 데이터를 변경(1.서울, 2.인천, 3.대전, 4.대구, 5.시구군)
dataset2$resident2[dataset2$resident == 1] <- "1.서울특별시"
dataset2$resident2[dataset2$resident == 2] <- "2.인천광역시"
dataset2$resident2[dataset2$resident == 3] <- "3.대전광역시"
dataset2$resident2[dataset2$resident == 4] <- "4.대구광역시"
dataset2$resident2[dataset2$resident == 5] <- "5.시구군"

## Binning : 척도 변경(양적 -> 질적)
# 나이 변수를 청년층(30세 이하), 중년층(31 ~ 55이하), 장년층(56~)
dataset2$age2[dataset2$age<=30] <- "청년층"
dataset2$age2[dataset2$age>30 & dataset2$age<=55] <- "중년층"
dataset2$age2[dataset2$age>55] <- "장년층"

View(dataset2)


## 역코딩
table(dataset2$survey)
t_survey <- dataset2$survey
t_survey

c_survey <- 6-t_survey
dataset2$survey <- c_survey
View(dataset2)



## Dummy : 척도 변경(질적 -> 양적)
# 거주 유형 : 단독주택(1), 다가구주택(2), 아파트(3), 오피스텔(4)
# 직업 유형 : 자영업(1), 사무직(2), 서비스(3), 전문직(4), 기타

user_data <- read.csv("../data/user_data.csv", header=T)
View(user_data)

table(user_data$house_type)

# house_type2컬럼을 새로 추가해서 단독과 다가구는0으로, 아파트와 오피스텔은 1로 변환
house_type2 <- ifelse(user_data$house_type==1 | user_data$house_type==2, 0, 1)
user_data$house_type2 <- house_type2
table(user_data$house_type2)


## 데이터 구조 변경(wide type, long type) : melt()=>long형으로 변경, cast()=>wide형으로
# reshape, reshape2, tidyr, ....
install.packages("reshape2")
library(reshape2)

str(airquality)
head(airquality)

ml <- melt(airquality, id.vars = c("Month", "Day"))
View(ml)

ml2 <- melt(airquality, id.vars = c("Month", "Day"), variable.name = "climate_var",
           value.name = "climate_val")
View(ml2)

?dcast
dc1 <- dcast(ml2, Month+Day ~ climate_var)
View(dc1)

## 예제1
data <- read.csv("../data/data.csv")
View(data)

# 날짜별로 컬럼을 생성해서 wide하게 변경
buy_data <- dcast(data, Customer_ID ~ Date)
buy_data

buy_data1 <- dcast(data, Customer_ID ~ Date, mean)
buy_data1

# 다시 long 형으로
buy_data2 <- melt(buy_data1, id.vars = "Customer_ID", variable.name = "Date",
                  value.name = "Buy")
buy_data2

## 예제2
data <- read.csv("../data/pay_data.csv")
View(data)

# product_type을 wide하게 변경
type_data <- dcast(data, user_id ~ product_type)
View(type_data)

data2 <- dcast(data, user_id+pay_method+price~product_type)
View(data2)

########################################################################
# 주제 : 자살 방지를 위한 도움의 손길은 누구에게?

library(dplyr)
data <- read.csv("../data/2019_suicide.csv")
data
str(data)

man <- data[21:39, c(3, 4, 5)]
man

woman <- data[40:58, c(4, 5)]
woman

total <- cbind(man, woman)
total

names(total) <- c("연령", "남자사망자수", "남자사망률", "여자사망자수", "여자사망률")
total

total$age <- 0
step <- 5
for(i in 1:19){
  total[i, "age"] <- step
  step <- step + 5
}
total

# 20살 이하는 10, 21 ~ 30는 20, ...
total$age2[total$age<=20] <- 10
total$age2[total$age>20 & total$age<=30] <- 20
total$age2[total$age>30 & total$age<=40] <- 30
total$age2[total$age>40 & total$age<=50] <- 40
total$age2[total$age>50 & total$age<=60] <- 50
total$age2[total$age>60 & total$age<=70] <- 60
total$age2[total$age>70 & total$age<=80] <- 70
total$age2[total$age>80 & total$age<=90] <- 80
total$age2[total$age>90] <- 90

total

total$여자사망률 <- as.numeric(total$여자사망률)
total$남자사망률 <- as.numeric(total$남자사망률)

total %>% group_by(age2) %>% summarise(sd_man=sd(남자사망률), sd_woman=sd(여자사망률))


######################################################################################

#### MySQL 연동 ####
install.packages("rJava")
install.packages("DBI")
install.packages("RMySQL")

library(RMySQL)

conn <- dbConnect(MySQL(), dbname="rtest", user="root", password="1111", host="127.0.0.1")
conn

dbListTables(conn)

result <- dbGetQuery(conn, "select count(*) from score")
result
class(result)

dbListFields(conn, "score")

# DML
dbSendQuery(conn, "delete from score where student_no=1")

result <- dbGetQuery(conn, "select count(*) from score")
result

# 파일로부터 데이터를 읽어들여 DB에 저장
dbSendQuery(conn, "drop table score")
dbListTables(conn)

file_score <- read.csv("../data/score.csv", header=T)
file_score

dbWriteTable(conn, "score", file_score, row.names=F)

result <- dbGetQuery(conn, "select * from score")
result

dbDisconnect(conn)


#### sqldf : R + sql ####
detach("package:RMySQL", unload=T)

install.packages("sqldf")
library(sqldf)

head(iris)
sqldf("select * from iris limit 6")


iris %>% select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, Species) %>% 
  arrange(Species) %>% head(10)
sqldf("select * from iris order by species limit 10")


iris %>% summarise(sum=sum(Sepal.Length))
sqldf('select sum("Sepal.Length") from iris')

unique(iris$Species)
sqldf("select distinct species from iris")

table(iris$Species)
sqldf("select species, count(*) from iris group by species")











