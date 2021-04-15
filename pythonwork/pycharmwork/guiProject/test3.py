import wx

class LoginFrame(wx.Frame):
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

        """
        #self.Bind(wx.EVT_BUTTON, self.onBtn3, btn3)
        btn3.Bind(wx.EVT_BUTTON, self.onBtn3)
        btn1.Bind(wx.EVT_BUTTON, self.onBtn1)
        btn2.Bind(wx.EVT_TOGGLEBUTTON, self.onBtn2)
        """

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

    """
    def onBtn1(self, e):
        id = self.m_id.GetValue()
        pw = self.m_pw.GetValue()

        if id == "tiger" and pw == "1111":
            msg = "로그인이 되었습니다"
        else:
            msg = "로그인이 거부되었습니다."

        dlg = wx.MessageDialog(self, msg, "로그인", wx.OK)
        dlg.ShowModal()
        dlg.Destroy()

    def onBtn2(self, e):
        # print(e.GetEventObject())
        # print(e.GetEventObject().GetValue())
        if e.GetEventObject().GetValue():
            self.panel.SetBackgroundColour(wx.Colour(255, 0, 0))
            self.panel.Refresh()
        else:
            self.panel.SetBackgroundColour(wx.Colour(0, 255, 0))
            self.panel.Refresh()

    def onBtn3(self, e):
        self.Close(True)
    """


if __name__ == "__main__":
    app = wx.App()
    frame = LoginFrame(title="로그인", size=(300, 200))
    frame.Show(True)
    app.MainLoop()