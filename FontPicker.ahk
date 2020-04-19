font=Arial
style=bold
color=black
ChooseFont(font,style,color)
msgbox, %font% %style%

;----------------------------------------------------------------------------------------------
; ChooseFont 1.0 - by majkinetor
;
;   pFace	- initial font, output
;	pStyle	- initial style, output 
;	pColor	- text color, output
; 	hGui	- parent gui, affects modality and position
;
;	Returns : false on cancel
;
;   Requires: Insert/ExtractInteger
;
ChooseFont(ByRef pFace, ByRef pStyle, ByRef pColor, hGui=0) {

	VarSetCapacity(SLogFont, 128, 0)

	;set initial name
	DllCall("RtlMoveMemory", "uint", &SLogFont+28, "Uint", &pFace, "Uint", 32)

	;set intial weight
	if InStr(pStyle, "bold")
		InsertInteger(700, SLogFont, 16)

	if InStr(pStyle, "italic")
		InsertInteger(255, SLogFont, 20, 1)

	if InStr(pStyle, "underline")
		InsertInteger(1, SLogFont, 21, 1)
	
	if InStr(pStyle, "strikeout")
		InsertInteger(1, SLogFont, 22, 1)


	if RegExMatch( pStyle, "s[0-9][0-9]", s){
		StringTrimLeft, s, s, 1		
		InsertInteger(s, SLogFont, 0)				; set size
	}
	else  InsertInteger(16, SLogFont, 0)			; set size

	VarSetCapacity(SChooseFont, 60, 0) 
	InsertInteger(60,		 SChooseFont, 0)		; DWORD lStructSize 
	InsertInteger(hGui,		 SChooseFont, 4)		; HWND hwndOwner (makes dialog "modal"). 
	InsertInteger(&SLogFont, SChooseFont, 12)		; LPLOGFONT lpLogFont 
	InsertInteger(0x141,	 SChooseFont, 20)		; CF_EFFECTS = 0x100, CF_SCREENFONTS = 1, CF_INITTOLOGFONTSTRUCT = 0x40

	r := DllCall("comdlg32\ChooseFontA", "uint", &SChooseFont)  ; Display the dialog. 
	if !r
		return 1 

	;font name
	VarSetCapacity(pFace, 32)
	DllCall("RtlMoveMemory", "str", pFace, "Uint", &SLogFont + 28, "Uint", 32)
	pStyle := "s" ExtractInteger(SChooseFont, 16) // 10

	;color
	old := A_FormatInteger
	SetFormat, integer, hex							 ; Show RGB color extracted below in hex format.
	pColor := ExtractInteger(SChooseFont, 24)
	pColor := (pColor & 0xFF) << 16 | ((pColor >> 8) & 0xFF) | (pColor >> 16) 
	SetFormat, integer, %old%

	;styles
	pStyle =
	VarSetCapacity(s, 3)
	DllCall("RtlMoveMemory", "str", s, "Uint", &SLogFont + 20, "Uint", 3)

	if ExtractInteger(SLogFont, 16) >= 700
		pStyle .= " bold"

	if ExtractInteger(SLogFont, 20, false, 1)
		pStyle .= " italic"
	
	if ExtractInteger(SLogFont, 21, false, 1)
		pStyle .= " underline"

	if ExtractInteger(SLogFont, 22, false, 1)
		pStyle .= " strikeout"

	s := ExtractInteger(sLogFont, 0, true)
	pStyle .= " s" abs(s)

	return 0
}

ExtractInteger(ByRef pSource, pOffset = 0, pIsSigned = false, pSize = 4)
{
	Loop %pSize%  ; Build the integer by adding up its bytes.
		result += *(&pSource + pOffset + A_Index-1) << 8*(A_Index-1)
	if (!pIsSigned OR pSize > 4 OR result < 0x80000000)
		return result  ; Signed vs. unsigned doesn't matter in these cases.
	; Otherwise, convert the value (now known to be 32-bit) to its signed counterpart:
	return -(0xFFFFFFFF - result + 1)
}

InsertInteger(pInteger, ByRef pDest, pOffset = 0, pSize = 4)
{
	Loop %pSize%  ; Copy each byte in the integer into the structure as raw binary data.
		DllCall("RtlFillMemory", "UInt", &pDest + pOffset + A_Index-1, "UInt", 1, "UChar", pInteger >> 8*(A_Index-1) & 0xFF)
}
