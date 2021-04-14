import wx

class ChildFrame(wx.Frame):
    def __init__(self, parent, title, size):
        super().__init__(parent, title=title, size=size)
        self.ui()

    def ui(self):
        # 메뉴 : 고정식 메뉴(pull down), 이동식 메뉴(pop up)
        # MenuBar, Menu, MenuItem
        menubar = wx.MenuBar()
        mnuFile = wx.Menu()
        mnuEdit = wx.Menu()
        mnuFile_new = wx.MenuItem(mnuFile, wx.ID_NEW, "New", "New Document")
        mnuFile_open = wx.MenuItem(mnuFile, wx.ID_OPEN, "Open", "파일 열기")
        mnuFile_exit = wx.MenuItem(mnuFile, wx.ID_EXIT, "Exit", "프로그램 종료")

        mnuFile.Append(mnuFile_new)
        mnuFile.Append(mnuFile_open)
        mnuFile.AppendSeparator()
        mnuFile.Append(mnuFile_exit)

        menubar.Append(mnuFile, "파일")
        menubar.Append(mnuEdit, "편집")

        self.SetMenuBar(menubar)

        self.txtArea = wx.TextCtrl(self, style=wx.TE_MULTILINE)

        self.CreateStatusBar()

        self.Bind(wx.EVT_MENU, self.onNew, mnuFile_new)
        self.Bind(wx.EVT_MENU, self.onExit, mnuFile_exit)
        self.Bind(wx.EVT_MENU, self.onOpen, mnuFile_open)

        # self.Move(50, 50)
        self.Center()
        self.Show(True)

    def onNew(self, ev):
        self.txtArea.SetLabelText("새 문서를 선택하였습니다.")

    def onExit(self, ev):
        self.Close(True)

    def onOpen(self, ev):
        # filepath = "C:\\netsong7\\pythonwork\\basic\\data\\filetest1.txt"

        dlg = wx.FileDialog(self, "파일 불러오기", "c:\\", "", "*.*", style=wx.ID_OPEN)
        if dlg.ShowModal() == wx.ID_OK:
            filepath = dlg.GetPaths()

        f = open(filepath[0], "r")
        data = f.read()
        self.txtArea.SetLabelText(data)
        f.close()






if __name__ == "__main__":
    app = wx.App()
    frame = ChildFrame(None, "두번째 만드는 윈도우", (800, 600))
    app.MainLoop()