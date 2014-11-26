" Vim filetype plugin file
" Language: IEC 61131-1 Structured Text
" Version: 1.0
" Maintainer: Robert Morris
" Last Change:	2013/02/18

if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

let b:match_ignorecase = 0

if exists("loaded_matchit")
	let b:match_words = &matchpairs
	let b:match_words .= '\<VAR\>:\<END_VAR\>'
	let b:match_words .= ',\<\(VAR_INPUT\|VAR_OUTPUT\|VAR_IN_OUT\|VAR_TEMP\|VAR_EXTERNAL\|VAR_ACCESS\|VAR_CONFIG\|VAR_GLOBAL\)\>:\<END_VAR\>'
	let b:match_words .= ',\<\(PROGRAM\|FUNCTION\|FUNCTION_BLOCK\|ACTION\|CONFIGURATION\|STEP\|INITIAL_STEP\|RESOURCE\|TRANSITION\|STRUCT\|TYPE\)\>:\<END_\1\>'
	let b:match_words .= ',\<IF\>:\<ELSE\>:\<ELSIF\>:\<END_IF\>'
	let b:match_words .= ',\<\(WHILE\|FOR\|REPEAT\)\>:\<END_\1\>'
endif

" Undo the stuff we changed.
let b:undo_ftplugin = "unlet! b:match_words"

" auto comment stuff
set comments=sO:*\ -,mO:*\ \ ,exO:*),s1:(*,mb:*,ex:*)
set commentstring=(*%s*)
set fo-=t fo+=croql
set textwidth=79

