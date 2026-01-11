'****************************************************************************
' PULLMENU.BAS - Pull down menu demonstration
'****************************************************************************
' qb /l qw.glb
REM $DYNAMIC
DEFINT A-Z              'Make all variables integers by default.
CALL QWINIT(4)          'Need to call this command before using any QW commands.

CLS                     'Clear the screen.
DIM SHARED menu$(16)    'Dimension string array for up to 16 menu items.
DIM SHARED bar$(10)
DIM SHARED kb(10)
DIM SHARED w(2048)      'Dimension integer array for window.
nummenus = 6            '6 menus across top (Could be up to 10)
barattr = &H40

'------------- Setup Arrays describing the menus. ---------------
' To setup the menubar & menus themselves, we use DATA statements.
' You could initialize the arrays separately & explicitly if desired.

'---- Read in strings for MENU BAR, and the associated key values ---
DATA File,8448,Edit,4608,View,12032,Search,7936,Midi,12800,Comm,11776
FOR i = 0 TO nummenus - 1
    READ bar$(i), kb(i)
NEXT i
CALL MENUBAR(nummenus, barattr, kb(), VARPTR(bar$(0)))

'---- Read in each of the menu options & xfer into internal storage ----
DATA 16,"FILE",Load,Save,Open,Close,Print,Shell,Quit,Sener,yigit,Elma,Mahir,Akdeniz,Karadeniz,Galatasaray,Konya,Adana      : 'Menu 1
DATA 4,"EDIT",Undo,Cut,Copy,Paste                             : 'Menu 2
DATA 2,"VIEW",Options,Windows                                 : 'Menu 3
DATA 4,"SEARCH",Find,Selected Text,Repeat Last Find,Change      : 'Menu 4
DATA 2,"MIDI",Record,Playback                                 : 'Menu 5
DATA 3,"COMN",Receive File,Send File,Comm Parameters          : 'Menu 6
DATA 4,"",Chicago,New York,Helvetica,Elite                : 'Menu 7
DATA 16,"",5,8,9,10,12,14,16,20,24,30,32,36,40,48,60,72   : 'Menu 8
DATA 7,"",None,Single,Double,Light,Medium,Dark,Solid      : 'Menu 9
DATA 5,"","!!!!!","#####","%%%%%","&&&&&","*****"         : 'Menu 10
FOR i = 1 TO nummenus
    READ msize, menu$(0)
    FOR j = 1 TO msize: READ a$: menu$(j) = "  " + a$: NEXT j
    CALL MENUSET(i, msize, 2, 10, 15, 7, -1, VARPTR(menu$(0)))
NEXT i

'---- Turn on menu bar ----
CALL MENUON

'---- Open a window for status information. ----
id = 1
CALL WOPEN(1, 2, 80, 24, 2, 2, "SAMPLE WINDOW", w(), id)
CALL WCOLOR(id, &H17)
CALL WCLS(id)
CALL WLOCATE(id, 2, 13)
CALL WPRINT(id, " Hold ALT key down & Press first letter of menu.")
'--- We can disable a menu option(s) ----
CALL MENUOPTION(1, 2, 0)
CALL MENUOPTION(1, 4, 0)

DO
    CALL MENUGET(m, o, f)
LOOP WHILE f = 0

stat$ = "~~ Menu: " + STR$(m) + "~ Option: " + STR$(o) + "~ Flag: " + STR$(f)
CALL WCLS(id)
CALL WLOCATE(id, 4, 13)
CALL WPRINT(id, stat$)
CALL WPRINT(id, "~~    Press ANY key to close window.")
WHILE INKEY$ = "": WEND
CALL WCLOSE(id)         'Close our status window.
CALL MENUOFF            'Turn off menu system.
END


