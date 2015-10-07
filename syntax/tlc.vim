" Vim syntax file
" Language:     Matlab Target Language Compiler
" Current Maintainer:   Derecho (derecho@sector5d.org)
" Last Change:  2013 Dec 24
" TODO Implement folding for if-else-endif and switch-endswitch
" TODO Line continuation of TLC lines
" TODO More ?

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

" Read the C++ syntax to start with
if version < 600
  so <sfile>:p:h/cpp.vim
else
  runtime! syntax/cpp.vim
  unlet b:current_syntax
endif

syn match tlcKeyword            contained "if\|else\|elseif\|endif\|switch\|case\|default\|break\|endswitch\|foreach\|continue\|endforeach\|roll\|endroll\|for\|body\|endbody\|endfor\|generatefile\|language\|implements\|openfile\|closefile\|flushfile\|selectfile\|include\|addincludepath\|error\|warning\|trace\|exit\|define\|undef\|assign\|with\|endwith\|return\|MATLAB"
syn match tlcCommentLineStart   contained "%%"
syn match tlcCommentLine        "%%.*$" contains=tlcCommentLineStart,cTodo
syn region tlcCommentBlock       matchgroup=Todo start="/%" end="%/" fold
syn match tlcLine               "^\s*%\(function\|endfunction\|%\)\@!.*$" contains=tlcKeyword,tlcCommentLine,cString,cCharacter,cNumber
syn match tlcVar                "%<[^>]*>" contains=cString,cCharacter,cNumber containedin=cString,cCharacter
syn region tlcFunction          matchgroup=Function start="%function" end="%endfunction" fold transparent

" Default highlighting
if version >= 508 || !exists("did_tlc_syntax_inits")
  if version < 508
    let did_tlc_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif
  HiLink tlcKeyword             Statement
  HiLink tlcCommentLineStart    Comment
  HiLink tlcCommentLine         Comment
  HiLink tlcCommentBlock        Comment
  HiLink tlcLine                PreProc
  HiLink tlcVar                 PreProc
  delcommand HiLink
endif

let b:current_syntax = "tlc"

" vim: ts=8
