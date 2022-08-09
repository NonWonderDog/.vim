" Vim syntax file
" Language:     Matlab Target Language Compiler
" Current Maintainer:   Robert Morris
" Last Change:  2021 Oct 27
" TODO Line continuation (...)

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn match tlcConditional        "%if\|%elseif\|%else\|%endif\|%switch\|%endswitch"
syn match tlcLabel              "%case\|%default"
syn match tlcRepeat             "%foreach\|%for\|%endforeach\|%endfor"

syn match tlcKeyword            "%break\|%continue"
syn match tlcKeyword            "%assign"
syn match tlcKeyword            "%assert"
syn match tlcKeyword            "%selectfile"
syn match tlcKeyword            "%function\|%endfunction"

syn match keyword               "%roll\|%endroll"
syn match keyword               "%body\|%endbody"
syn match keyword               "%openfile\|%closefile\|%flushfile\|%selectfile\|%generatefile"
syn match keyword               "%include\|%addincludepath"
syn match keyword               "%error\|%warning"
syn match keyword               "%define\|%undef"
syn match keyword               "%with\|%endwith"
syn match keyword               "%language"
syn match keyword               "%implements"
syn match keyword               "%trace"
syn match keyword               "%return"
syn match keyword               "%exit"
syn match keyword               "%MATLAB"

syn match tlcOperator           "[-+*/<>&!][<>]\@!"
syn match tlcOperator           "?\=[!<>]\=="

syn keyword tlcFunction         ISFIELD FEVAL ISEMPTY EXISTS SIZE ISEQUAL WHITE_SPACE
syn keyword tlcFunction         Matrix
syn keyword tlcConstant         TLC_TRUE TLC_FALSE NULL_FILE

syn keyword tlcTodo             contained TODO FIXME XXX NOTE
syn region tlcComment           oneline start="%%" end="$" contains=tlcTodo,@spell
syn region tlcCommentBlock      matchgroup=tlcComment start="/%" end="%/" fold contains=tlcTodo,@spell

syn region tlcString		start=+L\="+ skip=+\\\\\|\\"+ end=+"+ contains=@Spell extend
" syn match tlcLine               "^\s*%\(function\|endfunction\|%\)\@!.*$" contains=tlcKeyword,tlcCommentLine,cString,cCharacter,cNumber
syn match tlcVariable           "%<[^>]*>" containedin=tlcString

syn region tlcOutput            oneline start="^\s*[^ %]" end="$" contains=tlcVariable

" syn region tlcFunction          matchgroup=tlcFunction start="%function" end="%endfunction" fold transparent

syn region tlcIf                start="%if\>" end="%endif\>" fold transparent keepend extend
syn region tlcSwitch            start="%switch\>" end="%endswitch\>" fold transparent keepend extend
syn region tlcFor               start="%for\>" end="%endfor\>" fold transparent keepend extend
syn region tlcForEach           start="%foreach\>" end="%endforeach\>" fold transparent keepend extend
syn region tlcFunctionBlock     start="%function\>" end="%endfunction\>" fold transparent keepend

" Default highlighting
hi def link tlcComment          Comment
hi def link tlcConstant         Constant
hi def link tlcConditional      Conditional
hi def link tlcFunction         Function
hi def link tlcKeyword          Keyword
hi def link tlcLabel            Label
hi def link tlcRepeat           Repeat
hi def link tlcStatement        Statement
hi def link tlcOutput           PreProc
hi def link tlcString           String
hi def link tlcOperator         Operator
hi def link tlcVariable         Special

syntax sync fromstart

let b:current_syntax = "tlc"

" vim: ts=8
