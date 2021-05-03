#### 키보드 입력 ####
# scan() : 벡터 입력
# edit() : 데이터 프레임 입력

a <- scan()   # 숫자 형식의 데이터를 입력한다. 입력을 중단할 경우 빈칸에 엔터
a

b <- scan(what=character())
b

df <- data.frame()
df <- edit(df)
df


#### 파일 입력 ####
# read.csv()
# read.table()
# read.xlsx()
# read.spss()

?read.table

student <- read.table("../data/student.txt")
student

student1 <- read.table(file="../data/student1.txt", header=T)
student1

student2 <- read.table(file.choose(), header = T, sep=";")
student2 

student3 <- read.table("../data/student3.txt", header=T, na.strings = "-")
student3

student3 <- read.table("../data/student3.txt", header=T, na.strings = c("-", "+", "&"))
student3

### read.xlsx()
install.packages("xlsx")

library(rJava)
library(xlsx)

# studentx <- read.xlsx(file.choose(), sheetIndex = 1, encoding="UTF-8")
studentx <- read.xlsx(file.choose(), sheetName = "emp2", encoding="UTF-8")
studentx


### read.spss()
install.packages("foreign")

library(foreign)

raw_welfare <- read.spss("../data/Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
raw_welfare


#### 화면 출력 ####
# 변수명
# (식)
# print()
# cat()

x <- 10
y <- 20
z <- x + y

z
(z <- x + y)

print(z)
print(z <- x + y)

# print("x + y의 결과는", z, " 입니다")
cat("x + y의 결과는", z, " 입니다")



#### 파일 출력 ####
# write.csv()
# write.table()
# write.xlsx()

studentx <- read.xlsx("../data/studentexcel.xlsx", sheetName = "emp2", encoding="UTF-8")
studentx
class(studentx)

write.table(studentx, "../data/stud1.txt")
write.table(studentx, "../data/stud2.txt", row.names = F )
write.table(studentx, "../data/stud3.txt", row.names = F, quote = F)

write.csv(studentx, "../data/stud4.txt", row.names = F, quote = F)

library(rJava)
library(xlsx)
write.xlsx(studentx, "../data/stud5.xlsx")


#### rda파일 출력 ####
# save()
# load()

save(studentx, file="../data/stud6.rda")

rm(studentx)
studentx

load("../data/stud6.rda")
studentx


#### sink() ####

?data
data()

data(iris)
head(iris)
tail(iris)
str(iris)

sink("../data/iris.txt")
head(iris)
tail(iris)
str(iris)

sink()

head(iris)





