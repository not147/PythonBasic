#### 기본 내장 그래프 ####

### plot()
# plot(y축 데이터, 옵션)
# plot(x축 데이터, y축 데이터, 옵션)

y <- c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5)
plot(y)

x <- 1:10
y <- 1:10
plot(x, y)
?plot
# type="p", "l", "b", "o", "n"
# cex : 점의 크기를 비율로 설정
# lty : "blank", "solid", "dashed", "dotted", "dotdash", "longdash", "twodash"
plot(x, y, xlim=c(0, 20), ylim=c(0, 30), main="Graph", type="p", pch=5,
     cex=.3, col="red", lty="solid")

str(cars)
head(cars)
plot(cars, type="o")

# 같은 속도일때 제동거리가 다를 경우 대체적인 추세를 알기 어렵다.
# 속도에 대한 평균 제동거리를 구해서 그래프로 그려보자.

plot(tapply(cars$dist, cars$speed, mean), type="o", xlab="speed", ylab="dist")


### points()
with(iris, {
  plot(Sepal.Width, Sepal.Length) 
  plot(Petal.Width, Petal.Length)
})

with(iris, {
  plot(Sepal.Width, Sepal.Length)
  points(Petal.Width, Petal.Length, col="blue")
})


### lines()
plot(cars)
lines(lowess(cars))


### barplot(), hist(), pie(), mosaicplot(), pair(), persp(), contour(), ...


### 그래프 배열
head(mtcars)
?mtcars
str(mtcars)

# 그래프 4개 동시에 그리기
par(mfrow=c(2, 2))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)
boxplot(mtcars$wt)

par(mfrow=c(1, 1))
plot(mtcars$wt, mtcars$mpg)

# 행 또는 열마다 그래프 개수를 다르게 설정
?layout
layout(matrix(c(1, 1, 2, 3), 2, 2, byrow=T))
plot(mtcars$wt, mtcars$mpg)
plot(mtcars$wt, mtcars$disp)
hist(mtcars$wt)

par(mfrow=c(1, 1))


#### 특이한 그래프 ####

### arrows
x <- c(1, 3, 6, 8, 9)
y <- c(12, 56, 78, 32, 9)

plot(x, y)
arrows(3, 56, 1, 12)
text(4, 40, "이것은 샘플입니다", srt=60)

### 꽃잎 그래프
x <- c(1, 1, 1, 2, 2, 2, 2, 2, 2, 3, 3, 4, 5, 6, 6, 6)
y <- c(2, 1, 4, 2, 3, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1)

plot(x, y)

?sunflowerplot
z <- data.frame(x, y)
sunflowerplot(z)


### 별 그래프
# 데이터의 전체적인 윤곽을 살펴보는 그래프
# 데이터 항목에 대한 변화의 정도를 한눈에 파악
mtcars
str(mtcars)

stars(mtcars[1:4], flip.labels = F, key.loc=c(13, 2.0),
      draw.segments = T)


### symbols
x <- c(1, 2, 3, 4, 5)
y <- c(2, 3, 4, 5, 6)
z <- c(10, 5, 100, 20, 10)

symbols(x, y, z)


#### ggplot2 ####
# http://www.r-graph-gallery.com/ggplot2-package.html

# 레이어 지원
# 1) 배경 설정
# 2) 그래프 추가(점, 선, 막대,...)
# 3) 설정 추가(축 범위, 범례, 색, 표식, ...)

install.packages("ggplot2")
library(ggplot2)

### 산포도
head(mpg)

ggplot(data=mpg, aes(x=displ, y=hwy))
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

ggplot(mpg, aes(displ, hwy)) + geom_point() + xlim(3, 6) + ylim(10, 30)

# midwest 데이터를 이용하여 전체인구(poptotal)와 아시아 인구(popasian)간에 
# 어떤 관계가 있는지 알아보려고 한다.
# x축은 전체인구, y축은 아시안 인구로 된 산포도를 작성
# 단, 전체 인구는 30만명 이하, 아시아 인구는 1만명 이하인 지역만 산포도 표시

options(scipen=99)  # 지수를 숫자로 표현

ggplot(midwest, aes(poptotal, popasian)) + geom_point() + xlim(0, 300000) +
  ylim(0, 10000)


### 막대 그래프 : geom_col(), 히스토그램 : geom_bar()
library(dplyr)

# mpg데이터에서 구동방식(drv)별로 고속도로 평균 연비를 조회하고 그 결과를 
# 막대 그래프로 표현

df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy=mean(hwy))

ggplot(df_mpg, aes(drv, mean_hwy)) + geom_col()
ggplot(df_mpg, aes(reorder(drv, mean_hwy), mean_hwy)) + geom_col()
ggplot(df_mpg, aes(reorder(drv, -mean_hwy), mean_hwy)) + geom_col()

ggplot(mpg, aes(drv)) + geom_bar()
ggplot(mpg, aes(hwy)) + geom_bar()

# 어떤 회사에서 생산한 "SUV"차종의 도시 연비가 높은지 알아보려고 한다.
# "SUV"차종을 대상으로 평균 cty가 가장 높은 회사 다섯 곳을 그래프로 출력

df_mpg <- mpg %>% filter(class=="suv") %>% group_by(manufacturer) %>%
  summarise(mean_cty=mean(cty)) %>% arrange(desc(mean_cty)) %>% head(5)
df_mpg

ggplot(df_mpg, aes(reorder(manufacturer, mean_cty), mean_cty)) + geom_col()


# 자동차 중에서 어떤 종류(class)가 가장 많은지 알아보려고 한다.
# 자동차 종류별 빈도를 그래프로 출력

table(mpg$class)
ggplot(mpg, aes(class)) + geom_bar()


### 선 그래프 : geom_line()
str(economics)
head(economics)
tail(economics)

ggplot(economics, aes(date, unemploy)) + geom_line()
ggplot(economics, aes(date, psavert)) + geom_line()


### 상자 그래프 : geom_boxplot()
ggplot(mpg, aes(drv, hwy)) + geom_boxplot()

# mpg 데이터에서 class가 "compact", "subcompact", "suv"인 자동차의 cty가
# 어떻게 다른지 비교해 보려고 한다.
# 이 세 차종의 도시연비를 비교

class_mpg <- mpg %>% filter(class %in% c("compact", "subcompact", "suv")) %>% 
  select(class, cty)
class_mpg

ggplot(class_mpg, aes(class, cty)) + geom_boxplot()

### 참고
# 치트 시트 : Help > Cheatsheets > Data Visualization with ggplot2


### iris 샘플

str(iris)

# 꽃받침(Sepal)의 길이에 따라서 폭의 크기가 어떤 관계인지 분포를 확인
# pch : 0~127
ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(colour="red", pch=2, size=3)


ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(colour=c("red", "green", "blue")[iris$Species], 
             pch=c(0, 2, 20)[iris$Species], 
             size=c(1, 3, 5)[iris$Species])


ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, 
                 size=Petal.Length, color=Species)) + geom_point()


graph <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) + 
  geom_point(colour=c("red", "green", "blue")[iris$Species], 
             pch=c(0, 2, 20)[iris$Species], 
             size=c(1, 3, 5)[iris$Species]) + coord_flip()


# 라벨링
graph + labs(title="꽃받침의 비교",
             subtitle = "꽃받침의 길이에 대해 폭의 크기 확인",
             caption = "주석 달기",
             x = "꽃받침의 길이",
             y = "꽃받침의 폭")


## 같은 y축에 여러 그래프 그리기(선 그래프)
# 1. 순서를 갖는 데이터를 준비
seq <- as.integer(rownames(iris))
iris_data <- cbind(seq=seq, iris)
iris_data

# 2. 각 데이터에 대한 색상 지정(rainbow(), heat.colors(), terrain.colors())
# topo.colors(), cm.colors())

ex = topo.colors(30)
pie(rep(1, 30, col=ex))

# 범례를 위해 이름 준비
cols <- topo.colors(4, alpha=0.5)
names(cols)<- names(iris_data)[2:5]
names(cols)
cols

# wide형을 long형으로 
library(reshape2)

mdata <- melt(iris_data, id.vars = c("seq", "Species"))
mdata

# cex : 선의 두께
g <- ggplot(mdata) + geom_line(aes(x=seq, y=value, color=variable), cex=0.8, show.legend = T)
g

g + scale_color_manual(name="변수명",
                       values = cols[mdata$variable],
                       labels = c("꽃받침의 길이", "꽃받침의 폭", "꽃잎의 길이", 
                                  "꽃잎의 폭"))


# 품종별로 꽃잎의 길이를 확인(상자그림)
ggplot() + geom_boxplot(data=iris, aes(x=Species, y=Petal.Length, fill=Species))


#### Interactive Graph ####
# https://plot.ly/ggplot2

install.packages("plotly")
library(plotly)

p <- ggplot(data=mpg, mapping=aes(displ, hwy, col=drv)) + geom_point()
p
ggplotly(p)


### 시계열 데이터
install.packages("dygraphs")
library(dygraphs)

head(economics)

library(xts)

eco <- xts(economics$unemploy, order.by=economics$date)
eco
class(eco)

dygraph(eco)


#### 지도 그래프 : 단계 구분도, Choropleth map ####
install.packages("ggiraphExtra")
library(ggiraphExtra)

str(USArrests)
head(USArrests)
class(USArrests)

library(tibble)
crime <- rownames_to_column(USArrests, var="state")
head(crime)
str(crime)

crime$state <- tolower(crime$state)
str(crime)


install.packages("maps")
library(ggplot2)

states_map <- map_data("state")
str(states_map)

install.packages("mapproj")
library(mapproj)
?ggChoropleth
ggChoropleth(data=crime, mapping=aes(fill=Murder, map_id=state), 
             map=states_map, interactive = T)

### 대한민국 지도 만들기기
# https://github.com/cardiomoon/kormaps2014

install.packages("devtools")
devtools::install_github("cardiomoon/kormaps2014")
# 라이브러리 실제 위치 : C:\Users\acorn\Documents\R\win-library\4.0
library(kormaps2014)

head(korpop1)
str(korpop1)

head(kormap1)
str(kormap1)


korpop1 <- changeCode(korpop1)
str(korpop1)

# 컬럼 이름 변경
library(dplyr)
korpop1 <- rename(korpop1, pop="총인구_명", name="행정구역별_읍면동")
str(korpop1)

library(ggplot2)
library(ggiraphExtra)

ggChoropleth(data=korpop1, aes(fill=pop, map_id=code, tooltip=name), 
             map=kormap1, interactive = T)



#### Text Mining ####

install.packages("rJava")
# rJava 삭제, Sys.setenv(JAVA_HOME='경로'), rJava 설치

install.packages("memoise")
install.packages("KoNLP") # 직접 설치 안됨

# Rtools 설치
# https://www.facebook.com/notes/r-korea-krugkorean-r-user-group/konlp-%EC%84%A4%EC%B9%98-%EC%9D%B4%EC%8A%88-%EA%B3%B5%EC%9C%A0/1847510068715020/
install.packages("multilinguer")
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))

library(KoNLP)

useNIADic()

extractNoun("아버지가방에들어가신다")
extractNoun("대한민국의 영토는 한반도와 그 부속도서로 한다.")
