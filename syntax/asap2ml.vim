" Vim syntax file
" Language:    ASAM MCD-2 Markup Language
" Maintainer:  Robert Morris <robert.morris@roush.com>
" Last Change: 2018-05-23
" Filenames:   *.aml
" Version:     0.00

" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Characters allowed in keywords
setlocal iskeyword=a-z,A-Z,48-57,_

syn region asap2ml matchgroup=asap2mlKeyword start="/begin\s\+asap2ml\>" end="/end\s\+asap2ml\>" fold transparent

syn region asap2mlInclude display contained start=+"+ end=+"+
syn match  asap2mlInclude "[-./[:alnum:]_~]\+" display contained
syn match  asap2mlKeyword display "^\s*/include" nextgroup=asap2mlInclude skipwhite

syn keyword asap2mlKeyword   block if_data
syn keyword asap2mlType      char int long int64 uchar uint uint64 ulong
syn keyword asap2mlType      double float
syn keyword asap2mlStructure enum struct taggedstruct taggedunion tag

syn region  asap2mlBlock     matchgroup=asap2mlSpecial start="{" end="}" fold transparent
syn match   asap2mlSpecial   display "[][()*;]"

syn match   asap2mlOperator  display "[=,]"

syn match   asap2mlNumber  display "[-+]\=\d\+\>"
syn match   asap2mlNumber  display "[-+]\=0x[0-9A-F]\+\>"
syn match   asap2mlFloat   display "[-+]\=\d\+\.\d*\(E[-+]\=\d\+\)\="
syn match   asap2mlFloat   display "[-+]\=\.\d\+\(E[-+]\=\d\+\)\=\>"
syn match   asap2mlFloat   display "[-+]\=\d\+E[-+]\=\d\+\>"

syn match   asap2mlSpecial display "\\\('\|\"\|\\\|n\|r\|t\)"
syn match   asap2mlSpecial display "\"\""
syn region  asap2mlString matchgroup=asap2mlString start=+"+ skip=+""+ end=+"+ contains=asap2mlSpecial

syn keyword asap2mlTodo contained TODO FIXME XXX
syn region  asap2mlComment start="//" end="$" keepend contains=@Spell,asap2mlTodo
syn region  asap2mlComment start="/\*" end="\*/" contains=@Spell,asap2mlTodo fold extend

" Default style links
hi def link asap2mlComment         Comment
hi def link asap2mlFloat           Float
hi def link asap2mlKeyword         Keyword
hi def link asap2mlInclude         Include
hi def link asap2mlNumber          Number
hi def link asap2mlSpecial         Special
hi def link asap2mlString          String
hi def link asap2mlStructure       Structure
hi def link asap2mlType            Type
hi def link asap2mlOperator        Operator
hi def link asap2mlTodo            Todo

syntax sync fromstart

let b:current_syntax = "asap2ml"

let &cpo = s:cpo_save
unlet s:cpo_save
