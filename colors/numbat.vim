" Author:       Robert Morris (nonwonderdog@gmail.com)
" Credits:      Lars H. Nielsen (dengmao@gmail.com)
"               Henry So, Jr.
"
" A modified and extended version of Wombat by Lars Nielsen.
" This version includes a modified version of the terminal color functions 
" from the Desert256 color scheme by Henry So, Jr.


set background=dark

if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif

let g:colors_name = "numbat"

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
        let l:fg = substitute(a:fg, '#','','')
        let l:bg = substitute(a:bg, '#','','')
        if l:fg != ""
            if l:fg ==? "none"
                exec "hi " . a:group . " guifg=NONE" . " ctermfg=NONE"
            else
                exec "hi " . a:group . " guifg=#" . l:fg . " ctermfg=" . <SID>rgb(l:fg)
            endif
        endif
        if l:bg != ""
            if l:bg ==? "none"
                exec "hi " . a:group . " guibg=NONE" . " ctermbg=NONE"
            else
                exec "hi " . a:group . " guibg=#" . l:bg . " ctermbg=" . <SID>rgb(l:bg)
            endif
        endif
        if a:attr != ""
            exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
        endif
    endfun
    " }}}

" Custom Color Palette {{{
let s:black     = '#242424'
let s:bblack    = '#99968b'
let s:blue      = '#8ac6f2'
let s:bblue     = '#80a0ff'
let s:green     = '#cae682'
let s:bgreen    = '#95e454'
let s:cyan      = '#50968b'
let s:bcyan     = '#34e2e2'
let s:red       = '#e5786d'
let s:bred      = '#ff2d2d'
let s:violet    = '#d565b7'
let s:yellow    = '#f2da65'
let s:orange    = '#ffaa50'
let s:white     = '#d3d7cf'
let s:bwhite    = '#f6f3e8'
" }}}

" selected xterm colors {{{
let s:red1      = '#ff0000'
let s:red2      = '#d70000'
let s:red3      = '#af0000'
let s:red4      = '#870000'
let s:red5      = '#5f0000'
let s:green1    = '#00ff00'
let s:green2    = '#00d700'
let s:green3    = '#00af00'
let s:green4    = '#008700'
let s:green5    = '#005f00'
let s:blue1     = '#0000ff'
let s:blue2     = '#0000d7'
let s:blue3     = '#0000af'
let s:blue4     = '#000087'
let s:blue5     = '#00005f'
let s:yellow1   = '#ffff00'
let s:cyan1     = '#00ffff'
let s:magenta1  = '#ff00ff'
let s:grey0     = '#000000'
let s:grey3     = '#080808'
let s:grey7     = '#121212'
let s:grey11    = '#1c1c1c'
let s:grey15    = '#262626'
let s:grey19    = '#303030'
let s:grey23    = '#3a3a3a'
let s:grey27    = '#444444'
let s:grey30    = '#4e4e4e'
let s:grey35    = '#585858'
let s:grey39    = '#626262'
let s:grey42    = '#6c6c6c'
let s:grey46    = '#767676'
let s:grey50    = '#808080'
let s:grey54    = '#8a8a8a'
let s:grey58    = '#949494'
let s:grey62    = '#9e9e9e'
let s:grey66    = '#a8a8a8'
let s:grey70    = '#b2b2b2'
let s:grey74    = '#bcbcbc'
let s:grey78    = '#c6c6c6'
let s:grey82    = '#d0d0d0'
let s:grey85    = '#dadada'
let s:grey89    = '#e4e4e4'
let s:grey93    = '#eeeeee'
let s:grey100   = '#ffffff'
" }}}

" General colors
call <SID>X('Normal',           s:bwhite,   s:grey15,   'none') 
call <SID>X('SpecialKey',       s:grey30,   '',         'none')
call <SID>X('NonText',          s:grey30,   '',         'none')
call <SID>X('Directory',        s:cyan1,    '',         'none')
call <SID>X('ErrorMsg',         s:grey100,  s:red1,     'none')
call <SID>X('IncSearch',        '',         '',         'inverse')
call <SID>X('Search',           s:grey11,   s:yellow,   'none')
call <SID>X('MoreMsg',          s:green4,   'none',     'bold')
call <SID>X('ModeMsg',          s:red,      '',         'bold')
call <SID>X('LineNr',           s:grey46,   s:grey19,   'none')
call <SID>X('CursorLineNr',     s:grey54,   '',         'bold')
call <SID>X('Question',         s:green2,   '',         'bold')
call <SID>X('StatusLine',       s:bwhite,   s:grey27,   'none')
call <SID>X('StatusLineNC',     s:grey46,   s:grey27,   'none')
call <SID>X('VertSplit',        s:grey27,   s:grey27,   'none')
call <SID>X('Title',            s:red,      '',         'bold')
call <SID>X('Visual',           s:bwhite,   s:grey27,   'none')
call <SID>X('VisualNOS',        s:bwhite,   s:grey27,   'bold,underline')
call <SID>X('WarningMsg',       s:red1,     '',         'none')
call <SID>X('WildMenu',         s:grey11,   s:yellow,   'none')
call <SID>X('Folded',           s:grey46,   s:grey19,   'none')
call <SID>X('FoldColumn',       s:grey46,   s:grey19,   'none')
call <SID>X('DiffAdd',          '',         '005f5f',   'none')
call <SID>X('DiffDelete',       '87afd7',   '005f5f',   'none')
call <SID>X('DiffChange',       '',         '005f87',   'none')
call <SID>X('DiffText',         '',         s:red4,     'none')
call <SID>X('SignColumn',       s:cyan,     s:grey19,   'none')
call <SID>X('Conceal',          s:yellow,   'none',     'none')
hi SpellBad     guisp=red       gui=undercurl   ctermfg=196 ctermbg=NONE    cterm=underline
hi SpellCap     guisp=royalblue gui=undercurl   ctermfg=63  ctermbg=NONE    cterm=underline
hi SpellRare    guisp=magenta   gui=undercurl   ctermfg=201 ctermbg=NONE    cterm=underline
hi SpellLocal   guisp=cyan      gui=undercurl   ctermfg=51  ctermbg=NONE    cterm=underline
call <SID>X('Pmenu',            s:bwhite,   s:grey27,   '')
call <SID>X('PmenuSel',         s:grey0,    s:yellow,   '')
call <SID>X('PmenuSbar',        '',         s:grey19,   'none')
call <SID>X('PmenuThumb',       '',         s:grey50,   'none')
call <SID>X('TabLine',          s:grey100,  s:grey50,   'none')
call <SID>X('TabLineSel',       s:grey100,  'none',     'bold')
call <SID>X('TabLineFill',      s:grey100,  s:grey27,   'none')
call <SID>X('CursorColumn',     '',         s:grey19,   'none')
call <SID>X('CursorLine',       '',         s:grey19,   'none')
call <SID>X('ColorColumn',      '',         s:grey19,     'none')
call <SID>X('Cursor',           '',         s:grey39,   'none')

" Syntax highlighting
call <SID>X('lCursor',          '',         s:bred,     'none')
call <SID>X('MatchParen',       s:bred,     'none',     'bold')
call <SID>X('Comment',          s:bblack,   '',         'italic')
call <SID>X('Constant',         s:red,      '',         'none')
call <SID>X('Special',          s:yellow,   '',         'none')
call <SID>X('Identifier',       s:green,    '',         'none')
call <SID>X('Statement',        s:blue,     '',         'none')
call <SID>X('PreProc',          s:red,      '',         'none')
call <SID>X('Type',             s:green,    '',         'none')
call <SID>X('Underlined',       s:bblue,    '',         'underline')
call <SID>X('Error',            s:grey100,  s:red1,     'none')
call <SID>X('Todo',             s:bcyan,    'none',     'bold,italic,underline')
call <SID>X('String',           s:bgreen,   '',         'italic')
call <SID>X('Number',           s:red,      '',         'none')
call <SID>X('Boolean',          s:orange,   '',         'none')
call <SID>X('Float',            s:orange,   '',         'none')
call <SID>X('Function',         s:green,    '',         'none')
call <SID>X('Keyword',          s:blue,     '',         'none')
call <SID>X('SpecialComment',   s:cyan,     '',         'none')

" VimOutliner headings
call <SID>X('OL1',      s:bwhite, '', 'bold')
call <SID>X('OL2',      s:red,    '', 'bold')
call <SID>X('OL3',      s:bblue,  '', 'bold')
call <SID>X('OL4',      s:orange, '', 'bold')
call <SID>X('OL5',      s:green,  '', 'bold')
call <SID>X('OL6',      s:blue,   '', 'bold')
call <SID>X('OL7',      s:yellow, '', 'bold')
call <SID>X('OL8',      s:violet, '', 'bold')
call <SID>X('OL9',      s:bwhite, '', 'bold')

" VimOutliner tags
call <SID>X('outlTags', s:red,    '', 'none')

" VimOutliner body text
call <SID>X('BT1',      s:bgreen, '', 'none')
call <SID>X('BT2',      s:bgreen, '', 'none')
call <SID>X('BT3',      s:bgreen, '', 'none')
call <SID>X('BT4',      s:bgreen, '', 'none')
call <SID>X('BT5',      s:bgreen, '', 'none')
call <SID>X('BT6',      s:bgreen, '', 'none')
call <SID>X('BT7',      s:bgreen, '', 'none')
call <SID>X('BT8',      s:bgreen, '', 'none')
call <SID>X('BT9',      s:bgreen, '', 'none')

" VimOutliner pre-formatted text
call <SID>X('PT1',      s:cyan,   '', 'none')
call <SID>X('PT2',      s:cyan,   '', 'none')
call <SID>X('PT3',      s:cyan,   '', 'none')
call <SID>X('PT4',      s:cyan,   '', 'none')
call <SID>X('PT5',      s:cyan,   '', 'none')
call <SID>X('PT6',      s:cyan,   '', 'none')
call <SID>X('PT7',      s:cyan,   '', 'none')
call <SID>X('PT8',      s:cyan,   '', 'none')
call <SID>X('PT9',      s:cyan,   '', 'none')

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
