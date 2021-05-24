#### 1. 단순 회귀 분석 ####
# y = ax + b

str(women) # 미국 여성을 대상으로 키와 몸무게 조사(30~39세) : 인치와 파운드
women

plot(weight ~ height, data=women)

fit <- lm(weight ~ height, data=women)
fit

abline(fit, col="blue")
summary(fit)

cor.test(women$weight, women$height)
0.9954948^2

62*3.45 - 87.52


# 4가지 조건을 확인하기 위한 방법
plot(fit)

par(mfrow = c(2, 2))
plot(fit)


### 다항 회귀 분석(Polynomial Regression)
par(mfrow = c(1, 1))
plot(weight ~ height, data=women)
abline(fit, col="blue")

fit2 <- lm(weight ~ height + I(height^2), data=women)
fit2

par(mfrow = c(2, 2))
plot(fit2)

par(mfrow = c(1, 1))
plot(weight ~ height, data=women)
lines(women$height, fitted(fit2), col="red")

summary(fit2)

### 정규 분포 확인
shapiro.test(resid(fit))
shapiro.test(resid(fit2))

###########################################################

#### 실습1 ####
mydata <- read.csv("../data/regression.csv")
View(mydata)

# social_welfare : 사회 복지 시설
# active_firms : 사업체 수
# urban_park : 도시 공원
# doctor : 의사
# tris : 폐수 배출 업소
# kindergarten : 유치원

# 종속 변수 : birth_rate
# 독립 변수 : kindergarten

## 가설 : 유치원 수가 많은 지역에 합계 출산율도 높은가?
# 또는 합계 출산율이 유치원 수에 영향을 받는가?

attach(mydata)

fit <- lm(birth_rate ~ kindergarten, data=mydata)
summary(fit)

par(mfrow = c(2, 2))
plot(fit)

shapiro.test(resid(fit))

fit2 <- lm(log(birth_rate) ~ log(kindergarten), data=mydata)
summary(fit2)

plot(fit2)

shapiro.test(resid(fit2))

# 시, 군, 구와 관계가 있을까?
fit3 <- lm(birth_rate ~ dummy, data=mydata)
summary(fit3)



#### 실습2 ####
# 출처 : www.kaggle.com : House sales price in Kings count, USA

house <- read.csv("../data/kc_house_data.csv", header=T)
View(house)

## 주제 : 거실의 크기와 집 가격이 서로 관계가 있는가?
# 종속 변수 : price
# 독립 변수 : sqft_living

fit <- lm(price ~ sqft_living, data=house)
summary(fit)

par(mfrow = c(2, 2))
plot(fit)

options("scipen" = 100)
plot(fit)

plot(house$sqft_living, house$price)

### 다중 회귀
# y = a1x2 + a2x2 + a3x3 + b

# 종속 변수 : price
# 독립 변수 : sqft_living, floors,  waterfront

fit2 <- lm(price ~ sqft_living + floors + waterfront, data=house)
summary(fit2)

### 표준화 계수 : 변수들간의 영향력 확인
install.packages("lm.beta")
library(lm.beta)

fit3 <- lm.beta(fit2)
summary(fit3)


#### 실습3 ####

### 더미 변수
# 값이 오직 "0"과 "1"로만 이루어진 데이터
# 이산형/범주형 변수를 연속형 변수처럼 사용
# 필요한 더미변수의 갯수는 범주의 갯수 - 1

### 다중 공선성
# 원인 : 독립 변수들끼리 너무 많이 겹쳐서 발생하는 문제
# 확인 방법
#   1) 산포도, 상관 계수 : 상관 계수가 0.9를 넘게 되면 다중 공선성 문제
#   2) VIF(Variance Inflation Factor) : 분산 팽창 지수  
#       - 일반적으로 10보다 크면 문제가 있다고 판단(연속형 변수)
#       - 더미변수일 경우에는 3이상이면 문제가 있다고 본다.
#       - sqrt(vif) > 2
# 해결 방법
#   1) 변수를 뺀다.
#   2) 주성분 분석
#   3) ...

house <- read.csv("../data/kc_house_data.csv", header=T)
View(house)

# 독립 변수 : sqft_living, bathrooms, sqft_lot, floors

# 변수들간의 상관 관계 확인
attach(house)

x <- cbind(sqft_living, bathrooms, sqft_lot, floors)
cor(x)

cor(x, price)

reg1 <- lm(price ~ sqft_living, data=house)
summary(reg1)

reg2 <- lm(price ~ sqft_living + floors, data=house)
summary(reg2)

# 조절변수(interactive term, 상호 변수, 교호 변수)
reg2_1 <- lm(price ~ sqft_living + floors + sqft_living*floors, data=house)
summary(reg2_1)

install.packages("car")
library(car)

vif(reg2_1)


x <- cbind(floors, sqft_above, sqft_basement)
cor(x)


#### 실습4 ####
View(state.x77)

states <- as.data.frame(state.x77[, c("Murder", "Population", "Illiteracy", "Income", "Frost")])
states

fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
summary(fit)

# 다중 공선성
sqrt(vif(fit))

### 이상 관측치
#     1) 이상치(outlier) : 표준 편차보다 2배 이상 크거나 작은 값
#     2) 큰 지레점(High leverage points) : p(절편을 포함한 인수들의 갯수) / n의 값이 2~3배 이상되는 
#       관측치 : 5 / 50 = 0.1
#     3) 영향 관측치(Influential Observation, Cook's D)
#       독립변수의 수 / (샘플 수 - 예측 인자의 수 - 1) : 4 / (50 - 4 - 1) = 0.1
#       이 값보다 클 경우

par(mfrow = c(1, 1))
influencePlot(fit, id=list(method="identify"))


#### 회귀 모델의 교정 ####
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost, data=states)
summary(fit)

par(mfrow = c(2, 2))
plot(fit)

shapiro.test(resid(fit))

### 정규성을 만족하지 않을 때(결과 변수에 람다 승을 해 준다.)
powerTransform(states$Murder)
# -2, -1, -0.5, 0, 0.5, 1, 2

summary(powerTransform(states$Murder))


### 선형성을 만족하지 않을 때
boxTidwell(Murder ~ Population + Illiteracy, data=states)

### 등분산을 만족하지 않을 때
ncvTest(fit) # 등분산 여부 확인

spreadLevelPlot(fit)


#### 회귀 모델의 선택 ####
# AIC(Akaike's Information Criterion)
# Backward Stepwise Regression
#   모든 독립변수를 대상으로 해서 하나씩 빼는 방법

# Forward Stepwise Regression
#   변수를 하나씩 추가하면서 AIC값을 측정

fit1 <- lm(Murder ~ ., data=states)
summary(fit1)


fit2 <- lm(Murder ~ Population + Illiteracy, data=states)
summary(fit2)

AIC(fit1, fit2)

## Backward Stepwise Regression
full.model <- lm(Murder ~ ., data=states)
reduced.model <- step(full.model, direction = "backward")
reduced.model


## Forward Stepwise Regression
min.model <- lm(Murder ~ 1, data=states)
fwd.model <- step(min.model, direction = "forward",
                  scope=(Murder ~ Population + Illiteracy + Income + Frost))

# All Subset Regression
install.packages("leaps")
library(leaps)

result <- regsubsets(Murder ~ ., data=states, nbest=4)
par(mfrow = c(1, 1))
plot(result, scale="adjr2")


#### 실습 예제1 ####
# 가장 영향력있는 변수들은 무엇인가?
# 정규성 검증, 등분산성 검증, 다중공선성 검증
# 독립변수들이 출산율과 관계가 있는가?

mydata <- read.csv("../data/regression.csv")
View(mydata)
str(mydata)

mydata1 <- mydata[, -1]
head(mydata1)

reg1 <- lm(birth_rate ~ ., data=mydata1)
summary(reg1)

# cultural_center 와 urban park는 제외
reg2 <- lm(birth_rate ~ social_welfare + active_firms + pop + doctors + tris + kindergarten + dummy, 
           data=mydata)
summary(reg2)

# backward
full.model <- lm(birth_rate ~ ., data=mydata1)
reduced.model <- step(full.model, direction = "backward")
reduced.model

reg3 <- lm(birth_rate ~ social_welfare + active_firms + pop  + tris + kindergarten, 
           data=mydata)
summary(reg3)

par(mfrow = c(2, 2))
plot(reg2)
plot(reg3)

# 정규성 검증
shapiro.test(resid(reg2))

# 정규성 교정
library(car)
summary(powerTransform(mydata$birth_rate))

reg4 <- lm(log(birth_rate) ~ social_welfare + active_firms + 
             pop + doctors + tris + kindergarten + dummy, data=mydata)
summary(reg4)
shapiro.test(resid(reg4))

plot(reg4)

# 다중 공선성
sqrt(vif(reg1))
sqrt(vif(reg2))
sqrt(vif(reg3))
sqrt(vif(reg4))

# 등분산성
ncvTest(reg1)
ncvTest(reg2)
ncvTest(reg3)
ncvTest(reg4)

spreadLevelPlot(reg4)

#### 실습 예제2 ####
### 서울시 자전거 분석

## 데이터 준비
data <- read.csv("../data/SeoulBikeData.csv")
summary(data)
str(data)

library(dplyr)
## 1. 시간대별로 평균 몇 대가 대여 되었을까?
table(data$Hour)

result1 <- data %>% group_by(Hour) %>%
  summarise(count=mean(Rented.Bike.Count)) %>%
  arrange(desc(count))

result1

## 2. 위의 결과를 시각화
library(ggplot2)

ggplot(result1, aes(Hour, count)) +
  geom_line(color="blue", size=2) +
  geom_vline(xintercept = 8, size=2, color="red") + 
  geom_vline(xintercept = 18, size=2, color="red") +
  annotate(geom="text", x=6, y=1100, label="출근") +
  annotate(geom="text", x=16, y=1500, label="퇴근")


## 3. 2016년 1월 1일은 금요일이었다. Date변수에서 요일을 뽑아서 파생변수 만들기
fnWeek <- function(n){
  w = n %% 7;
  
  if(w == 0){
    ret = "FRI"
  }else if(w == 1){
    ret = "SAT"
  }else if(w == 2){
    ret = "SUN"
  }else if(w == 3){
    ret = "MON"
  }else if(w == 4){
    ret = "TUE"
  }else if(w == 5){
    ret = "WED"
  }else if(w == 6){
    ret = "THU"
  }
  
  return(ret)
}

View(data)

d <- as.Date(data$Date, "%d/%m/%Y") - as.Date("2016/01/01")
class(as.integer(d))

data$weekdays <- unlist(lapply(as.integer(d), fnWeek))
str(data)

## 4. 요일별로 평균 몇 대가 대여되었을까?
week.mean <- data %>% group_by(weekdays) %>%
  summarise(count=mean(Rented.Bike.Count)) %>% arrange(desc(count))

week.mean

## 5. 위의 결과를 시각화
ggplot(week.mean, aes(reorder(weekdays, count), count, fill=weekdays)) + 
  geom_col() + coord_flip()

## 6. 요일 별로 시간대별 그래프로 시각화 
week.date <- data %>% select(weekdays, Hour, Rented.Bike.Count) %>%
  group_by(weekdays, Hour) %>%
  summarise(mean = mean(Rented.Bike.Count))

week.date
week.date %>% filter(weekdays=='MON')
week.date[which(week.date$weekdays == "MON"), ]

a <- ggplot(week.date[which(week.date$weekdays == "MON"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("MON")
b <- ggplot(week.date[which(week.date$weekdays == "TUE"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("TUE")
c <- ggplot(week.date[which(week.date$weekdays == "WED"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("WED")
d <- ggplot(week.date[which(week.date$weekdays == "THU"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("THU")
e <- ggplot(week.date[which(week.date$weekdays == "FRI"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("FRI")
f <- ggplot(week.date[which(week.date$weekdays == "SAT"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("SAT")
g <- ggplot(week.date[which(week.date$weekdays == "SUN"), ], aes(Hour, mean)) +
  geom_line() + ggtitle("SUN")

library(gridExtra)
grid.arrange(a, b, c, d, e, f, g, nrow=2, ncol=4)

# 또 다른 방법
ggplot(week.date, aes(Hour, mean)) + geom_line() + facet_wrap(~weekdays)


## 7. 선형 분석
# 각 변수들이 자전거 대여 횟수와 관련이 있는가?
# 온도에 따라 몇 대의 자전거가 대여 될까?(예를 들어 온도가 23도일때 자전거 대여횟수는 998대이다.)

par(mfrow = c(1, 1))
plot(x=data$Temperature.C., y=data$Rented.Bike.Count)

linear_reg <- lm(Rented.Bike.Count ~ Temperature.C., data=data)
summary(linear_reg)

a = 29.0811
b = 329.9525
abline(a=b, b=a, col="red")

y = a * 23 + b
cat("온도가 23도일 때, 예측되는 대여 횟수는 ", y)










