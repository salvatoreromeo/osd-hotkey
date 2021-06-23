FileCreateDir, icons
FileInstall, icons\colors.bmp, icons\colors.bmp, 0
FileInstall, icons\disable.ico, icons\disable.ico, 0
FileInstall, icons\enable.ico, icons\enable.ico, 0
/*
ToDo:
	- font selector
	- remove + from normal keys, i.e. a+b+c+d will be shown as abcd
	- transparency
	- key like CTRL or ALT will be more important than others, so if you type "r+ALT+g" it will display "ALT+g"
	- supra and mousebutton displays in a dedicated area, and the keyboard keys in another
	- log
*/

#Persistent
OnMessage(0x204, "winmove")
FileDelete, log.txt

font=Arial
style=bold
color=black


IniRead, class, colors.ini, class, c

IfNotExist, icons
	FileCreateDir, icons
FileInstall, enable.ico, icons\enable.ico
FileInstall, disable.ico, icons\disable.ico

Gui, +Owner  ; +Owner prevents a taskbar button from appearing.
IniRead, col_b, colors.ini, colors, background, FFFF00
Gui, Color, %col_b%
IniRead, col_t, colors.ini, colors, text, 0000FF
IniRead, font_t, colors.ini, colors, font, Arial
IniRead, style_t, colors.ini, colors, style, bold s20
gui, font,c%col_t% %style_t%, %font_t%
Gui, Add, Text, vMyText x5 y5 w290
Gui, -Caption
Gui, +AlwaysOnTop
IniRead, x, colors.ini, positions, x, 200 
IniRead, y, colors.ini, positions, y, 200
IniRead, w, colors.ini, positions, w, 300
IniRead, h, colors.ini, positions, h, 50

IniRead, unshowTime, colors.ini, times, timeToHide, 2000


Gui, show, NA x%x% y%y% w%w% h%h%, OSD hotkey
Gui, +Resize


singleHotkey=1234567890qwertyuiopasdfghjklzxcvbnm
StringSplit, char, singleHotkey
Loop, %char0%
	{
		currentChar := char%A_Index%
		Hotkey, ~%currentChar%, hks_label
		Hotkey, ~*%currentChar%, hks_label2
	}
numpadHotkey=0123456789
StringSplit, char, numpadHotkey
Loop, %char0%
	{
		currentChar := char%A_Index%
		Hotkey, ~NumPad%currentChar%, hk_label
		Hotkey, ~*NumPad%currentChar%, hk_label2
	}
;functionKey
Loop, 12
	{
		Hotkey, ~F%A_Index%, hk_label
		Hotkey, ~*F%A_Index%, hk_label2
	}

Hotkey, ~NumpadDel, hk_label
Hotkey, ~*NumpadDel, hk_label2
Hotkey, ~NumpadIns, hk_label
Hotkey, ~*NumpadIns, hk_label2
Hotkey, ~NumpadClear, hk_label
Hotkey, ~*NumpadClear, hk_label2
Hotkey, ~NumpadUp, hk_label
Hotkey, ~*NumpadUp, hk_label2
Hotkey, ~NumpadDown, hk_label
Hotkey, ~*NumpadDown, hk_label2
Hotkey, ~NumpadLeft, hk_label
Hotkey, ~*NumpadLeft, hk_label2
Hotkey, ~NumpadRight, hk_label
Hotkey, ~*NumpadRight, hk_label2
Hotkey, ~NumpadHome, hk_label
Hotkey, ~*NumpadHome, hk_label2
Hotkey, ~NumpadEnd, hk_label
Hotkey, ~*NumpadEnd, hk_label2
Hotkey, ~NumpadPgUp, hk_label
Hotkey, ~*NumpadPgUp, hk_label2
Hotkey, ~NumpadPgDn, hk_label
Hotkey, ~*NumpadPgDn, hk_label2
Hotkey, ~NumpadDot, hk_label
Hotkey, ~*NumpadDot, hk_label2

Hotkey, ~Space, hk_space
Hotkey, ~*Space, hks_label2
Hotkey, ~Tab, hk_label
Hotkey, ~*Tab, hk_label2
Hotkey, ~Enter, hk_label
Hotkey, ~*Enter, hk_label2
Hotkey, ~Esc, hk_label
Hotkey, ~*Esc, hk_label2
Hotkey, ~Backspace, hk_label
Hotkey, ~*Backspace, hk_label2
Hotkey, ~Del, hks_label
Hotkey, ~*Del, hks_label2
Hotkey, ~Ins, hk_label
Hotkey, ~*Ins, hk_label2
Hotkey, ~Home, hk_label
Hotkey, ~*Home, hk_label2
Hotkey, ~End, hk_label
Hotkey, ~*End, hk_label2
Hotkey, ~PgUp, hks_label
Hotkey, ~*PgUp, hks_label2
Hotkey, ~PgDn, hks_label
Hotkey, ~*PgDn, hks_label2
Hotkey, ~Up, hks_label
Hotkey, ~*Up, hks_label2
Hotkey, ~Down, hks_label
Hotkey, ~*Down, hks_label2
Hotkey, ~Left, hks_label
Hotkey, ~*Left, hks_label2
Hotkey, ~Right, hks_label
Hotkey, ~*Right, hks_label2

Menu,tray,Icon,icons\enable.ico,,1
Menu, Tray, NoStandard
Menu, Tray, add, Disabled, enable_disable
Menu, Tray, add, Options, showOptionsDialog
Menu, Tray, add, Class control, class_control
Menu, Tray, add, Set class for class control, sel_class
Menu,  Tray, add, About, about
Menu, Tray, add, Exit, GuiClose

SetTimer, mouseHolded, 1000

Gui, 2:add, ListView, xm h20 w20 ReadOnly 0x4000 +BackgRound%col_b% vcol1
Gui, 2:add, edit, x+5 vbackground_color, %col_b%
Gui, 2:add, button, x+5 gselect_background_color, ...
Gui, 2:add, ListView, xm h20 w20 ReadOnly 0x4000 +BackgRound%col_t% vcol2
Gui, 2:add, edit, x+5 vtext_color, %col_t%
Gui, 2:add, button, x+5 gselect_text_color, ...
Gui, 2:add, button, xm h20 w100 gselect_text_font, Change text font
Gui, 2:add, Text, xm, Transparency level


;IniRead, transparency_level, colors.ini, positions, transparency_level
Gui, 2:add, slider, xm Range1-255  vtransparency_level gtransparency_level, 255
OnExit, ExitSub
#Include ColorPicker.ahk
#Include FontPicker.ahk
return



winmove()
{
	getwininfo()
	SetTimer, Muovi , 20
	return
}

Muovi:
	xb1:=GetKeyState("LButton","P")
	;if up
	if(xb1="0")
	{
		CoordMode,MOUSE,SCREEN
		MOUSEGetPos,x,y
		in_x:=wx+x-posx
		in_y:=wy+y-posy
		WinMove, ahk_class %class%, , in_x, in_y
		;Tooltip,Current Position`nx:%in_x%`ny:%in_y%
	}
	;it's still down
	Else
		{
			SetTimer,Muovi,off
			;Tooltip,
			Return
		}
Return

getwininfo()
	{
		global
		CoordMode,MOUSE,SCREEN
		MOUSEGetPos,posx,posy,id
		WinGetClass, class, ahk_id %id%
		WinGetPos , wx, wy, ww, wh,ahk_class %class%
		Return
	}



select_background_color:
	color:=ColorPicker()
	if(color="")
		return
	GuiControl, 2:, background_color, %color%
	GuiControl, 2:+BackgRound%color%, col1
	Gui, 1:Color, %color%
	IniWrite, %color%, colors.ini, colors, background
return
select_text_font:
	if(font="")
		font = %font_t%
	if(style="")
		style= %style_t%
	ChooseFont(font,style,color2)
	gui, 1:font,c%color% %style%, %font%
	GuiControl, 1:Font, MyText
	IniWrite, %font%, colors.ini, colors, font
	IniWrite, %style%, colors.ini, colors, style
return
select_text_color:	
	color:=ColorPicker()
	if(color="")
		return
	GuiControl, , text_color, %color%
	GuiControl, 2:+BackgRound%color%, col2
	gui, 1:font,c%color% %style%, %font%
	GuiControl, 1:Font, MyText
	IniWrite, %color%, colors.ini, colors, text
return

ExitSub:
	WinGetPos , x, y, w, h, OSD hotkey
	IniWrite, %x%, colors.ini, positions, x
	IniWrite, %y%, colors.ini, positions, y
	IniWrite, %w%, colors.ini, positions, w
	IniWrite, %h%, colors.ini, positions, h
	exitapp
return


enable_disable:
Suspend
Menu, Tray, ToggleCheck, Disabled
if(A_IsSuspended=1)
	{
		Menu,tray,Icon , icons\disable.ico,,1
		Gui, hide
	}
else
	{
		Menu,tray,Icon,icons\enable.ico,,1
		Gui, show
	}
return

class_control:
Menu, Tray, ToggleCheck, Class control
if(class_control="true")
	class_control=false
else
	class_control=true
return

sel_class:
	ToolTip,Click with left MOUSE Button on the program window
	SetTimer, RemoveToolTip, 3000
	KeyWait, LButton,D
	MOUSEGetPos,,,idn
	WinGetClass, class, ahk_id %idn%
	IniWrite, %class%, colors.ini, class, c
	msgbox, Class set successfully
return
RemoveToolTip:
	SetTimer, RemoveToolTip, off
	Tooltip,
return


~CTRL::
	if(GetKeyState("LButton", P)=1 or GetKeyState("MButton", P)=1 or GetKeyState("RButton", P)=1)
		return
	osdText=CTRL+
	updateOSD(osdText)
return
~ALT::
	if(GetKeyState("LButton", P)=1 or GetKeyState("MButton", P)=1 or GetKeyState("RButton", P)=1)
		return
	osdText=ALT+
	updateOSD(osdText)
return
~LWIN::
	if(GetKeyState("LButton", P)=1 or GetKeyState("MButton", P)=1 or GetKeyState("RButton", P)=1)
		return
	osdText=WIN+
	updateOSD(osdText)
return
~SHIFT::
	if(GetKeyState("LButton", P)=1 or GetKeyState("MButton", P)=1 or GetKeyState("RButton", P)=1)
		return
	osdText=SHIFT+
	updateOSD(osdText)
return
~*CTRL::
	IfInString, osdText, CTRL
		return
	osdText=%osdText%CTRL+
	updateOSD(osdText)
return
~*ALT::
	IfInString, osdText, ALT
		return
	osdText=%osdText%ALT+
	updateOSD(osdText)
return
~*LWIN::
	IfInString, osdText, WIN
		return
	osdText=%osdText%WIN+
	updateOSD(osdText)
return
~*SHIFT::
	IfInString, osdText, SHIFT
		return
	osdText=%osdText%SHIFT+
	updateOSD(osdText)
return

~LButton::
	osdText=MouseLeft
	updateOSD(osdText)
return
~*LButton::
	IfInString, osdText, MouseLeft
		return
	osdText=%osdText%MouseLeft
	updateOSD(osdText)
return
~RButton::
	osdText=MouseRight
	updateOSD(osdText)
return
~*RButton::
	IfInString, osdText, MouseRight
		return
	osdText=%osdText%MouseRight
	updateOSD(osdText)
return
~MButton::
	osdText=MouseMiddle
	updateOSD(osdText)
return
~*MButton::
	IfInString, osdText, MouseMiddle
		return
	osdText=%osdText%MouseMiddle
	updateOSD(osdText)
return
~WheelUp::
	osdText=MouseWheelUp
	updateOSD(osdText)
return
~*WheelUp::
	IfInString, osdText, MouseWheelUp
		return
	osdText=%osdText%MouseWheelUp
	updateOSD(osdText)
return
~WheelDown::
	osdText=MouseWheelDown
	updateOSD(osdText)
return
~*WheelDown::
	IfInString, osdText, MouseWheelDown
		return
	osdText=%osdText%MouseWheelDown
	updateOSD(osdText)
	
return

mouseHolded:
	if(GetKeyState("LButton", P)=1 or GetKeyState("MButton", P)=1 or GetKeyState("RButton", P)=1)
		{
			if(!InStr(osdText,"(hold)"))
				osdText=%osdText%(hold)
			updateOSD(osdText)
		}
	
return

GuiSize:
	GuiControl, Move, MyText, % "w" A_GuiWidth - 10
	GuiControl, Move, MyText, % "h" A_GuiHeight - 10
return


updateOSD(string)
	{
		global
		
		SetTimer, hs, %unshowTime%
		
		if(osdText!="")
			FileAppend, %A_Hour%:%A_Min%:%A_Sec% - %osdText%`n  ,log.txt
		osdText=%string%
		if(class_control="true")
			{
				IfWinActive, ahk_class %class%
					GuiControl,, MyText, %osdText%
			}
		else
			GuiControl,, MyText, %osdText%
		;SetTimer,unshowOSD,2500
		
		return
	}


hs:
	GuiControl,, MyText, %A_Space%
return


unshowOSD:
	SetTimer,unshowOSD,off
	Gui, Hide
return

hk_space:
	if(A_TimeSincePriorHotkey>1000)
		osdText=Space
	else
		osdText=%osdText%_
return

hk_label:
	StringTrimLeft, thisHotkey, A_ThisHotkey, 1 ; remove ~
	if(A_TimeSincePriorHotkey>1000)
			osdText=%thisHotkey%
	else
		osdText=%thisHotkey%
	updateOSD(osdText)
return
hk_label2:
	StringTrimLeft, thisHotkey, A_ThisHotkey, 2 ; remove ~*
	if(A_TimeSincePriorHotkey>1000)
		osdText=%thisHotkey%
	else
		osdText=%thisHotkey%
	updateOSD(osdText)
return
hks_label:
	StringTrimLeft, thisHotkey, A_ThisHotkey, 1 ; remove ~
	if(A_TimeSincePriorHotkey>1000)
			osdText=%thisHotkey%
	else
		osdText=%osdText%%thisHotkey%
	updateOSD(osdText)
return
hks_label2:
	StringTrimLeft, thisHotkey, A_ThisHotkey, 2 ; remove ~*
	if(A_TimeSincePriorHotkey>1000)
		osdText=%thisHotkey%
	else
		osdText=%osdText%%thisHotkey%
	updateOSD(osdText)
return

GuiClose:
ExitApp

about:
MsgBox,
(
Author: Salvatore Agostino Romeo
E-Mail: romeo84@gmail.com
Web: http://www.romeosa.com/osdhotkey
Description:
  This program show current pressed mouse and keyboard keys.
Version: 1.0
License: GPL
)
return

showOptionsDialog:
	Gui, 2:show, , Colors
return

transparency_level:
	WinSet, Transparent, %transparency_level%, OSD hotkey
return
