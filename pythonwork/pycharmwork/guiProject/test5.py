import wx

class MainFrame(wx.Frame):
    def __init__(self, parent, title, size):
        super().__init__(parent, title=title, size=size)
        self.ui()
        self.Show(True)

    def ui(self):
        self.panel = wx.Panel(self)
        # esc키 누르면 프로그램 종료
        self.panel.SetFocus()
        self.panel.Bind(wx.EVT_KEY_DOWN, self.onClose)

        wx.StaticText(self.panel, label="**************************기타 컴퍼넌트**************************",
                      pos=(20, 5))

        # TextCtrl
        wx.StaticText(self.panel, label="너의 이름은 ", pos=(20, 70))
        self.txtName = wx.TextCtrl(self.panel, value="초기값", pos=(100, 70))
        self.Bind(wx.EVT_TEXT, self.onText, self.txtName)

        # CheckBox
        self.chkMarried = wx.CheckBox(self.panel, label="결혼은?", pos=(20, 120))
        self.Bind(wx.EVT_CHECKBOX, self.onCheck, self.chkMarried)

        # RadioBox
        cboData = ["빨강", "초록", "파랑", "노랑"]
        self.rbColor = wx.RadioBox(self.panel, label="좋아하는 색상은?", pos=(20, 170), choices=cboData)
        self.rbColor.Bind(wx.EVT_RADIOBOX, self.onRadio)

        # ComboBox
        self.cboColor = wx.ComboBox(self.panel, pos=(20, 260), choices=cboData)
        self.cboColor.Bind(wx.EVT_COMBOBOX, self.onCombo)

        # 결과 값 확인
        self.txtShow = wx.TextCtrl(self.panel, pos=(20, 400), size=(320, 150), style=wx.TE_MULTILINE | wx.TE_READONLY)



    def onText(self, e):
        # self.txtShow.AppendText("TextCtrl에서 이벤트 발생 : {}\n".format(self.txtName.GetValue()))
        self.txtShow.AppendText("TextCtrl에서 이벤트 발생 : {}\n".format(e.GetString()))

    def onCheck(self, e):
        self.txtShow.AppendText("CheckBox에서 이벤트 발생 : {}\n".format(e.IsChecked()))

    def onRadio(self, e):
        self.txtShow.AppendText("RadioBox에서 이벤트 발생 : {},  {}\n".format(e.GetInt(), e.GetString()))

    def onCombo(self, e):
        self.txtShow.AppendText("ComboBox에서 이벤트 발생 : {},  {}\n".format(e.GetInt(), e.GetString()))

    def onClose(self, e):
       #print(e.GetKeyCode())
       if e.GetKeyCode() == wx.WXK_ESCAPE:
            self.Close(True)


if __name__ == "__main__":
    app = wx.App()
    MainFrame(None, "컨트롤 연습", (400, 600))
    app.MainLoop()