@echo on
@REM 设置变量延迟!!!!!!!!!!!!!!
setlocal enabledelayedexpansion
@REM %~dp0是bat文件即%0的路径；%~n0是%0参数的文件名，%~x0是扩展名，%~nx0是全名
@REM 这里要求bat文件和exe文件文件名一样
set "batpath=%~dp0"

@REM 首次运行请以管理员权限修改注册表，添加在文件及文件夹右键菜单中的Decoing项
fltmc>nul&&(echo yes)||(echo No若首次在该电脑运行请以管理员权限修改注册表)&&(ping -n 1 127.0.0.1>nul)

@REM 要以双引号括住%1，否则有空格，传给bat文件的参数会被空格截断。%0中自带空格
reg add HKCR\*\shell\Decoding\Command /ve /t REG_SZ /d "%0 \"%%1\""
reg add HKLM\SOFTWARE\Classes\Directory\shell\De\Command /ve /t REG_SZ /d "%0 \"%%1\""

@REM 判断参数是file or folder
@REM if not exist %1\nul echo file goto A
@REM if exist %1\nul echo folder goto B
cd %1 && (echo FCUK Folder && goto B) || (echo FCUK File && goto A)

:A
%batpath%\%~n0.exe %1

@REM 判断有decoded的文件再进行删除,"_%~nx1"需要双引号
if exist "_%~nx1" (
del %1
rename "_%~nx1" "%~nx1"
)
exit

:B
for /R %%i in (*) do (
cd "%%~dpi"
%batpath%\%~n0.exe "%%i"
if exist "_%%~nxi" (
del "%%~nxi"
rename "_%%~nxi" "%%~nxi"
)
)
pause
