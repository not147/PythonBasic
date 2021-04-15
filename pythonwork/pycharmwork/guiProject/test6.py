import wx

class MainFrame(wx.Frame):
    def __init__(self, parent, title, size):
        super().__init__(parent, title=title, size=size)

        panel1 = wx.Panel(self)
        panel1.SetBackgroundColour("BLUE")

        panel2 = wx.Panel(self)
        panel2.SetBackgroundColour("RED")

        box = wx.BoxSizer(wx.HORIZONTAL)
        box.Add(panel1, 3, wx.EXPAND)
        box.Add(panel2, 1, wx.EXPAND)

        self.SetSizer(box)

        self.Show(True)




if __name__ == "__main__":
    app = wx.App()
    MainFrame(None, "Sizer클래스 연습", (600, 600))
    app.MainLoop()