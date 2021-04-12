'''
import mymodule

print(mymodule.sum(10, 20))
mymodule.info(80, 180, name="홍길동", blood="O")
print(mymodule.company)
print(mymodule.Math().PI)
print(mymodule.Math().solve(3))
'''


'''
import mymodule as my

print(my.sum(10, 20))
my.info(80, 180, name="홍길동", blood="O")
print(my.company)
print(my.Math().PI)
print(my.Math().solve(3))
'''


'''
from mymodule import sum, info, company, Math

print(sum(10, 20))
info(80, 180, name="홍길동", blood="O")
print(company)
print(Math().PI)
print(Math().solve(3))
'''


'''
from mymodule import *

print(sum(10, 20))
info(80, 180, name="홍길동", blood="O")
print(company)
print(Math().PI)
print(Math().solve(3))
'''


from mymodule import company as com
from mymodule import *

print(sum(10, 20))
info(80, 180, name="홍길동", blood="O")
print(com)
print(Math().PI)
print(Math().solve(3))
