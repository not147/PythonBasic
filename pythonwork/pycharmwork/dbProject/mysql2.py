"""
create database pywin;
use pywin;

ALTER DATABASE pywin DEFAULT CHARACTER SET utf8;
--ALTER TABLE 테이블명 CONVERT TO CHARACTER SET utf8;

create table product(code int primary key,
            product_name varchar(20),
            product_count int,
            product_price int);

insert into product values(1,'장갑',3,5000);
insert into product values(2,'가죽장갑',10,50000);
insert into product values(3,'가죽점퍼',5,650000);

create table Departure(
          dep_no int(4)  primary key,
          dep_name varchar(10) not null,
          dep_loc varchar(10),
          dep_tel varchar(15));

insert into Departure values(10,'총무부','서울','02-100-1111');
insert into Departure values(20,'영업부','서울','02-100-2222');
insert into Departure values(30,'전산부','서울','02-100-3333');

create table emp(emp_no int(4) primary key,
          emp_name varchar(10) not null,
          dep_num int(4) not null,
          emp_jik varchar(10) default '사원',
          emp_pay int,
          emp_hiredate date,
          emp_gen char(3),
          CONSTRAINT ck_sawon_gen check(emp_gen='남' or emp_gen='여'));

insert into emp values(1,'홍길동',10,'사장',8000,'98/09/01','남');
insert into emp values(2,'한국남',20,'부장',6200,'01/01/03','남');
insert into emp values(3,'이순신',20,'과장',4500,'01/03/03','남');
insert into emp values(4,'이미라',30,'대리',3503,'04/01/04','여');
insert into emp values(5,'이순라',20,'사원',2850,'09/08/05','여');

create table customer(cus_no int(4) primary key,
          cus_name varchar(10) not null,
          cus_tel varchar(20),
          cus_jumin char(14),
          cus_damsano int(4),
          CONSTRAINT FK_gogek_damsano foreign key(cus_damsano)
          references emp(emp_no));

insert into customer values(1,'이나라','02-535-2580','850612-1156789',1);
insert into customer values(2,'김혜순','02-375-6946','700101-1054225',3);
insert into customer values(3,'최부자','02-692-8926','890305-1065773',3);
insert into customer values(4,'김해자','032-393-6277','770412-2028677',1);
insert into customer values(5,'차일호','02-294-2946','790509-1062677',2);
"""

# -*- coding: utf-8 -*-

###########################################################################
## Python code generated with wxFormBuilder (version Jun 17 2015)
## http://www.wxformbuilder.org/
##
## PLEASE DO "NOT" EDIT THIS FILE!
###########################################################################

import wx
import wx.xrc
import MySQLdb

config = {"host":"127.0.0.1", "user":"root", "password":"1111", "database":"pywin",
          "port":3306, 'charset':'utf8', 'use_unicode':True}
###########################################################################
## Class MainFrame
###########################################################################

class MainFrame(wx.Frame):

    def __init__(self, parent):
        wx.Frame.__init__(self, parent, id=wx.ID_ANY, title=wx.EmptyString, pos=wx.DefaultPosition,
                          size=wx.Size(379, 427), style=wx.DEFAULT_FRAME_STYLE | wx.TAB_TRAVERSAL)

        self.SetSizeHintsSz(wx.DefaultSize, wx.DefaultSize)

        bSizer1 = wx.BoxSizer(wx.VERTICAL)

        self.m_panel1 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer2 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText1 = wx.StaticText(self.m_panel1, wx.ID_ANY, u"번호 : ", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText1.Wrap(-1)
        bSizer2.Add(self.m_staticText1, 0, wx.ALL, 5)

        self.m_txtNo = wx.TextCtrl(self.m_panel1, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer2.Add(self.m_txtNo, 0, wx.ALL, 5)

        self.m_btnInsert = wx.Button(self.m_panel1, wx.ID_ANY, u"등록", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer2.Add(self.m_btnInsert, 1, wx.ALL, 5)

        self.m_panel1.SetSizer(bSizer2)
        self.m_panel1.Layout()
        bSizer2.Fit(self.m_panel1)
        bSizer1.Add(self.m_panel1, 0, wx.ALL | wx.EXPAND, 5)

        self.m_panel2 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer3 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText2 = wx.StaticText(self.m_panel2, wx.ID_ANY, u"이름 : ", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText2.Wrap(-1)
        bSizer3.Add(self.m_staticText2, 0, wx.ALL, 5)

        self.m_txtName = wx.TextCtrl(self.m_panel2, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer3.Add(self.m_txtName, 0, wx.ALL, 5)

        self.m_btnUpdate = wx.Button(self.m_panel2, wx.ID_ANY, u"수정", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer3.Add(self.m_btnUpdate, 0, wx.ALL, 5)

        self.m_btnConfirm = wx.Button(self.m_panel2, wx.ID_ANY, u"확인", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer3.Add(self.m_btnConfirm, 0, wx.ALL, 5)

        self.m_panel2.SetSizer(bSizer3)
        self.m_panel2.Layout()
        bSizer3.Fit(self.m_panel2)
        bSizer1.Add(self.m_panel2, 0, wx.ALL | wx.EXPAND, 5)

        self.m_panel3 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer4 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText3 = wx.StaticText(self.m_panel3, wx.ID_ANY, u"전화 : ", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText3.Wrap(-1)
        bSizer4.Add(self.m_staticText3, 0, wx.ALL, 5)

        self.m_txtTel = wx.TextCtrl(self.m_panel3, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.m_txtTel, 0, wx.ALL, 5)

        self.m_btnDel = wx.Button(self.m_panel3, wx.ID_ANY, u"삭제", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer4.Add(self.m_btnDel, 1, wx.ALL, 5)

        self.m_panel3.SetSizer(bSizer4)
        self.m_panel3.Layout()
        bSizer4.Fit(self.m_panel3)
        bSizer1.Add(self.m_panel3, 0, wx.EXPAND | wx.ALL, 5)

        self.m_panel4 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer5 = wx.BoxSizer(wx.VERTICAL)

        self.m_lstView = wx.ListCtrl(self.m_panel4, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.LC_REPORT)
        bSizer5.Add(self.m_lstView, 1, wx.ALL | wx.EXPAND, 5)

        # 리스트 컨트롤 화면 디자인
        self.m_lstView.InsertColumn(0, "번호", width=50)
        self.m_lstView.InsertColumn(1, "이름", width=100)
        self.m_lstView.InsertColumn(2, "전화", width=100)

        self.m_panel4.SetSizer(bSizer5)
        self.m_panel4.Layout()
        bSizer5.Fit(self.m_panel4)
        bSizer1.Add(self.m_panel4, 1, wx.ALL, 5)

        self.m_panel5 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer6 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText5 = wx.StaticText(self.m_panel5, wx.ID_ANY, u"인원수 : ", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText5.Wrap(-1)
        bSizer6.Add(self.m_staticText5, 0, wx.ALL, 5)

        self.m_staCnt = wx.StaticText(self.m_panel5, wx.ID_ANY, u"0", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staCnt.Wrap(-1)
        bSizer6.Add(self.m_staCnt, 0, wx.ALL, 5)

        self.m_panel5.SetSizer(bSizer6)
        self.m_panel5.Layout()
        bSizer6.Fit(self.m_panel5)
        bSizer1.Add(self.m_panel5, 0, wx.EXPAND | wx.ALL, 5)

        self.SetSizer(bSizer1)
        self.Layout()

        self.Centre(wx.BOTH)

        # 버튼 이벤트 id를 지정
        self.m_btnInsert.id = 1
        self.m_btnUpdate.id = 2
        self.m_btnConfirm.id = 3
        self.m_btnDel.id = 4

        # 이벤트 바인딩
        self.m_btnInsert.Bind(wx.EVT_BUTTON, self.onBtnClick)
        self.m_btnUpdate.Bind(wx.EVT_BUTTON, self.onBtnClick)
        self.m_btnConfirm.Bind(wx.EVT_BUTTON, self.onBtnClick)
        self.m_btnDel.Bind(wx.EVT_BUTTON, self.onBtnClick)

        self.m_btnConfirm.Enable(enable=False)
        self.viewListData()

    def onBtnClick(self, e):
        id = e.GetEventObject().id

        if id == 1:  # 등록 버튼
            self.cusInsert()
        elif id == 2:  # 수정 버튼
            self.cusUpdate()
        elif id == 3:  # 확인(수정 완료) 버튼
            self.cusUpdateOk()
        elif id == 4:  # 삭제 버튼
            self.cusDel()
        elif id == 5:  # 취소 버튼
            self.cusUpdateCancel()

    # ListCtrl에 고객 정보 출력
    def viewListData(self):
        try:
            conn = MySQLdb.connect(**config)
            cur = conn.cursor()

            self.m_lstView.DeleteAllItems()

            cur.execute("select * from customer")

            count = 0
            for row in cur:
                i = self.m_lstView.InsertItem(10000, 0)
                self.m_lstView.SetItem(i, 0, str(row[0]))
                self.m_lstView.SetItem(i, 1, str(row[1]))
                self.m_lstView.SetItem(i, 2, str(row[2]))
                count += 1

            self.m_staCnt.SetLabel(str(count))

        except Exception as e:
            print("viewListData에서 오류 : ", e)
        finally:
            conn.close()

    # 중복된 고객번호 체크, 수정할 데이터를 조회
    def selectData(self, no):
        try:
            conn = MySQLdb.connect(**config)
            cur = conn.cursor()

            sql = "select cus_no, cus_name, cus_tel from customer where cus_no={}".format(no)
            cur.execute(sql)

            data = cur.fetchone()
            return data
        except Exception as e:
            print("selectData에서 오류 : ", e)
        finally:
            conn.close()

    # 고객 등록
    def cusInsert(self):
        no = self.m_txtNo.GetValue()
        name = self.m_txtName.GetValue()
        tel = self.m_txtTel.GetValue()

        if no == "" or name=="" or tel=="":
            wx.MessageBox("자료를 입력하세요", "입력", wx.OK)
            return

        try:
            conn = MySQLdb.connect(**config)
            cur = conn.cursor()

            result = self.selectData(no)
            if result != None:
                wx.MessageBox("이미 사용중인 번호입니다.", "알림", wx.OK)
                return

            sql = "insert into customer(cus_no, cus_name, cus_tel) values(%s, %s, %s)"
            cur.execute(sql, (no, name, tel))
            conn.commit()

            self.viewListData()
            self.m_txtNo.SetValue("")
            self.m_txtName.SetValue("")
            self.m_txtTel.SetValue("")
        except Exception as e:
            print("cusInsert에서 오류 : ", e)
        finally:
            conn.close()

    # 고객 수정
    def cusUpdate(self):
        dlg = wx.TextEntryDialog(self, "수정할 번호 입력", "수정")
        if dlg.ShowModal() == wx.ID_OK:
            if dlg.GetValue() == "":
                return

            up_no = dlg.GetValue()

            result = self.selectData(up_no)
            if result == None:
                wx.MessageBox(up_no + "번은 등록된 자료가 아닙니다.", "알림", wx.OK)
                return

            self.m_txtNo.SetValue(str(result[0]))
            self.m_txtName.SetValue(str(result[1]))
            self.m_txtTel.SetValue(str(result[2]))

            self.m_txtNo.SetEditable(False)
            self.m_btnConfirm.Enable(True)
            self.m_btnUpdate.SetLabel("취소")
            self.m_btnUpdate.id = 5

    # 고객 수정 완료
    def cusUpdateOk(self):
        no = self.m_txtNo.GetValue()
        name = self.m_txtName.GetValue()
        tel = self.m_txtTel.GetValue()

        if name == "" or tel == "":
           wx.MessageBox("자료를 입력하세요", "입력", wx.OK)
           return

        try:
            conn = MySQLdb.connect(**config)
            cur = conn.cursor()

            sql = "update customer set cus_name=%s, cus_tel=%s where cus_no=%s"
            cur.execute(sql, (name, tel, no))
            conn.commit()

            self.viewListData()
            self.m_txtNo.SetValue("")
            self.m_txtName.SetValue("")
            self.m_txtTel.SetValue("")

            self.m_txtNo.SetEditable(True)
            self.m_btnUpdate.SetLabel("수정")
            self.m_btnUpdate.id = 2
            self.m_btnConfirm.Enable(False)
        except Exception as e:
            print("cusUpdateOk에서 오류 : ", e)
        finally:
            conn.close()

    # 고객 수정 취소
    def cusUpdateCancel(self):
        self.m_txtNo.SetValue("")
        self.m_txtName.SetValue("")
        self.m_txtTel.SetValue("")

        self.m_txtNo.SetEditable(True)
        self.m_btnUpdate.SetLabel("수정")
        self.m_btnUpdate.id = 2
        self.m_btnConfirm.Enable(False)

    # 고객 삭제
    def cusDel(self):
        dlg = wx.TextEntryDialog(self, "삭제할 번호 입력", "삭제")
        if dlg.ShowModal() == wx.ID_OK:
            if dlg.GetValue() == "":
                return

            del_no = dlg.GetValue()

            result = self.selectData(del_no)
            if result == None:
                wx.MessageBox(del_no + "번은 등록된 자료가 아닙니다.", "알림", wx.OK)
                return

            try:
                conn = MySQLdb.connect(**config)
                cur = conn.cursor()

                sql = "delete from customer where cus_no={}".format(del_no)
                cur.execute(sql)
                conn.commit()
                self.viewListData()
            except Exception as e:
                print("cusDel에서 오류 : ", e)
            finally:
                conn.close()

if __name__ == "__main__":
    app = wx.App()
    MainFrame(None).Show(True)
    app.MainLoop()