def sum(num1, num2):
	hap = num1 + num2
	return hap

def info(weight, height, **other):
	print("키 : ", height)
	print("몸무게 : ", weight)
	print("기타 : ", other)

company = "파이썬 주식회사"

class Math:
    PI = 3.141592

    def solve(self, r):
        return self.PI * (r**2)