" Vim syntax file
" Language:		Program Design Language
" Version:		1.0
" Last Change:	2013/02/18
" Maintainer:	Robert Morris

if exists("b:current_syntax")
	finish
endif

syn case match

syn keyword pdlConditional		contained	IF THEN ELSE ELSIF ENDIF
syn keyword pdlTest				contained	TEST CONDITION OTHERWISE ENDTEST
syn keyword pdlDo				contained	DO ENDDO
syn keyword pdlDoCondition		contained	FOR UNTIL WHILE

syn match pdlModuleName			contained	"[a-zA-Z-_]*"
syn match firstWord				"^\s*[^ ]*" contains=pdlConditional,pdlTest,pdlDo nextgroup=pdlDoCondition skipwhite
syn match pdlDescription		"^\S.\{-}:"

syn region pdlBegin	matchgroup=pdlBegin start="^\s*\(BEGIN\|LEAVE\|END\) " end=/$/ contains=pdlModuleName

syn match fileName				"\%^\S*"

hi def link pdlBegin			Statement
hi def link pdlBeginModule		Type
hi def link pdlModuleName		Identifier
hi def link pdlConditional		Conditional
hi def link pdlTest				Conditional
hi def link pdlDo				Repeat
hi def link pdlDoCondition		Repeat
hi def link pdlDescription		PreProc
hi def link fileName			Special

let b:current_syntax = "pdl"

