#### Power Analysis ####
# 적정한 표본의 갯수를 산출
# cohen's d (effective size) : 두 집단의 평균 차이를 두 집단의 표준편차의 합으로 나눠준다.

ky <- read.csv("../data/KY.csv", header=T)
View(ky)

table(ky$group)

mean.1 <- mean(ky$score[which(ky$group==1)])
mean.2 <- mean(ky$score[ky$group == 2])
cat(mean.1, mean.2)

sd.1 <- sd(ky$score[ky$group == 1])
sd.2 <- sd(ky$score[ky$group == 2])
cat(sd.1, sd.2)

effective_size <- abs(mean.1 - mean.2) / sqrt((sd.1^2 + sd.2^2) / 2)
effective_size

install.packages("pwr")
library(pwr)

pwr.t.test(d=effective_size, alternative = "two.sided", type="two.sample",
           power=.8, sig.level = .05)



#### 사례1 : 두 집단 간의 평균 비교 ####

install.packages("moonBook")
library(moonBook)

# 경기도에 소재한 대학병원에서 2년동안 내원한 급성 관상동맥증후군 환자 데이터
?acs

head(acs)
str(acs)
summary(acs)

## 가설 설정 
# 주제 : 두 집단(남성, 여성)의 나이 차이를 알고 싶다.
# 귀무가설 : 남성과 여성의 평균 나이에 대해 차이가 없다.
# 대립가설 : 남성과 여성의 평균 나이에 대해 차이가 있다.

mean.man <- mean(acs$age[acs$sex == "Male"])
mean.woman <- mean(acs$age[acs$sex == "Female"]) 
cat(mean.man, mean.woman)


### 정규분포 테스트
moonBook::densityplot(age ~ sex, data=acs)

## 가설 설정
# 주제 : 두 집단의 정규분포 여부를 알고 싶다
# 귀무 가설 : 두 집단이 정규 분포이다.
# 대립 가설 : 두 집단이 정규 분포가 아니다.

shapiro.test(acs$age[acs$sex == "Male"])
shapiro.test(acs$age[acs$sex == "Female"])


### 등분산 테스트
# 주제 : 두 집단의 등분산 여부를 알고 싶다
# 귀무 가설 : 두 집단이 등분산이다.
# 대립 가설 : 두 집단이 등분산이 아니다.

var.test(age ~ sex, data=acs)

### 가설 검정
# MWW 검정
wilcox.test(age ~ sex, data=acs)

# t-test 
?t.test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal=T)

# welch's test
t.test(age ~ sex, data=acs, alt="two.sided", var.equal=F)



#### 사례2 : 집단이 한개인 경우 ####
### A회사의 건전지 수명이 1000시간일때 무작위로 뽑아 10개의 건전지 수명에 대해
###샘플이 모집단과 다르다고 할 수 있는가?

# 귀무가설 : 표본의 평균은 모집단의 평균과 같다.
# 대립가설 : 표본의 평균은 모집단의 평균과 다르다.

a <- c(980, 1008, 968, 1032, 1012, 1002, 996, 1017, 990, 955)

mean.a <- mean(a)
mean.a

## 정규 분포 여부
shapiro.test(a)

t.test(a, mu=1000, alt="two.sided")
t.test(a, mu=1000, alt="less")
t.test(a, mu=1000, alt="greater")


### 어떤 학급의 수학 평균성적이 55점이었다.
### 0교시 수업을 하고 다시 성적을 살펴보았다.

b <- c(58, 49, 39, 99, 32, 88, 62, 30, 55, 65, 44, 55, 57, 53, 88, 42, 39)
mean(b)

shapiro.test(b)

t.test(b, mu=55, alt="two.sided")
t.test(b, mu=55, alt="greater")


#### 사례3 : Paired Sample T-Test ####
### 같은 집단에 대해 수면시간의 증가량 차이가 나는지 알고싶다.

str(sleep)
View(sleep)

### 먼저 ID를 제거하여 서로 다른 두 집단으로 테스트를 해보자.
sleep2 <- sleep[, -3]
View(sleep2)

# 두 집단의 수면증가량 평균은?
tapply(sleep2$extra, sleep2$group, mean)

# 정규분포
shapiro.test(sleep2$extra[sleep2$group == 1])
with(sleep2, shapiro.test(extra[group == 1]))

shapiro.test(sleep2$extra[sleep2$group == 2])

# 등분산
var.test(extra ~ group, sleep2)

# t-test
t.test(extra ~ group, data=sleep2, paired=F, var.equal=T)


### Paired sample t-test
t.test(extra ~ group, data=sleep, paired=T, var.equal=T)

### 그래프 그리기
before <- subset(sleep, group==1, extra)
before

after <- subset(sleep, group==2, extra)
after

#s_graph <- cbind(before, after)
#s_graph

install.packages("PairedData")
library(PairedData)

s_graph <- paired(before, after)
s_graph

plot(s_graph, type="profile") + theme_bw()



#### 실습1 ####
### dummy : 0은 군을 나타내고, 1은 시를 나타낸다.
### 주제 : 시와 군에 따라서 합계 출산율의 차이가 있는지 알아보려고 한다.
### 귀무가설 : 차이가 없다.
### 대립가설 : 차이가 있다.

mydata <- read.csv("../data/independent.csv")
View(mydata)
str(mydata)

gun.mean <- with(mydata, mean(birth_rate[dummy == 0]))
si.mean <- with(mydata, mean(birth_rate[dummy == 1]))
cat(gun.mean, si.mean)

with(mydata, shapiro.test(birth_rate[dummy == 0]))
with(mydata, shapiro.test(birth_rate[dummy == 1]))

wilcox.test(birth_rate ~ dummy, data=mydata)

t.test(birth_rate ~ dummy, data=mydata)


#### 실습2 ####
### am : 0은 오토, 1은 수동
### mpg : 연비
### 주제 : 오토나 수동에 따라 연비가 같을까? 다를까?

str(mtcars)
head(mtcars)

a_mpg <- mean(mtcars$mpg[mtcars$am == 0])
m_mpg <- mean(mtcars$mpg[mtcars$am == 1])
cat(a_mpg, m_mpg)

shapiro.test(mtcars$mpg[mtcars$am == 0])
shapiro.test(mtcars$mpg[mtcars$am == 1])

var.test(mtcars[mtcars$am == 1, 1], mtcars[mtcars$am == 0, 1])

t.test(mpg ~ am, data=mtcars, var.equal=T, alt="less")



#### 실습3 ####
### 쥐의 몸무게가 전과 후의 차이가 있는지 없는지 알고싶다.

data <- read.csv("../data/pairedData.csv")
data

# data를 long형으로 변경
library(reshape2)

data1 <- melt(data, id=("ID"), variable.name = "GROUP",
              value.name = "RESULT")
data1

# 구조를 바꾸는 또다른 방법
install.packages("tidyr")
library(tidyr)

?gather
data2 <- gather(data, key="GROUP", value="RESULT", -ID)
data2

shapiro.test(data2$RESULT[data2$GROUP == "before"])
shapiro.test(data2$RESULT[data2$GROUP == "After"])

t.test(RESULT ~ GROUP, data=data2, paired=T)

?t.test
# long형으로 바꾸지 않아도 사용 가능
t.test(data$before, data$After, paired = T)

# 그래프
before <- subset(data2, GROUP=="before", RESULT)
before
after <- subset(data2, GROUP=="After", RESULT)
after

data3 <- paired(before, after)
data3
plot(data3, type="profile") + theme_bw()

moonBook::densityplot(RESULT ~ GROUP, data=data2)


#### 실습4 ####
### 주제 : 시별로 2010년도와 2015년도의 출산율 차이가 있는가?

data <- read.csv("../data/paired.csv")
View(data)
str(data)

data2 <- gather(data, key="GROUP", value="RESULT", -c(ID, cities))
data2

with(data2, shapiro.test(RESULT[GROUP=="birth_rate_2010"]))
with(data2, shapiro.test(RESULT[GROUP=="birth_rate_2015"]))

wilcox.test(RESULT ~ GROUP, data=data2, paired=T )

t.test(RESULT ~ GROUP, data=data2, paired=T)



#### 실습5 ####
### https://www.kaggle.com/kappernielsen/independent-t-test-example
### 주제1 : 남녀별로 각 시험에 대해 평균 차이가 있는지 알고 싶다.
### 주제2 : 같은 사람에 대해서 성적의 차이가 있는지 알고 싶다.
###   - 첫번째 시험(G1)과 세번째 시험(G3)을 사용

mat <- read.csv("../data/student-mat.csv", header=T)
str(mat)
View(mat)

summary(mat$G1)
summary(mat$G2)
summary(mat$G3)

table(mat$sex)

### 남녀별로 세 번의 시험 평균을 비교해보자.
library(dplyr)

mat %>% select(sex, G1, G2, G3) %>% group_by(sex) %>%
  summarise(mean_g1=mean(G1), mean_g2=mean(G2), mean_g3=mean(G3),
            cnt_g1=n(), cnt_g2=n(), cnt_g3=n(),
            sd_g1=sd(G1), sd_g2=sd(G2), sd_g3=sd(G3))


shapiro.test(mat$G1[mat$sex=="M"])
shapiro.test(mat$G1[mat$sex=="F"])

shapiro.test(mat$G2[mat$sex=="M"])
shapiro.test(mat$G2[mat$sex=="F"])

shapiro.test(mat$G3[mat$sex=="M"])
shapiro.test(mat$G3[mat$sex=="F"])

var.test(G1 ~ sex, data=mat)
var.test(G2 ~ sex, data=mat)
var.test(G3 ~ sex, data=mat)

t.test(G1 ~ sex, data=mat, var.equal=T, alt="two.sided")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="two.sided")
t.test(G3 ~ sex, data=mat, var.equal=T, alt="two.sided")

t.test(G1 ~ sex, data=mat, var.equal=T, alt="less")
t.test(G2 ~ sex, data=mat, var.equal=T, alt="less")
t.test(G3 ~ sex, data=mat, var.equal=T, alt="less")

wilcox.test(G1 ~ sex, data=mat)
wilcox.test(G2 ~ sex, data=mat)
wilcox.test(G3 ~ sex, data=mat)

# 여기서는 t-test의 결과로 해석하면 된다.

### 같은 학생 입장에서 G1과 G3에 대해 변화가 있었는지 확인
mat %>% select(G1, G3) %>% summarise(mean_g1=mean(G1), mean_g3=mean(G3))

# data를 long type으로 변경
library(tidyr)
mydata <- gather(mat, key="GROUP", value="RESULT", "G1", "G3")
View(mydata)

t.test(mydata$RESULT ~ mydata$GROUP, data=mydata, paired=T)

wilcox.test(mydata$RESULT ~ mydata$GROUP, data=mydata, paired=T)

# 변형하지 않고 원본으로 사용
t.test(mat$G1, mat$G3, paired = T)












