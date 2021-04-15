import wx

# class Example(wx.Frame):
#     def __init__(self, parent, title):
#         frame = wx.Frame.__init__(self, parent, title=title, )
#
#         self.btn = []
#         self.btn.append(wx.Button(self, label='Button 1', id=0))
#         self.btn.append(wx.Button(self, label='Button 2', id=1))
#
#         self.Bind(wx.EVT_BUTTON, self.button1_press, id=0)
#         self.Bind(wx.EVT_TEXT_ENTER, self.button1_press)
#
#         self.Bind(wx.EVT_BUTTON, self.button2_press, id=1)
#         self.Bind(wx.EVT_TEXT_ENTER, self.button2_press)
#
#         self.Bind(wx.EVT_CHAR_HOOK, self.on_key)
#
#         self.sizer = wx.GridBagSizer(0, 0)
#
#         self.sizer.Add(self.btn[0], pos=(0, 0), flag=wx.ALIGN_CENTER)
#         self.sizer.Add(self.btn[1], pos=(1, 0), flag=wx.ALIGN_CENTER)
#
#         self.SetSizer(self.sizer)
#         self.Fit()
#
#     def button1_press(self, event):
#         print('button 1')
#
#     def button2_press(self, event):
#         print('button 2')
#
#     def on_key(self, event):
#         i = self.get_focus()
#         if event.GetKeyCode() == wx.WXK_DOWN:
#             i = min(i+1, 1)
#             self.btn[i].SetFocus()
#         elif event.GetKeyCode() == wx.WXK_UP:
#             i = max(i-1, 0)
#             self.btn[i].SetFocus()
#         elif event.GetKeyCode() == wx.WXK_RETURN:  # <-doesn't work
#             print('ENTER!')
#         else:
#             event.Skip()
#
#     def get_focus(self):
#         focused = wx.Window.FindFocus()
#         if focused == self.btn[0]:
#             return 0
#         elif focused == self.btn[1]:
#             return 1
#
#
# class AppMenu(wx.App):
#     def OnInit(self):
#         'Create the main window and insert the custom frame'
#         frame = Example(None, 'Example')
#         frame.Show(True)
#
#         return True
#
# app = AppMenu(0)
# app.MainLoop()

class Example(wx.Frame):
    def __init__(self, parent, title):
        frame = wx.Frame.__init__(self, parent, title=title, )
        self.panel = wx.Panel(self, -1, size=(200,100))
        self.btn1 = wx.Button(self.panel, label='Button 1', id=1)
        self.btn2 = wx.Button(self.panel, label='Button 2', id=2)
        self.btn1.SetDefault()
        self.btn1.SetFocus()

        self.sizer = wx.GridBagSizer(0, 0)
        self.sizer.Add(self.btn1, pos=(0, 0), flag=wx.ALIGN_CENTER)
        self.sizer.Add(self.btn2, pos=(1, 0), flag=wx.ALIGN_CENTER)

        self.Bind(wx.EVT_BUTTON, self.button_press)
        self.Bind(wx.EVT_CHAR_HOOK, self.on_key)

        self.panel.SetSizer(self.sizer)
        self.Fit()

    def button_press(self, event):
        Id = event.GetId()
        print ('Click Button',str(Id))

    def on_key(self, event):
        key = event.GetKeyCode()
        if key == wx.WXK_DOWN or key == wx.WXK_UP:
            i = self.get_focus()
            if i == 1:
                self.btn1.SetDefault()
                self.btn1.SetFocus()
            else:
                self.btn2.SetDefault()
                self.btn2.SetFocus()
            print ('Focus on',str(i))
        elif key == wx.WXK_RETURN:
            print ('ENTER on Button',str(event.GetId()))
        else:
            event.Skip()

    def get_focus(self):
        focused = wx.Window.FindFocus()
        if focused == self.btn1:
            return 2
        elif focused == self.btn2:
            return 1


class AppMenu(wx.App):
    def OnInit(self):
        'Create the main window and insert the custom frame'
        frame = Example(None, 'Example')
        frame.Show(True)

        return True

app = AppMenu()
app.MainLoop()