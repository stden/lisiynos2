from win32com.client import Dispatch
app = Dispatch("Word.Application")
app.Visible = True