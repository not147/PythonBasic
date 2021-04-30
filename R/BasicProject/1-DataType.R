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

















