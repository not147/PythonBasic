# import MySQLdb
import pymysql

config = {"host":"127.0.0.1", "user":"root", "password":"1111", "database":"world"}

conn = pymysql.connect(**config)
cur = conn.cursor()

try:
    cur.execute("select * from suppliers")
    for row in cur:
        print(row)
finally:
    conn.close()