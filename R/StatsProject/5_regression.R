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

# 4가지 조건을 확인하기 위한 방법
plot(fit)

