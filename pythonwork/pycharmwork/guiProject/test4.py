"""
Dialog(대화 상자)
------------------
1.종류
    1) Built-In Dialog
        - Common Dialog(공통 대화상자), System Dialog

    2) User Definition Dialog

2. 실행 방식
    - Modal
    - Modaless
"""

import wx
import os

class MainFrame(wx.Frame):
    def __init__(self, parent, title, size):
        super().__init__(parent, title=title, size=size)
        self.ui()

    def ui(self):
        self.CreateStatusBar()
        menubar = wx.MenuBar()
        menu = wx.Menu()

        """
        item1 = wx.MenuItem(menu, 100, "MessageDialong", "메시지 대화상자 보이기")
        item2 = wx.MenuItem(menu, 101, "ColorDialong", "색상 대화상자 보이기")
        item3 = wx.MenuItem(menu, 102, "FileDialong", "파일 대화상자 보이기")
        item4 = wx.MenuItem(menu, 103, "LoginDialong", "로그인 대화상자 보이기")

        menu.Append(item1)
        menu.Append(item2)
        menu.Append(item3)
        menu.Append(item4)
        """

        menu.Append(100, "MessageDialong", "메시지 대화상자 보이기")
        menu.Append(101, "ColorDialong", "색상 대화상자 보이기")
        menu.Append(102, "FileDialong", "파일 대화상자 보이기")
        menu.Append(103, "LoginDialong", "로그인 대화상자 보이기")

        menubar.Append(menu, "다이얼로그")
        self.SetMenuBar(menubar)

        self.Bind(wx.EVT_MENU, self.onMessage, id=100)
        self.Bind(wx.EVT_MENU, self.onColor, id=101)
        self.Bind(wx.EVT_MENU, self.onFile, id=102)
        self.Bind(wx.EVT_MENU, self.onLogin, id=103)

        self.Show(True)

    def onMessage(self, e):
        self.SetStatusText("메세지 대화 상자")
        dlg = wx.MessageDialog(self, "오늘 하루도 열심히....", "메시지 박스", wx.OK|wx.ICON_WARNING)
        dlg.ShowModal()

    def onColor(self, e):
        self.SetStatusText("색상 대화 상자")
        dlg = wx.ColourDialog(self)
        dlg.GetColourData().SetChooseFull(True)

        if dlg.ShowModal() == wx.ID_OK:
            color = dlg.GetColourData()
            self.SetStatusText("당신이 선택한 색상은 " + str(color.GetColour().Get()))

    def onFile(self, e):
        self.SetStatusText("파일 대화 상자")
        dlg = wx.FileDialog(self, "파일 불러오기", "c:\\", "", "*.*", style=wx.ID_OPEN)
        if dlg.ShowModal() == wx.ID_OK:
            filepath = dlg.GetPaths()[0]

        self.SetStatusText("당신이 선택한 파일은 " + os.path.basename(filepath))

    def onLogin(self, e):
        self.SetStatusText("로그인 대화 상자")
        dlg = LoginFrame(self, "로그인", (300, 200))
        dlg.ShowModal()
        dlg.Destroy()

#################################################################################

class LoginFrame(wx.Dialog):
    def __init__(self, parent=None, title=None, size=(800, 600)):
        super().__init__(parent, title=title, size=size)
        self.ui()

    def ui(self):
        self.panel = wx.Panel(self)

        wx.StaticText(self.panel, label="ID :", pos=(5, 5))
        wx.StaticText(self.panel, label="Pass :", pos=(5, 40))

        self.m_id = wx.TextCtrl(self.panel, pos=(50, 5), size=(200, -1))
        self.m_pw = wx.TextCtrl(self.panel, pos=(50, 40))

        btn1 = wx.Button(self.panel, label="일반 버튼", pos=(5, 100))
        btn2 = wx.ToggleButton(self.panel, label="토글 버튼", pos=(90, 100))
        btn3 = wx.Button(self.panel, label="종료", pos=(180, 100))

        btn1.id, btn2.id, btn3.id = 1, 2, 3
        btn1.Bind(wx.EVT_BUTTON, self.onBtnHandler)
        btn2.Bind(wx.EVT_TOGGLEBUTTON, self.onBtnHandler)
        btn3.Bind(wx.EVT_BUTTON, self.onBtnHandler)


    def onBtnHandler(self, e):
        # print(e.GetEventObject())
        # print(e.GetEventObject().id)
        if e.GetEventObject().id == 1:
            id = self.m_id.GetValue()
            pw = self.m_pw.GetValue()

            if id == "tiger" and pw == "1111":
                msg = "로그인이 되었습니다"
            else:
                msg = "로그인이 거부되었습니다."

            dlg = wx.MessageDialog(self, msg, "로그인", wx.OK)
            dlg.ShowModal()
            dlg.Destroy()
        elif e.GetEventObject().id == 2:
            if e.GetEventObject().GetValue():
                self.panel.SetBackgroundColour(wx.Colour(255, 0, 0))
                self.panel.Refresh()
            else:
                self.panel.SetBackgroundColour(wx.Colour(0, 255, 0))
                self.panel.Refresh()
        else:
            self.Close(True)

#################################################################################

if __name__ == "__main__":
    app = wx.App()
    MainFrame(None, "다이얼로그 연습", (800, 600))
    app.MainLoop()