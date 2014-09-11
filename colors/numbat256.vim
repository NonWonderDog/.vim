" Author:		Robert Morris (nonwonderdog@gmail.com)
" Credits:		Lars H. Nielsen (dengmao@gmail.com)
"				Henry So, Jr.
" Last Change:	2 September 2014
"
" A modified and extended version of Wombat by Lars Nielsen.
" This version includes the terminal color functions from the Desert256 color 
" scheme by Henry So, Jr.


set background=dark

if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

let g:colors_name = "numbat256"

" Low-color terminal uses Desert {{{
if !(has("gui_running") || &t_Co == 88 || &t_Co == 256)
	" basic terminal colors from Desert
    hi SpecialKey    ctermfg=darkgreen
    hi NonText       cterm=bold ctermfg=darkblue
    hi Directory     ctermfg=darkcyan
    hi ErrorMsg      cterm=bold ctermfg=7 ctermbg=1
    hi IncSearch     cterm=NONE ctermfg=yellow ctermbg=green
    hi Search        cterm=NONE ctermfg=grey ctermbg=blue
    hi MoreMsg       ctermfg=darkgreen
    hi ModeMsg       cterm=NONE ctermfg=brown
    hi LineNr        ctermfg=3
    hi Question      ctermfg=green
    hi StatusLine    cterm=bold,reverse
    hi StatusLineNC  cterm=reverse
    hi VertSplit     cterm=reverse
    hi Title         ctermfg=5
    hi Visual        cterm=reverse
    hi VisualNOS     cterm=bold,underline
    hi WarningMsg    ctermfg=1
    hi WildMenu      ctermfg=0 ctermbg=3
    hi Folded        ctermfg=darkgrey ctermbg=NONE
    hi FoldColumn    ctermfg=darkgrey ctermbg=NONE
    hi DiffAdd       ctermbg=4
    hi DiffChange    ctermbg=5
    hi DiffDelete    cterm=bold ctermfg=4 ctermbg=6
    hi DiffText      cterm=bold ctermbg=1
    hi Comment       ctermfg=darkcyan
    hi Constant      ctermfg=brown
    hi Special       ctermfg=5
    hi Identifier    ctermfg=6
    hi Statement     ctermfg=3
    hi PreProc       ctermfg=5
    hi Type          ctermfg=2
    hi Underlined    cterm=underline ctermfg=5
    hi Ignore        ctermfg=darkgrey
    hi Error         cterm=bold ctermfg=7 ctermbg=1
	finish
endif
" }}}

	" functions {{{
    " returns an approximate grey index for the given grey level
    fun <SID>grey_number(x)
        if &t_Co == 88
            if a:x < 23
                return 0
            elseif a:x < 69
                return 1
            elseif a:x < 103
                return 2
            elseif a:x < 127
                return 3
            elseif a:x < 150
                return 4
            elseif a:x < 173
                return 5
            elseif a:x < 196
                return 6
            elseif a:x < 219
                return 7
            elseif a:x < 243
                return 8
            else
                return 9
            endif
        else
            if a:x < 14
                return 0
            else
                let l:n = (a:x - 8) / 10
                let l:m = (a:x - 8) % 10
                if l:m < 5
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual grey level represented by the grey index
    fun <SID>grey_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 46
            elseif a:n == 2
                return 92
            elseif a:n == 3
                return 115
            elseif a:n == 4
                return 139
            elseif a:n == 5
                return 162
            elseif a:n == 6
                return 185
            elseif a:n == 7
                return 208
            elseif a:n == 8
                return 231
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 8 + (a:n * 10)
            endif
        endif
    endfun

    " returns the palette index for the given grey index
    fun <SID>grey_color(n)
        if &t_Co == 88
            if a:n == 0
                return 16
            elseif a:n == 9
                return 79
            else
                return 79 + a:n
            endif
        else
            if a:n == 0
                return 16
            elseif a:n == 25
                return 231
            else
                return 231 + a:n
            endif
        endif
    endfun

    " returns an approximate color index for the given color level
    fun <SID>rgb_number(x)
        if &t_Co == 88
            if a:x < 69
                return 0
            elseif a:x < 172
                return 1
            elseif a:x < 230
                return 2
            else
                return 3
            endif
        else
            if a:x < 75
                return 0
            else
                let l:n = (a:x - 55) / 40
                let l:m = (a:x - 55) % 40
                if l:m < 20
                    return l:n
                else
                    return l:n + 1
                endif
            endif
        endif
    endfun

    " returns the actual color level for the given color index
    fun <SID>rgb_level(n)
        if &t_Co == 88
            if a:n == 0
                return 0
            elseif a:n == 1
                return 139
            elseif a:n == 2
                return 205
            else
                return 255
            endif
        else
            if a:n == 0
                return 0
            else
                return 55 + (a:n * 40)
            endif
        endif
    endfun

    " returns the palette index for the given R/G/B color indices
    fun <SID>rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun <SID>color(r, g, b)
        " get the closest grey
        let l:gx = <SID>grey_number(a:r)
        let l:gy = <SID>grey_number(a:g)
        let l:gz = <SID>grey_number(a:b)

        " get the closest color
        let l:x = <SID>rgb_number(a:r)
        let l:y = <SID>rgb_number(a:g)
        let l:z = <SID>rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = <SID>grey_level(l:gx) - a:r
            let l:dgg = <SID>grey_level(l:gy) - a:g
            let l:dgb = <SID>grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = <SID>rgb_level(l:gx) - a:r
            let l:dg = <SID>rgb_level(l:gy) - a:g
            let l:db = <SID>rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return <SID>grey_color(l:gx)
            else
                " use the color
                return <SID>rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return <SID>rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun <SID>rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return <SID>color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun <SID>X(group, fg, bg, attr)
        if a:fg != ""
            exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
        endif
        if a:bg != ""
            exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
        endif
        if a:attr != ""
			exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

call <SID>X("Normal", 			"f6f3e8", 	"242424", 	"none")

call <SID>X("Cursor",			"",			"656565",	"none")
call <SID>X("CursorLine",		"",			"2d2d2d",	"")
call <SID>X("CursorColumn",		"",			"2d2d2d",	"")

call <SID>X("MatchParen",		"ff2d2d",	"242424",	"bold")
call <SID>X("Pmenu",			"f6f3e8", 	"444444",	"")
call <SID>X("PmenuSel",			"000000", 	"cae682",	"")
call <SID>X("PmenuSbar",		"",			"303030",	"NONE")
call <SID>X("PmenuThumb",		"",			"808080",	"NONE")

call <SID>X("NonText", 			"505050", 	"",			"none")
call <SID>X("LineNr", 			"857b6f", 	"000000", 	"none")

call <SID>X("StatusLine", 		"f6f3e8", 	"444444", 	"italic")
call <SID>X("StatusLineNC", 	"857b6f", 	"444444", 	"none")
call <SID>X("VertSplit", 		"444444", 	"444444", 	"none")
call <SID>X("Folded", 		 	"707680", 	"2b2b2b",	"none")
call <SID>X("Title",			"f6f3e8", 	"",			"bold")
call <SID>X("Visual",			"f6f3e8", 	"444444",	"none")
call <SID>X("SpecialKey",		"505050", 	"",			"none")

" Syntax highlighting
call <SID>X("Comment",			"99968b",	"",			"italic")
call <SID>X("SpecialComment",	"50968b", 	"",			"none")
call <SID>X("Todo", 			"e54030", 	"eeee00",	"italic")
call <SID>X("Constant", 		"e5786d", 	"",			"none")
call <SID>X("String", 			"95e454", 	"",			"italic")
call <SID>X("Identifier", 		"cae682", 	"",			"none")
call <SID>X("Function", 		"cae682", 	"",			"none")
call <SID>X("Type", 			"cae682", 	"",			"none")
call <SID>X("Statement", 		"8ac6f2", 	"",			"none")
call <SID>X("Keyword",			"8ac6f2", 	"",			"none")
call <SID>X("PreProc", 			"e5786d", 	"",			"none")
call <SID>X("Number",			"e5786d", 	"",			"none")
call <SID>X("Special",			"f2da6f", 	"",			"none")
call <SID>X("Float",			"ffaa50",	"",			"none")
call <SID>X("Boolean",			"e454ba",	"",			"none")

hi! link VisualNOS		Visual
hi! link FoldColumn		Folded

" delete functions {{{
delf <SID>X
delf <SID>rgb
delf <SID>color
delf <SID>rgb_color
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_color
delf <SID>grey_level
delf <SID>grey_number
" }}}

" vim:set fdm=marker: