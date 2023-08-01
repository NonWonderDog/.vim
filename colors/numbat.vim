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
    fun s:grey_number(x)
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
    fun s:grey_level(n)
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
    fun s:grey_color(n)
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
    fun s:rgb_number(x)
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
    fun s:rgb_level(n)
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
    fun s:rgb_color(x, y, z)
        if &t_Co == 88
            return 16 + (a:x * 16) + (a:y * 4) + a:z
        else
            return 16 + (a:x * 36) + (a:y * 6) + a:z
        endif
    endfun

    " returns the palette index to approximate the given R/G/B color levels
    fun s:color(r, g, b)
        " get the closest grey
        let l:gx = s:grey_number(a:r)
        let l:gy = s:grey_number(a:g)
        let l:gz = s:grey_number(a:b)

        " get the closest color
        let l:x = s:rgb_number(a:r)
        let l:y = s:rgb_number(a:g)
        let l:z = s:rgb_number(a:b)

        if l:gx == l:gy && l:gy == l:gz
            " there are two possibilities
            let l:dgr = s:grey_level(l:gx) - a:r
            let l:dgg = s:grey_level(l:gy) - a:g
            let l:dgb = s:grey_level(l:gz) - a:b
            let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
            let l:dr = s:rgb_level(l:gx) - a:r
            let l:dg = s:rgb_level(l:gy) - a:g
            let l:db = s:rgb_level(l:gz) - a:b
            let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
            if l:dgrey < l:drgb
                " use the grey
                return s:grey_color(l:gx)
            else
                " use the color
                return s:rgb_color(l:x, l:y, l:z)
            endif
        else
            " only one possibility
            return s:rgb_color(l:x, l:y, l:z)
        endif
    endfun

    " returns the palette index to approximate the 'rrggbb' hex string
    fun s:rgb(rgb)
        let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
        let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
        let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

        return s:color(l:r, l:g, l:b)
    endfun

    " sets the highlighting for the given group
    fun s:X(group, fg, bg, attr)
        let l:fg = substitute(a:fg, '#','','')
        let l:bg = substitute(a:bg, '#','','')
        if l:fg != ""
            if l:fg ==? "none"
                exec "hi " . a:group . " guifg=NONE" . " ctermfg=NONE"
            else
                exec "hi " . a:group . " guifg=#" . l:fg . " ctermfg=" . s:rgb(l:fg)
            endif
        endif
        if l:bg != ""
            if l:bg ==? "none"
                exec "hi " . a:group . " guibg=NONE" . " ctermbg=NONE"
            else
                exec "hi " . a:group . " guibg=#" . l:bg . " ctermbg=" . s:rgb(l:bg)
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
call s:X('Normal',           s:bwhite,   s:grey15,   'none') 
call s:X('SpecialKey',       s:grey30,   '',         'none')
call s:X('NonText',          s:grey30,   '',         'none')
call s:X('Directory',        s:cyan1,    '',         'none')
call s:X('ErrorMsg',         s:grey100,  s:red1,     'none')
call s:X('IncSearch',        '',         '',         'inverse')
call s:X('Search',           s:grey11,   s:yellow,   'none')
call s:X('MoreMsg',          s:green4,   'none',     'bold')
call s:X('ModeMsg',          s:red,      '',         'bold')
call s:X('LineNr',           s:grey46,   s:grey19,   'none')
call s:X('CursorLineNr',     s:grey54,   '',         'bold')
call s:X('Question',         s:green2,   '',         'bold')
call s:X('StatusLine',       s:bwhite,   s:grey27,   'none')
call s:X('StatusLineNC',     s:grey46,   s:grey27,   'none')
call s:X('VertSplit',        s:grey27,   s:grey27,   'none')
call s:X('Title',            s:red,      '',         'bold')
call s:X('Visual',           s:bwhite,   s:grey27,   'none')
call s:X('VisualNOS',        s:bwhite,   s:grey27,   'bold,underline')
call s:X('WarningMsg',       s:red1,     '',         'none')
call s:X('WildMenu',         s:grey11,   s:yellow,   'none')
call s:X('Folded',           s:grey46,   s:grey19,   'none')
call s:X('FoldColumn',       s:grey46,   s:grey19,   'none')
call s:X('DiffAdd',          '',         '005f5f',   'none')
call s:X('DiffDelete',       '87afd7',   '005f5f',   'none')
call s:X('DiffChange',       '',         '005f87',   'none')
call s:X('DiffText',         '',         s:red4,     'none')
call s:X('SignColumn',       s:cyan,     s:grey19,   'none')
call s:X('Conceal',          s:yellow,   'none',     'none')
hi SpellBad     guisp=red       gui=undercurl   ctermfg=196 ctermbg=NONE    cterm=underline
hi SpellCap     guisp=royalblue gui=undercurl   ctermfg=63  ctermbg=NONE    cterm=underline
hi SpellRare    guisp=magenta   gui=undercurl   ctermfg=201 ctermbg=NONE    cterm=underline
hi SpellLocal   guisp=cyan      gui=undercurl   ctermfg=51  ctermbg=NONE    cterm=underline
call s:X('Pmenu',            s:bwhite,   s:grey27,   '')
call s:X('PmenuSel',         s:grey0,    s:yellow,   '')
call s:X('PmenuSbar',        '',         s:grey19,   'none')
call s:X('PmenuThumb',       '',         s:grey50,   'none')
call s:X('TabLine',          s:grey100,  s:grey50,   'none')
call s:X('TabLineSel',       s:grey100,  'none',     'bold')
call s:X('TabLineFill',      s:grey100,  s:grey27,   'none')
call s:X('CursorColumn',     '',         s:grey19,   'none')
call s:X('CursorLine',       '',         s:grey19,   'none')
call s:X('ColorColumn',      '',         s:grey19,     'none')
call s:X('Cursor',           '',         s:grey39,   'none')

" Syntax highlighting
call s:X('lCursor',          '',         s:bred,     'none')
call s:X('MatchParen',       s:bred,     'none',     'bold')
call s:X('Comment',          s:bblack,   '',         'italic')
call s:X('Constant',         s:red,      '',         'none')
call s:X('Special',          s:yellow,   '',         'none')
call s:X('Identifier',       s:green,    '',         'none')
call s:X('Statement',        s:blue,     '',         'none')
call s:X('PreProc',          s:red,      '',         'none')
call s:X('Type',             s:green,    '',         'none')
call s:X('Underlined',       s:bblue,    '',         'underline')
call s:X('Error',            s:grey100,  s:red1,     'none')
call s:X('Todo',             s:bcyan,    'none',     'bold,italic,underline')
call s:X('String',           s:bgreen,   '',         'italic')
call s:X('Number',           s:red,      '',         'none')
call s:X('Boolean',          s:orange,   '',         'none')
call s:X('Float',            s:orange,   '',         'none')
call s:X('Function',         s:green,    '',         'none')
call s:X('Keyword',          s:blue,     '',         'none')
call s:X('SpecialComment',   s:cyan,     '',         'none')

" VimOutliner headings
call s:X('OL1',      s:bwhite, '', 'bold')
call s:X('OL2',      s:red,    '', 'bold')
call s:X('OL3',      s:bblue,  '', 'bold')
call s:X('OL4',      s:orange, '', 'bold')
call s:X('OL5',      s:green,  '', 'bold')
call s:X('OL6',      s:blue,   '', 'bold')
call s:X('OL7',      s:yellow, '', 'bold')
call s:X('OL8',      s:violet, '', 'bold')
call s:X('OL9',      s:bwhite, '', 'bold')

" VimOutliner tags
call s:X('outlTags', s:red,    '', 'none')

" VimOutliner body text
call s:X('BT1',      s:bgreen, '', 'none')
call s:X('BT2',      s:bgreen, '', 'none')
call s:X('BT3',      s:bgreen, '', 'none')
call s:X('BT4',      s:bgreen, '', 'none')
call s:X('BT5',      s:bgreen, '', 'none')
call s:X('BT6',      s:bgreen, '', 'none')
call s:X('BT7',      s:bgreen, '', 'none')
call s:X('BT8',      s:bgreen, '', 'none')
call s:X('BT9',      s:bgreen, '', 'none')

" VimOutliner pre-formatted text
call s:X('PT1',      s:cyan,   '', 'none')
call s:X('PT2',      s:cyan,   '', 'none')
call s:X('PT3',      s:cyan,   '', 'none')
call s:X('PT4',      s:cyan,   '', 'none')
call s:X('PT5',      s:cyan,   '', 'none')
call s:X('PT6',      s:cyan,   '', 'none')
call s:X('PT7',      s:cyan,   '', 'none')
call s:X('PT8',      s:cyan,   '', 'none')
call s:X('PT9',      s:cyan,   '', 'none')

" delete functions {{{
delf s:X
delf s:rgb
delf s:color
delf s:rgb_color
delf s:rgb_level
delf s:rgb_number
delf s:grey_color
delf s:grey_level
delf s:grey_number
" }}}

" vim:set fdm=marker:
