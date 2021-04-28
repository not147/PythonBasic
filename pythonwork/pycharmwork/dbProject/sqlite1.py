import sqlite3

def process(dbname):
    try:
        conn = sqlite3.connect(dbname)
        cur = conn.cursor()

        sql = "drop table if exists emp"
        cur.execute(sql)

        sql = "create table emp(id integer primary key, name text)"
        cur.execute(sql)

        #tables = cur.execute("select * from sqlite_master where type='table'")
        #for i in tables:
        #    print(i)

        cur.execute("insert into emp values(1, '홍길동')")
        cur.execute("insert into emp values(?, ?)", (2, "임꺽정"))
        cur.execute("insert into emp values(?, ?)", [3, "신돌석"])

        tlist = ((4, "유비"), (5, "관우"), (6, "장비"))
        cur.executemany("insert into emp values(?, ?)", tlist)

        cur.execute("insert into emp values(:no, :name)", {"no":7, "name":"호랑이"})

        conn.commit()

        cur.execute("select * from emp")
        for row in cur:
            print(row)

        print("----------------------------")

        cur.execute("select count(*) from emp")
        print("데이터 갯수 : " + str(cur.fetchone()))

    except sqlite3.Error as e:
        print("오류 : ", e)
        conn.rollback()
    finally:
        conn.close()


if __name__ == "__main__":
    process("nice.db")