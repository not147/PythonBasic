#### 변수 ####

goods = "냉장고"

# 변수 사용 시 객체 형태로 사용하는 것을 권장
goods.name = "냉장고"
goods.code = "ref001"
goods.price = 600000

goods.name

# 값을 대입할때에는 = 보다는 <- 사용
goods.name <- "냉장고"
goods.code <- "ref001"
goods.price <- 600000

# 데이터 타입 확인
class(goods.name)
class(goods.price)
mode(goods.name)
mode(goods.price)



#### Vector ####

# c()
v <- c(1, 2, 3, 4, 5)
v
class(v)
mode(v)

(v <- c(1, 2, 3, 4, 5))

mode(c(1:5))
class(c(1, 2, 3, 4, "5"))

# seq()
?seq
(seq(from=1, to=10, by=2))
(seq(1, 10, 2))

# rep()
(rep(1:3, 3))

# 벡터의 접근
v <- c(1:50)
v[10:45]
length(v)

v[10 : (length(v)-5)]
v[10 : length(v) -5]

v1 <- c(13, -5, 20:23, 12, -2:3)
v1

v1[1]
v1[c(2, 4)]
v1[c(4, 5:8, 7)]
v1[-1]
v1[-2]
v1[c(-2, -4)]
v1[-c(2, 4)]

# 집합 연산
x <- c(1, 3, 5, 7)
y <- c(3, 5)

union(x, y); setdiff(x, y); intersect(x, y)

# 컬럼명 지정
age <- c(30, 35, 40)
names(age) <- c("홍길동", "임꺽정", "신돌석")

age

# 특정 변수의 데이터 제거
age <- NULL
age

# 벡터 생성의 또다른 표현
x <- c(2, 3)
x <- (2:3)
x



#### Factor ####

gender <- c("man", "woman", "woman", "man", "man")
gender
class(gender)
mode(gender)
is.factor(gender)
plot(gender)

ngender <- as.factor(gender)
ngender
class(ngender)
mode(ngender)
is.factor(ngender)
plot(ngender)
table(ngender)

?factor
gfactor <- factor(gender, levels = c("woman", "man"), ordered=TRUE)
gfactor
plot(gfactor)


#### Matrix ####

# matrix()
m <- matrix((1:5))
m

m <- matrix(c(1:11), nrow=2)
m

m <- matrix(c(1:10), nrow=2, byrow=T)
m

class(m)
mode(m)

# rbind(), cbind()
x1 <- c(3, 4, 50:52)
x2 <- c(30, 5, 6:8, 7, 8)
x1
x2

mr <- rbind(x1, x2)
mr

mc <- cbind(x1, x2)
mc

# matrix 차수 확인
x <- matrix(c(1:9), ncol=3)
x

length(x); nrow(x); ncol(x); dim(x)

# 컬럼명 지정
colnames(x) <- c("one", "two", "three")
x
colnames(x)

# apply()
?apply
apply(x, 1, max)
apply(x, 2, max)
apply(x, 1, sum)
apply(x, 2, sum)


#### data.frame ####

# data.frame()
no <- c(1, 2, 3)
name <- c('hong', 'lee', 'kim')
pay <- c(150.25, 250.18, 300.34)

emp <- data.frame(No=no, NAME=name, PAYMENT=pay)
emp

# read.csv(), read.table(), read.delim()
getwd()

txtemp <- read.table("../data/emp.txt")
txtemp

setwd("../data")
getwd()

txtemp <- read.table("emp.txt", header=T, sep=" ")
txtemp
class(txtemp)

csvemp <- read.csv("emp.csv")
csvemp

csvemp1 <- read.csv("emp.csv", col.name=c("사번", "이름", "급여"))
csvemp1

csvemp2 <- read.csv("emp2.csv", header=F, col.name=c("사번", "이름", "급여"))
csvemp2

aws = read.delim("../data/AWS_sample.txt", sep="#")
head(aws)
View(aws)

# 접근
(aws[1, 1])
x1 <- aws[1:3, 2:4]
x1
x2 <- aws[9:11, 2:4]
x2
class(cbind(x1, x2))
class(rbind(x1, x2))
aws[,1]
aws$AWS_ID
class(aws$AWS_ID)
class(aws$X.)

# 구조 확인
str(aws)

# 기본 통계량
summary(aws)

# apply()
df <- data.frame(x=c(1:5), y=seq(2, 10, 2), z=c("a", "b", "c", "d", "e"))
df

apply(df[,c(1, 2)], 1, sum)
apply(df[,c(1, 2)], 2, sum)

# 데이터의 일부 추출
x1 = subset(df, x >= 3)
x1

x2 = subset(df, x>=2 & y<=6)
x2

# 병합
height <- data.frame(id=c(1, 2), h=c(180, 175))
weight <- data.frame(id=c(1, 2), w=c(80, 75))

user <- merge(height, weight, by.x = "id", by.y = "id" )
user


#### array ####

v <- c(1:12)
v

arr <- array(v, c(4, 2, 3))
arr

# 접근
arr[,,1]
arr[,,2]

# 추출
arr[2, 2, 1]
arr[,,1][2,2]


#### list ####

x1 <- 1
x2 <- data.frame(var1=c(1, 2, 3), var2=c('a', 'b', 'c'))
x3 <- matrix(c(1:12), ncol=2)
x4 <- array(1:20, dim=c(2, 5, 2))

x5 <- list(c1=x1, c2=x2, c3=x3, c4=x4)
x5

x5$c1
x5$c2

list1 <- list(c("lee", "kim"), "이순신", 95)
list1

list1[1]
list1[[1]]
list1[[1]][1]
list1[[1]][2]

list1 <- list("lee", "이순신", 95)
un <- unlist(list1)
un
class(un)

# apply : lapply(), sapply()
# lapply() : apply는 2차원 이상의 데이터만 입력을 받는다.
#           vector를 입력받기 위한 방법으로 사용, 반환형이 list형이다.
# sapply() : 반환형이 matrix 또는 vector로 반환(lapply의 wrapper)

a <- list(c(1:5))
a
b <- list(c(6:10))
b

c <- c(a, b)
c
class(c)

x <- lapply(c, max)
x
x1 <- unlist(x)
x1

y <- sapply(c, max)
y


#### 기타 데이터 타입 ####

## 날짜
Sys.Date()
Sys.time()

a <- '21/05/03'
a
class(a)

b <- as.Date(a)
b
class(b)

c <- as.Date(a, "%y/%m/%d")
c


