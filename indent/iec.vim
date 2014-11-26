" Language:     IEC 61131-1 Structured Text
" Version:      1.0
" Last Change:  2013/02/15
" Maintainer:   Robert Morris

" Only load this indent file when no other was loaded yet.
if exists("b:did_indent")
    finish
endif
let b:did_indent = 1

setlocal indentexpr=GetIECIndent()
setlocal indentkeys=!^F,o,O,=ELSE,=ELSIF,=END,*<Return>,=END_WHILE,=END_FOR,=END_REPEAT,=END_IF,=END_CASE,=END_VAR,=);

" Only define the function once
if exists("*GetIECIndent")
    finish
endif

function GetIECIndent()
    " Find a non-blank line above the current line.
    let lnum = prevnonblank(v:lnum - 1)

    " At the start of the file use zero indent.
    if lnum == 0
        return 0
    endif

    " Add a 'shiftwidth' after a WHILE, FOR, REPEAT, IF, ELSE, or CASE
    let ind = indent(lnum)
    if getline(lnum) =~# '^\s*\(VAR\|VAR_INPUT\|VAR_OUTPUT\|VAR_IN_OUT\|VAR_TEMP\|VAR_EXTERNAL\|VAR_ACCESS\|VAR_CONFIG\|VAR_GLOBAL\)'
        let ind = ind + &sw
    elseif getline(lnum) =~# '^\s*\(WHILE\|FOR\|REPEAT\|IF\|ELSE\|ELSIF\|CASE\)'
        let ind = ind + &sw
"   elseif getline(lnum) =~# '^\s*\(PROGRAM\|FUNCTION\|FUNCTION_BLOCK\)'
"       let ind = ind + &sw
    elseif getline(lnum) =~# '^\s*\(ACTION\|CONFIGURATION\|STEP\|INITIAL_STEP\|RESOURCE\|TRANSITION\)'
        let ind = ind + &sw
"   elseif getline(lnum) =~# '^\s*\(STRUCT\|TYPE\)'
"       let ind = ind + &sw
    endif

    " Subtract a 'shiftwidth' on an END, ELSE, or ELSIF
    if getline(v:lnum) =~# '^\s*\(END_WHILE\|END_FOR\|END_REPEAT\|END_IF\|END_CASE\|END_VAR\|ELSE\|ELSIF\)'
        let ind = ind - &sw
    elseif getline(v:lnum) =~# '^\s*\(END_ACTION\|END_CONFIGURATION\|END_STEP\|END_RESOURCE\|END_TRANSITION\)'
        let ind = ind - &sw
    endif

    " Remove a shiftwidth for a CASE label, 
    " but not after a ':=' operator or in a VAR declaration
    " TODO: code labels outside of a CASE structure
    if getline(v:lnum) =~# ':\s*$'
        let ind = ind - &sw
    endif
    if getline(lnum) =~# ':\s*$'
        let ind = ind + &sw
    endif

    " TODO: multi-line function calls, etc.
    " eg:
    " Function(
    "   IN := (x AND y) OR c,
    "   T := T#500ms
    " );
    if getline(lnum) =~# '(\s*$'
        let ind = ind + &sw
    endif
    if getline(v:lnum) =~# '^);\s*$'
        let ind = ind - &sw
    endif

    " TODO: Comment alignment
    " Or at least make this stop overriding the 'comments' definition
    if getline(lnum) =~# '(\*' && getline(lnum) !~# '\*)'
        let ind = ind + 1
    endif
    if getline(lnum) !~# '(\*' && getline(lnum) =~# '\*)'
        let ind = ind - 1
    endif

    return ind
endfunction

