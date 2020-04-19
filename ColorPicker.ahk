/*  * * * * * * * * * * * * * * * * * * * * * * * * * * * *

    Disclaimer:

    I do not foresee any risk in running this script but
    you may run this file "ONLY" at your own risk. 	

    * * * * * * * * * * * * * * * * * * * * * * * * * * * * 

File Name   : ColorPicker.ahk 		Version : 1.20 Beta

Main Title  : AutoHotkey Include
Sub Title   : ColorPicker Utility
Posted @    : http://www.autohotkey.com/forum/viewtopic.php?p=57968#57968

Description : You may use this ColorPicker utility from your Script by including this script 
              and call it with ColorPicker() function.
              
              Example:
                         CurrentColor  := "FFFFFF"
                         SelectedColor := ColorPicker(CurrentColor)
                         Return
                         #Include ColorPicker.ahk

              This Utility will ALSO run as standalone.
              Will remember its last GUI Position ( through INI File )
              16 Favorite colors can be stored ( through INI File). When 
              17th color is added 1st Color will be removed

              One may use the Colors.htm provided in the bundle to select favorite colors.

Special Note: This file requires to be named ColorPicker.ahk for proper functioning.
              
Credits     : Inspired by / Ideas have been adapted from,

              Krappy Color Picker
              by Lego_Coder / Miguel Agullo                          
              http://www.autohotkey.com/forum/viewtopic.php?t=6693

              Function StringSlice was written by me and posted 
              @ http://www.autohotkey.com/forum/viewtopic.php?p=53084#53084

              Mr.Laszlo Hars was very kind to optimise it & remove the bugs 
              @ http://www.autohotkey.com/forum/viewtopic.php?p=53092#53092

Author      : A.N.Suresh Kumar aka "Goyyah"
Email       : arian.suresh@gmail.com

Created     : 2006-04-24
Modified    : 2006-06-18
Version     : 1.20 Beta

Scripted in : AutoHotkey Version 1.0.43.04 , www.autohotkey.com 

*/

return

;--------------------------------------------------------------------------------------------

ColorPicker(HEXString="",Title="") {
  
  Global

  If HEXString=
     CurrentColor:="FFFFFF"
  else
     CurrentColor:=HexString

  ValidColor:=CheckHexC(CurrentColor)
  If ! ValidColor
     CurrentColor:="000000"

  GradientColorBand(CurrentColor)

  If Title=
     WinTitle:="AutoHotkey Color Picker"
  Else
     WinTitle:=Title

  IniRead,GuiPos,ColorPicker.ini,Settings,GuiPos 

  If GUIPos!=ERROR
     StringSplit,Pos,GuiPos,`, 

  GoSub, CreateGUI
  WinWaitClose, %WinTitle%
Return CurrentColor
}

;--------------------------------------------------------------------------------------------

CreateGUI:

 Gui, 1:+LastFound
 if WinExist("A")
    {
    Gui, 4:+Owner1
    Gui, 4:-AlwaysOnTop
    }

 Gui, 4:+AlwaysOnTop
 Gui, 4:+ToolWindow

 Gui, 4:Font, S9 , Verdana
 Gui,Margin,5,5

 H=20
 W=20

 LineNo=1

 Gui, 4:Add,GroupBox, x10      w215 h175, Basic Colors
 Gui, 4:Add,GroupBox, x10 y+5  w215 h75 , My Favorite Colors
 Gui, 4:Add,GroupBox, x235 y5  w215 h125 
 Gui, 4:Add,GroupBox, x460 y5 h230

 Gui, 4:add,Picture, x464 y16 gSelColor, icons\Colors.bmp
 Gui, 4:Add, ListView, x20 y25  h%H% w%W% ReadOnly 0x4000 +BackgroundFF8080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFFFF80 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background80FF80 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background00FF80 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background80FFFF AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background0080FF AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF80C0 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF80FF AltSubmit gSelColor 

 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +BackgroundFF0000 AltSubmit gSelColor
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFFFF00 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background80FF00 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background00FF40 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background00FFFF AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background0080C0 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background8080C0 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF00FF AltSubmit gSelColor 

 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +Background804040 AltSubmit gSelColor
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF8040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background00FF00 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background008080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background004080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background8080FF AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background800040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF0080 AltSubmit gSelColor 

 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +Background800000 AltSubmit gSelColor
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFF8000 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background008000 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background008040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background0000FF AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background0000A0 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background800080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background8000FF AltSubmit gSelColor 

 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +Background400000 AltSubmit gSelColor
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background804000 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background004000 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background004040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background400040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background400080 AltSubmit gSelColor 
 
 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background808000 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background808040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background808080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background408080 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundC0C0C0 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background400040 AltSubmit gSelColor 
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +BackgroundFFFFFF AltSubmit gSelColor 

 Gui, 4:Add, ListView, x20 y+35 h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor01
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor02
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor03
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor04
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor05
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor06
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor07
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor08

 Gui, 4:Add, ListView, x20  y+5 h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor09
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor10
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor11
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor12
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor13
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor14
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor15
 Gui, 4:Add, ListView, x+5      h%H% w%W% ReadOnly 0x4000 +Background000000 AltSubmit gSelColor vFColor16

 GoSub, LoadFavColors

 Gui, 4:Add, Text  , X245  y19 w37 h18 Center , Red
 Gui, 4:Add, Slider, X+5   Thick16 w110 h18 Center NoTicks Range0-255 AltSubmit gUpdateSlider vRSlider
 Gui, 4:Add, Edit  , X+5   W37 h18 Right ReadOnly vRVal, % RGB1

 Gui, 4:Add, Text  , X245  y+3 w37 h18 Center, Green
 Gui, 4:Add, Slider, x+5   Thick16 w110 h18 Center NoTicks Range0-255 AltSubmit gUpdateSlider vGSlider
 Gui, 4:Add, Edit  , X+5   W37 h18 Right ReadOnly vGVal, % RGB2

 Gui, 4:Add, Text  , X245  y+3 w37 h18 Center, Blue
 Gui, 4:Add, Slider, x+5   Thick16 w110 h18 Center NoTicks Range0-255 AltSubmit gUpdateSlider vBSlider 
 Gui, 4:Add, Edit  , X+5   W37 h18 Right ReadOnly vBVal, % RGB3

 Gui, 4:Add, Picture, x244 y+12 w192 h10 E0x200 vColorBand , %A_Temp%\ColorPicker_3x1.bmp
 Gui, 4:Add, Slider,  x238 y+1 Thick16 Left w209 h19 NoTicks Range1-192 AltSubmit vCBSlider gColorBandSel, 96 
 
 Gui, 4:Add, Text    , x259 y137 w70 h16 Center %PrvOption% , Previous
 Gui, 4:Add, ListView, x259 y+1  h32 w70 ReadOnly 0x4000 +Background%CurrentColor% AltSubmit gSelColor
 Gui, 4:Add, Text    , x259 y+1      w70 Center %PrvOption% , %CurrentColor%

 Gui, 4:Add, Text    , x354 y137 w70 h16 Center, Current 
 Gui, 4:Add, ListView, x354 y+1  h32 w70 ReadOnly 0x4000 +Background%CurrentColor% vCColor AltSubmit gSelColor
 Gui, 4:Add, Text    , x354 y+1      w70 Center vCurrentColor

 Gui, 4:Add, Button, x250 y210 w90 h21 Center 0x8000               gFavColors, &Favorites
 Gui, 4:Add, Button, x+5       w90 h21 Center 0x8000 %ClipboardOption%  gCopy_Hex_To_Clipboard, &Clipboard
 Gui, 4:Add, Button, x280 y+5  w60 h21 Center 0x8000 gOkay, &Okay
 Gui, 4:Add, Button,x+5        w60 h21 Center 0x8000 gCancel, Cance&l 
 GoSub, UpdateSlider

 GuiControl, 4:,CurrentColor, % CurrentColor
 GuiControl, 4:+Background%CurrentColor%, CColor,% CurrentColor

 RGB := HEX2RGB(CurrentColor)
 StringSplit,_RGB, RGB, `,

 RSlider := _RGB1
 GSlider := _RGB2
 BSlider := _RGB3

 GoSub, UpdateSlider

 GuiControl, 4:, RSlider, % _RGB1
 GuiControl, 4:, GSlider, % _RGB2
 GuiControl, 4:, BSlider, % _RGB3

  if Pos1!=
     Gui, 4:Show, x%Pos1% y%Pos2%, %WinTitle%
  else
     Gui, 4:Show, Center, %WinTitle%

Return
;--------------------------------------------------------------------------------------------

SelColor:

If A_GuiEvent=Normal
   {
    MouseGetPos,X,Y
    PixelGetColor,CurrentColor,%X%,%Y%,RGB
    StringRight,CurrentColor,CurrentColor,6

      If A_GuiControl <> ColorBand
        {
         GradientColorBand(CurrentColor)
         GuiControl, 4:, ColorBand, %A_Temp%\ColorPicker_3x1.bmp
        }

    RGB := HEX2RGB(CurrentColor)
    StringSplit,_RGB, RGB, `,

    GuiControl, 4:, RSlider, % _RGB1
    GuiControl, 4:, GSlider, % _RGB2
    GuiControl, 4:, BSlider, % _RGB3
 
    GuiControl, 4:,CurrentColor, % CurrentColor
    GuiControl, 4:+Background%CurrentColor%, CurrentColor

    GuiControl, 4:, CBSlider, 96
    GoSub, UpdateSlider

   }
Return

;--------------------------------------------------------------------------------------------

UpdateSlider:

  Gui, Submit, Nohide

  RGB1 := RSlider
  RGB2 := GSlider
  RGB3 := BSlider

  RGBString = % RGB1 "," RGB2 "," RGB3
  Colorr := RGB2HEX(RGBString)
 
  GuiControl, 4:,CurrentColor, % Colorr
  GuiControl, 4:+Background%Colorr%, CColor,% Colorr

  GuiControl, 4:, RVal, %RGB1%
  GuiControl, 4:, GVal, %RGB2%
  GuiControl, 4:, BVal, %RGB3%

Return 

Copy_Hex_To_Clipboard:

  GuiControlGet, CurrentColor, ,CurrentColor
  Clipboard:=CurrentColor
Return

;--------------------------------------------------------------------------------------------

LoadFavColors:

  IniRead,FColors,ColorPicker.ini,Settings,FColors
  IF FColors=ERROR
     IniWrite,%Nothing%,ColorPicker.ini,Settings,FColors     
  Else
     StringSlice(FColors,6,"Fav")

  Loop, % FAV0
    {
     VarName = % "FAV" A_Index
     FavColor := %VarName%
     FavIndex=0%A_Index%
     StringRight, FavIndex, FavIndex, 2
     FavControl = FColor%FavIndex%
     GuiControl,4:+BackGround%FavColor%, %FavControl%, %FavColor%
    }
Return

;--------------------------------------------------------------------------------------------

FavColors:

  IniRead,FColors,ColorPicker.ini,Settings,FColors

  IF FColors=ERROR
     IniWrite,%Nothing%,ColorPicker.ini,Settings,FColors
  Else
     StringRight,FColors,FColors,90

  GuiControlGet, CurrentColor, ,CurrentColor
  FColors= % FColors CurrentColor

  IniWrite,%FColors%,ColorPicker.ini,Settings,FColors  
  GoSub, LoadFavColors
Return

;--------------------------------------------------------------------------------------------

ColorBandSel:

x:=248+CBSlider
PixelGetColor, CBColor, %X%, 117, ALT RGB
StringRight, CUrrentColor, CBColor, 6 

    RGB := HEX2RGB(CurrentColor)
    StringSplit,_RGB, RGB, `,

    GuiControl, 4:, RSlider, % _RGB1
    GuiControl, 4:, GSlider, % _RGB2
    GuiControl, 4:, BSlider, % _RGB3
 
    GuiControl, 4:,CurrentColor, % CurrentColor
    GuiControl, 4:+Background%CurrentColor%, CurrentColor
 
    GoSub, UpdateSlider

Return

;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Exit Routines

Cancel:
4GuiEscape:
4GuiClose:
  CUrrentColor:=""
  GoSub,SavePosThenExit
Return

Okay:
  GuiControlGet, CurrentColor, ,CurrentColor
  GoSub,SavePosThenExit
Return

SavePosThenExit:
  WinGetActiveStats, Title, Width, Height, xPos, yPos 

 IniWrite,%xPos%`,%yPos%,ColorPicker.ini,Settings,GuiPos
 Gui,4:Destroy
Return
;- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - RGB & HEX Functions

HEX2RGB(HEXString,Delimiter="")
{
 If Delimiter=
    Delimiter=,
 
 StringMid,R,HexString,1,2
 StringMid,G,HexString,3,2
 StringMid,B,HexString,5,2

 R = % "0x"R 
 G = % "0x"G
 B = % "0x"B
 
 R+=0
 G+=0
 B+=0

 RGBString = % R Delimiter G Delimiter B

Return RGBString
}


RGB2HEX(RGBString,Delimiter="") 
{ 
 If Delimiter=
    Delimiter=,
 StringSplit,_RGB,RGBString,%Delimiter%

 SetFormat, Integer, Hex 
 _RGB1+=0
 _RGB2+=0
 _RGB3+=0

 If StrLen(_RGB1) = 3
    _RGB1= 0%_RGB1%

 If StrLen(_RGB2) = 3
    _RGB2= 0%_RGB2%

 If StrLen(_RGB3) = 3
    _RGB3= 0%_RGB3%

 SetFormat, Integer, D 
 HEXString = % _RGB1 _RGB2 _RGB3
 StringReplace, HEXString, HEXString,0x,,All
 StringUpper, HEXString, HEXString

Return, HEXString
} 


CheckHexC(HEXString)
{
  StringUpper, HEXString, HEXString

  RGB:=HEX2RGB(HEXString)
  CHK:=RGB2HEX(RGB)

  StringUpper, CHK, CHK

  If CHK=%HEXString%
     Return 1
  else
     Return 0
}

GradientColorBand(RGB) { 
  file= %A_Temp%\ColorPicker_3x1.bmp
  StringMid,R,RGB,1,2
  StringMid,G,RGB,3,2
  StringMid,B,RGB,5,2

   Hs1:="424d42000000000000003600000028000000030000000100000001"
   Hs2:="001800000000000c00000000000000000000000000000000000000"
   Hs3:="FFFFFF" B G R "000000000000"

   HexString:= Hs1 Hs2 Hs3 

   Handle:= DllCall("CreateFile","str",file,"Uint",0x40000000
                ,"Uint",0,"UInt",0,"UInt",4,"Uint",0,"UInt",0) 

   Loop 66 { 
     StringLeft, Hex, HexString, 2         
     StringTrimLeft, HexString, HexString, 2  
     Hex = 0x%Hex%
     DllCall("WriteFile","UInt", Handle,"UChar *", Hex
     ,"UInt",1,"UInt *",UnusedVariable,"UInt",0) 
    } 
  
   DllCall("CloseHandle", "Uint", Handle)

Return File
} 

StringSlice(String,n,ArrayName="")  
{ 
  Local k        
  IfEqual ArrayName,,SetEnv ArrayName,Array 

  k := Ceil(StrLen(String)/n) 
  Loop %k% 
    StringMid %ArrayName%%A_Index%, String, A_Index*n-n+1, n 
  %ArrayName%0 = %k% 
  Return k 
}

; End
