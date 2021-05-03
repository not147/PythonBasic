#### 조건문 ####

# 난수 준비
?runif
x <- runif(1)  # 0~1까지의 균일 분포, rnorm()
x

# x가 0.5보다 크면 출력
if(x>0.5){
  print(x)
}

# x가 0.5보다 작으면 1-x를 출력하고 그렇지 않으면 x를 출력
if(x<0.5){
  print(1-x)
}else{
  print(x)
}

if(x < 0.5) print(1-x) else print(x)

### ifelse()
ifelse(x<0.5, 1-x, x)

### 다중 조건
avg <- scan()

if(avg >= 90){
  print("당신의 학점은 A 입니다.")
} else if(avg >= 80){
  print("당신의 학점은 B 입니다.")
} else if(avg >= 70){
  print("당신의 학점은 C 입니다.")
} else if(avg >= 60){
  print("당신의 학점은 D 입니다.")
} else{
  print("당신의 학점은 F 입니다.")
}

### switch(비교문, 실행문1, 실행문2, ...)
a <- "중1"
switch(a, "중1"=print("14살"), "중2"=print("15살"))
switch(a, "중1"="14살", "중2"="15살")

b <- 3
switch(b, "14살", "15살", "16살")

empname = scan(what="")
switch(empname, hong=250, lee=350, kim=200, kang=400)

avg <- scan() %/% 10
result <- switch(as.character(avg), "10"="A", "9"="A", "8"="B", "7"="C", "6"="D", "F")
cat("당신의 학점은 ", result, "입니다.")

### which() : 값의 위치(index)를 찾아주는 함수
# vector에서 사용
x <- c(2:10)
x

which(x == 3)
x[which(x==3)]

# matrix에서 사용
m <- matrix(1:12, 3, 4)
m

?which
which(m%%3 == 0) # 조건에 맞는 값 자체를 반환
which(m%%3 == 0, arr.ind = FALSE)
which(m%%3 == 0, arr.ind = T)

# data.frame에서 사용
no <- c(1: 5)
name <- c("홍길동", "유비", "관우", "장비", "전우치")
score <- c(85, 78, 89, 90, 74)
exam <- data.frame(학번=no, 이름=name, 성적=score)
exam

# 이름이 장비인 사람 검색
which(exam$이름 == "장비")
exam[which(exam$이름 == "장비"), ]
exam[4, ]

# which.max(), which.min() : 숫자에서만 인식
# 가장 높은 점수를 가진 학생은?
which.max(exam$성적)
exam[which.max(exam$성적), ]

### any(), all()

x <- runif(5)
x

# x값들 중에서 0.8이상이 있는가?
any(x >= 0.8)

# x값들이 모두 0.7이하인가?
all(x <= 0.7)



#### 반복문 ####

# 1부터 10까지 합계
sum <- 0
for(i in seq(1, 10)){
  sum <- sum + i
}
sum

sum <- 0
for(i in 1:10) sum <- sum + i
sum



#### 함수 ####

### 인자없는 함수
test1 <- function(){
  x <- 10
  y <- 10
  #return (x*y)
  x*y
}

test1()

### 인자 있는 함수
test2 <- function(x, y){
  a <- x
  b <- y
  return(a-b)
}

test2(10, 20)
test2(y=20, x=10)


### 가변 인수 : ...
test3 <- function(...){
  #print(list(...))
  for(i in list(...)) print(i)
}

test3(10)
test3(10, 20)
test3(10, 20, 30)
test3("3", "홍길동", 30)








