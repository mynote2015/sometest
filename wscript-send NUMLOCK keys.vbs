************open the wscript.vbs to send NUMLOCK keys***********************
Set WshShell = WScript.CreateObject("WScript.Shell")

for i=1 to 10000
	WScript.Sleep 200000
	wshShell.SendKeys "{NUMLOCK}"
next


************shutthe wscript.vbs***********************
do
x=msgbox("5MIN",VbOkCancel,"«Ì«O")
if x=VbOk then
CreateObject("WScript.Shell").Run "taskkill /f /im wscript.exe", 0
elseif x=Vbcancel then

end if
loop
