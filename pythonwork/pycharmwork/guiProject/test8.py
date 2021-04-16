# -*- coding: utf-8 -*-

###########################################################################
## Python code generated with wxFormBuilder (version Jun 17 2015)
## http://www.wxformbuilder.org/
##
## PLEASE DO "NOT" EDIT THIS FILE!
###########################################################################

import wx
import wx.xrc


###########################################################################
## Class MainFrame
###########################################################################

class MainFrame(wx.Frame):

    def __init__(self, parent):
        wx.Frame.__init__(self, parent, id=wx.ID_ANY, title=u"거래처 관리 프로그램", pos=wx.DefaultPosition,
                          size=wx.Size(503, 397), style=wx.DEFAULT_FRAME_STYLE | wx.TAB_TRAVERSAL)

        self.SetSizeHintsSz(wx.DefaultSize, wx.DefaultSize)

        bSizer5 = wx.BoxSizer(wx.VERTICAL)

        self.m_panel4 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer6 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText4 = wx.StaticText(self.m_panel4, wx.ID_ANY, u"거래처명 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText4.Wrap(-1)
        bSizer6.Add(self.m_staticText4, 0, wx.ALL, 5)

        self.m_txtName = wx.TextCtrl(self.m_panel4, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_txtName, 0, wx.ALL, 5)

        self.m_staticText5 = wx.StaticText(self.m_panel4, wx.ID_ANY, u"전화 번호 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText5.Wrap(-1)
        bSizer6.Add(self.m_staticText5, 0, wx.ALL, 5)

        self.m_txtTel = wx.TextCtrl(self.m_panel4, wx.ID_ANY, wx.EmptyString, wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_txtTel, 0, wx.ALL, 5)

        self.m_btnInsert = wx.Button(self.m_panel4, wx.ID_ANY, u"등록", wx.DefaultPosition, wx.DefaultSize, 0)
        bSizer6.Add(self.m_btnInsert, 0, wx.ALL, 5)

        self.m_panel4.SetSizer(bSizer6)
        self.m_panel4.Layout()
        bSizer6.Fit(self.m_panel4)
        bSizer5.Add(self.m_panel4, 0, wx.EXPAND | wx.ALL, 5)

        self.m_panel5 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer7 = wx.BoxSizer(wx.VERTICAL)

        self.m_listCtrl1 = wx.ListCtrl(self.m_panel5, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.LC_REPORT)
        bSizer7.Add(self.m_listCtrl1, 1, wx.ALL | wx.EXPAND, 5)

        # ListCtrl의 필드명 작성
        self.m_listCtrl1.InsertColumn(0, "거래처 이름", width=200)
        self.m_listCtrl1.InsertColumn(1, "전화 번호", width=200)

        self.m_panel5.SetSizer(bSizer7)
        self.m_panel5.Layout()
        bSizer7.Fit(self.m_panel5)
        bSizer5.Add(self.m_panel5, 1, wx.EXPAND | wx.ALL, 5)

        self.m_panel6 = wx.Panel(self, wx.ID_ANY, wx.DefaultPosition, wx.DefaultSize, wx.TAB_TRAVERSAL)
        bSizer8 = wx.BoxSizer(wx.HORIZONTAL)

        self.m_staticText6 = wx.StaticText(self.m_panel6, wx.ID_ANY, u"거래처 수 :", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staticText6.Wrap(-1)
        bSizer8.Add(self.m_staticText6, 0, wx.ALL, 5)

        self.m_staCount = wx.StaticText(self.m_panel6, wx.ID_ANY, u"0", wx.DefaultPosition, wx.DefaultSize, 0)
        self.m_staCount.Wrap(-1)
        bSizer8.Add(self.m_staCount, 0, wx.ALL, 5)

        self.m_panel6.SetSizer(bSizer8)
        self.m_panel6.Layout()
        bSizer8.Fit(self.m_panel6)
        bSizer5.Add(self.m_panel6, 0, wx.EXPAND | wx.ALL, 5)

        self.SetSizer(bSizer5)
        self.Layout()

        self.Centre(wx.BOTH)

        # Connect Events
        self.m_btnInsert.Bind(wx.EVT_BUTTON, self.onInsert)

    def __del__(self):
        pass

    # Virtual event handlers, overide them in your derived class
    def onInsert(self, event):
        name = self.m_txtName.GetValue()
        tel = self.m_txtTel.GetValue()

        i = self.m_listCtrl1.InsertItem(1000, 0) # 총 입력될 갯수, 시작 위치
        self.m_listCtrl1.SetItem(i, 0, name)
        self.m_listCtrl1.SetItem(i, 1, tel)

        self.m_staCount.SetLabelText(str(self.m_listCtrl1.GetItemCount()))

        self.m_txtName.SetValue("")
        self.m_txtTel.SetValue("")
        self.m_txtName.SetFocus()


if __name__ == "__main__":
    app = wx.App()
    MainFrame(None).Show(True)
    app.MainLoop()