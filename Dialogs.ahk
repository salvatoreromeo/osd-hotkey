	gui, +lastfound
	gui, add, button, w100 gonFont, font dlg
	gui, add, button, x+5 w100 gonColor, color dlg
	gui, add, button, x+5 w100 gOnIcon, icon dlg
	gui, show, w900 h500	

	hgui := winExist()

return

onIcon:
	ChooseIcon(icon, idx, hGui)
	Gui, add, picture, x10, %icon%
return

onColor:
	clr := ChooseColor(clr, hgui)
	if (clr = -1)
		return
	
	gui, Color, %clr%
return

onFont:
	if fnt=
	{
		fnt := "courier new", pStyle := "bold s32 underline"
	}

	if ChooseFont(fnt, pStyle, clr, hgui)
		return
	
	gui, font,  %pstyle%, %fnt%
	gui, add, text, x10 ,%fnt%, %pStyle%
return

#include choosecolor.ahk
#include choosefont.ahk
#include chooseicon.ahk
#include Structs.ahk		;insert, extractinteger