" Author:		Robert Morris (nonwonderdog@gmail.com)
" Credits:		Lars H. Nielsen (dengmao@gmail.com)
" Last Change:	2 September 2014
"
" Adapted from Wombat by Lars H. Nielsen

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "numbat"


" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine		guifg=NONE		guibg=#2d2d2d
  hi CursorColumn	guifg=NONE		guibg=#2d2d2d
  hi MatchParen		guifg=#ff2d2d	guibg=NONE		gui=bold	ctermfg=red		ctermbg=NONE
  hi Pmenu			guifg=#f6f3e8 	guibg=#444444
  hi PmenuSel		guifg=#000000 	guibg=#cae682
  hi PmenuSbar		guifg=NONE		guibg=#303030	gui=NONE
  hi PmenuThumb		guifg=NONE		guibg=#808080	gui=NONE
endif

" General colors
hi Cursor			guifg=NONE		guibg=#656565	gui=none
hi Normal 			guifg=#f6f3e8 	guibg=#242424 	gui=none
hi NonText 			guifg=#505050 	guibg=NONE	 	gui=none
hi LineNr 			guifg=#857b6f 	guibg=#000000 	gui=none

hi StatusLine 		guifg=#f6f3e8 	guibg=#444444 	gui=italic
hi StatusLineNC 	guifg=#857b6f 	guibg=#444444 	gui=none
hi VertSplit 		guifg=#444444 	guibg=#444444 	gui=none
hi Folded 			guibg=#262a30 	guifg=#707680 	gui=none
hi FoldColumn		guifg=#262a30	guibg=#707680	gui=none
hi Title			guifg=#f6f3e8 	guibg=NONE		gui=bold
hi Visual			guifg=#f6f3e8 	guibg=#444444	gui=none
hi SpecialKey		guifg=#505050 	guibg=NONE		gui=none

" Syntax highlighting
hi Comment			guifg=#99968b	gui=italic		ctermfg=darkgrey
hi SpecialComment	guifg=#50968b 	gui=none		ctermfg=darkgrey
hi Todo 			guifg=#e54030 	guibg=yellow2	gui=italic
hi Constant 		guifg=#e5786d 	gui=none		ctermfg=red
hi String 			guifg=#95e454 	gui=italic		ctermfg=darkgreen
hi Identifier 		guifg=#cae682 	gui=none		ctermfg=green
hi Function 		guifg=#cae682 	gui=none		ctermfg=green
hi Type 			guifg=#cae682 	gui=none		ctermfg=green
hi Statement 		guifg=#8ac6f2 	gui=none		ctermfg=darkcyan
hi Keyword			guifg=#8ac6f2 	gui=none		ctermfg=darkcyan
hi PreProc 			guifg=#e5786d 	gui=none		ctermfg=red
hi Number			guifg=#e5786d 	gui=none		ctermfg=red
hi Special			guifg=#f2da6f 	gui=none		ctermfg=brown
hi Float			guifg=#ffaa50	gui=none		ctermfg=red
hi Boolean			guifg=#d565b7	gui=none		ctermfg=red

