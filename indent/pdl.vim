" Language:		Program Design Language
" Version:		1.0
" Last Change:	2013/02/15
" Maintainer:	Robert Morris

" Only load this indent file when no other was loaded yet.
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

setlocal indentexpr=GetPDLIndent()
setlocal indentkeys=!^F,o,O,:,=ELSE,=ELSIF,=END,=ENDTEST

" Only define the function once
if exists("*GetPDLIndent")
	finish
endif

function GetPDLIndent()
	" Find a non-blank line above the current line.
	let lnum = prevnonblank(v:lnum - 1)

	" At the start of the file use zero indent.
	if lnum == 0
		return 0
	endif

	" Add a 'shiftwidth' after IF, ELSE, ELSIF, TEST, CONDITION, OTHERWISE,
	" DO, FOR, and BEGIN
	let ind = indent(lnum)
	if getline(lnum) =~# '^\s*\(IF\|ELSE\|ELSIF\|TEST\|CONDITION\|OTHERWISE\|DO\|FOR\|BEGIN\)'
		let ind = ind + &sw
	endif

	" Subtract 2x 'shiftwidth' on an ENDTEST
	" Subtract a 'shiftwidth' on an END, ELSE, ELSIF, or WHILE
	" Subtract a 'shiftwidth' on a CONDITION that does not follow a TEST
	if getline(v:lnum) =~# '^\s*\(ENDTEST\)'
		let ind = ind - &sw * 2
	elseif getline(v:lnum) =~# '^\s*\(END\|ELSE\|ELSIF\|WHILE\)'
		let ind = ind - &sw
	elseif getline(v:lnum) =~# '^\s*CONDITION' && getline(lnum) !~# '^\s*TEST'
		let ind = ind - &sw
	endif

	return ind
endfunction

