" Vim syntax file
" Language:     IEC 61131-1 Structured Text as implemented by CoDeSys/TwinCAT
" Version:      1.0
" Last Change:  2013/02/15
" Maintainer:   Robert Morris
" TODO: match WITH, TO, ON, etc keywords only on first line of appropriate
" definition

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

syn case match
syn sync lines=250

" clusters to define file sections
syn cluster toplevel            contains=iecProgramDef,iecFunctionDef,iecFBlockDef,iecAction,iecConfig,iecRecource,iecStep,iecStruct,iecTypeDef
"code contains all but toplevel
syn cluster code                contains=TOP,@toplevel
syn cluster definitions         contains=TOP,@toplevel,iecIf,iecCase,iecWhile,iecFor,iecRepeatBlk,iecVarDef

" top level definitions
syn region      iecProgramDef   matchgroup=iecStatement         start="\<PROGRAM\>" end="\<END_PROGRAM\>" transparent contains=@code,iecAction,iecStep,iecTransition
syn region      iecFunctionDef  matchgroup=iecStatement         start="\<FUNCTION\>" end="\<END_FUNCTION\>" transparent contains=@code,iecAction,iecStep,iecTransition
syn region      iecFBlockDef    matchgroup=iecStatement         start="\<FUNCTION_BLOCK\>" end="\<END_FUNCTION_BLOCK\>" transparent contains=@code,iecAction,iecStep,iecTransition
syn keyword     iecStatement    RETURN                          contained containedin=iecProgramDef,iecFunctionDef,iecFBlockDef

syn region      iecConfig       matchgroup=iecStatement         start="\<CONFIGURATION\>" end="\<END_CONFIGURATION\>" transparent contains=@definitions,iecVarDef
syn region      iecResource     matchgroup=iecStatement         start="\<RESOURCE\>" end="\<END_RESOURCE\>" transparent contains=@definitions,iecVarDef
syn keyword     iecStatement    TASK PROGRAM WITH               contained containedin=iecConfig
syn keyword iecStatement        ON                              contained containedin=iecResource

syn region      iecAction       matchgroup=iecStatement         start="\<ACTION\>" end="\<END_ACTION\>" fold transparent contains=@code
syn region      iecStep         matchgroup=iecStatement         start="\<STEP\>" end="\<END_STEP\>" fold transparent contains=@code
syn region      iecStep         matchgroup=iecStatement         start="\<INITIAL_STEP\>" end="\<END_STEP\>" fold transparent contains=@code
syn region      iecTransition   matchgroup=iecStatement         start="\<TRANSITION\>" end="\<END_TRANSITION\>" fold transparent contains=@code
syn keyword iecStatement        FROM TO                         contained containedin=iecTransition

syn region      iecTypeDef      matchgroup=iecStructure         start="\<TYPE\>" end="\<END_TYPE\>" transparent contains=@definitions,iecStruct
syn region      iecStruct       matchgroup=iecStructure         start="\<STRUCT\>" end="\<END_STRUCT\>" transparent contained contains=@definitions

" variable defintions
syn region      iecVarDef       matchgroup=iecStatement         start="\<\%(VAR_INPUT\|VAR_OUTPUT\|VAR_IN_OUT\|VAR_TEMP\|VAR_EXTERNAL\|VAR_ACCESS\|VAR_CONFIG\|VAR_GLOBAL\|VAR\)\>" end="\<END_VAR\>" fold transparent contains=@definitions

" fold regions
syn region      iecIf           matchgroup=iecConditional       start="\<IF\>" end="\<END_IF\>" fold transparent contains=@code
syn region      iecCase         matchgroup=iecConditional       start="\<CASE\>" end="\<END_CASE\>" fold transparent contains=@code
syn keyword     iecConditional  THEN ELSIF ELSE                 contained containedin=iecIf
syn keyword     iecConditional  OF ELSE                         contained containedin=iecCase

syn region      iecWhile        matchgroup=iecRepeat            start="\<WHILE\>" end="\<END_WHILE\>" fold transparent contains=@code
syn region      iecRepeatBlk    matchgroup=iecRepeat            start="\<REPEAT\>" end="\<END_REPEAT\>" fold transparent contains=@code
syn region      iecFor          matchgroup=iecRepeat            start="\<FOR\>" end="\<END_FOR\>" fold transparent contains=@code
syn keyword     iecRepeat       DO                              contained containedin=iecWhile
syn keyword     iecRepeat       UNTIL                           contained containedin=iecRepeatBlk
syn keyword     iecRepeat       TO BY DO                        contained containedin=iecFor

" Data Types
syn keyword     iecStatement    F_EDGE R_EDGE
syn keyword     iecStorageClass CONSTANT RETAIN NON_RETAIN
syn keyword     iecType         ARRAY OF AT
syn keyword     iecType         BOOL SINT INT DINT LINT USINT UINT UDINT ULINT REAL LREAL BYTE WORD DWORD LWORD STRING WSTRING
syn match       iecType         "\<TIME\>"
syn match       iecType         "\<DATE\>"
syn match       iecType         "\<TOD\>"
syn match       iecType         "\<TIME_OF_DAY\>"
syn match       iecType         "\<DT\>"
syn match       iecType         "\<DATE_AND_TIME\>"

" Built-in Functions
syn keyword     iecFunction     ABS SQRT
syn keyword     iecFunction     LN LOG EXP EXPT
syn keyword     iecFunction     SIN COS TAN ASIN ACOS ATAN
syn keyword     iecFunction     ADD MUL SUB DIV EXPT MOVE
syn keyword     iecFunction     SHL SHR ROR ROL
syn keyword     iecFunction     AND OR XOR NOT
syn keyword     iecFunction     SEL MAX MIN LIMIT MUX
syn keyword     iecFunction     GT GE EQ LE LT NE
syn keyword     iecFunction     LEN LEFT RIGHT MID CONCAT INSERT DELETE REPLACE FIND
syn keyword     iecFunction     ADD_TIME ADD_TOD_TIME ADD_DT_TIME SUB_TIME SUB_DATE_TIME SUB_TOD_TIME SUB_DT_TIME SUB_DT_DT MUL MULTIME DIVTIME CONCAT_DATE_TOD
syn keyword     iecFunction     DT_TO_TOD DT_TO_DATE
syn keyword     iecFunction     INDEXOF SIZEOF ADR
syn keyword     iecFunction     TRUNC
"no built-in LINT, ULINT, or WSTRING conversion functions
syn match       iecFunction     "BOOL_TO_\(SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "SINT_TO_\(BOOL\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "INT_TO_\(BOOL\|SINT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "DINT_TO_\(BOOL\|SINT\|INT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "USINT_TO_\(BOOL\|SINT\|INT\|DINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "UINT_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "UDINT_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "REAL_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "LREAL_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "BYTE_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "WORD_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|DWORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "DWORD_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|TIME\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "TIME_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TOD\|DATE\|DT\|STRING\)"
syn match       iecFunction     "TOD_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|DATE\|DT\|STRING\)"
syn match       iecFunction     "DATE_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DT\|STRING\)"
syn match       iecFunction     "DT_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|STRING\)"
syn match       iecFunction     "STRING_TO_\(BOOL\|SINT\|INT\|DINT\|USINT\|UINT\|UDINT\|REAL\|LREAL\|BYTE\|WORD\|DWORD\|TIME\|TOD\|DATE\|DT\)"

syn keyword     iecFunctionBlock        SR RS SEMA
syn keyword     iecFunctionBlock        R_TRIG F_TRIG
syn keyword     iecFunctionBlock        CTU CTU_DINT CTU_LINT CTU_UDINT CTU_ULINT
syn keyword     iecFunctionBlock        CTD CTD_DINT CTD_LINT CTD_UDINT CTD_ULINT
syn keyword     iecFunctionBlock        CTUD CTUD_DINT CTUD_LINT CTUD_UDINT CTUD_ULINT
syn keyword     iecFunctionBlock        TP TON TOF

" Strings
syn region      iecString               matchgroup=iecString start=+'+ skip=+$'+ end=+'+ contains=iecStringEscape oneline
syn region      iecString               matchgroup=iecString start=+"+ end=+"+ contains=iecStringEscapeWide oneline
syn match       iecStringEscape "$[A-Z$'"]"
syn match       iecStringEscape "$\x\{2}"
syn match       iecStringEscapeWide     "$[A-Z$'"]"
syn match       iecStringEscapeWide     "$\x\{4}"

" Operators
syn match       iecOperator     "[+\-/*=]"
syn match       iecOperator     "[<>]=\="
syn match       iecOperator     "<>"
syn match       iecOperator     ":"
syn match       iecOperator     ":="
syn match       iecOperator     "[()]"
syn match       iecOperator     "\.\."
syn match       iecOperator     "[\^.]"
syn match       iecDelimiter    "[][]"
syn keyword     iecOperator     MOD

" Constants
syn match       iecNumber       "-\=\<[0-9_]\+\>"
syn match       iecFloat        "-\=\<[0-9_]\+\.[0-9_]\+\>"
syn match       iecFloat        "-\=\<[0-9_]\+\.[0-9_]\+[eE]-\=[0-9_]\+\>"
syn match       iecNumber       "\<2#[01_]\+\>"
syn match       iecNumber       "\<8#[0-7_]\+\>"
syn match       iecNumber       "\<16#[0-9A-Fa-f_]\+\>"
syn match       iecFloat        "\<\(TIME\|T\)#-\=[0-9_]\+\.[0-9_]\+\(ms\|s\|m\|h\|d\)"
syn match       iecFloat        "\<\(TIME\|T\)#-\=\([0-9_]\+d\)\=\([0-9_]\+h\)\=\([0-9_]\+m\)\=\([0-9_]\+s\)\=\([0-9_]\+ms\)\=\>"
syn match       iecFloat        "\<\(DATE\|D\)#\d\{4}-\d\{2}-\d\{2}\>"
syn match       iecFloat        "\<\(TIME_OF_DAY\|TOD\)#\(\d\|0\d\|1\d\|2[0-3]\):[0-5]\d:[0-5]\d\(\.\d\{2}\)\=\>"
syn match       iecFloat        "\<\(DATE_AND_TIME\|DT\)#\d\{4}-\d\{2}-\d\{2}-\(\d\|0\d\|1\d\|2[0-3]\):[0-5]\d:[0-5]\d\(.\d\{2}\)\=\>"
syn keyword     iecBoolean      TRUE FALSE

" Comments
syn region      iecComment          matchgroup=iecComment start="(\*"  end="\*)" contains=@Spell,iecCommentError,iecTodo
syn match       iecCommentError     contained       "(\*"
syn keyword     iecTodo             contained       TODO FIXME XXX

" Pragmas
syn region      iecPragma       start="{" end="}"

" Define the default highlighting.
" Only used when an item doesn't have highlighting yet
hi def link iecBoolean          Boolean
hi def link iecComment          Comment
hi def link iecCommentError     Error
hi def link iecConditional      Conditional
hi def link iecConstant         Constant
hi def link iecDelimiter        Identifier
hi def link iecException        Exception
hi def link iecFloat            Float
hi def link iecFunction         Function
hi def link iecFunctionBlock    Function
hi def link iecLabel            Label
hi def link iecModifier         Type
hi def link iecNumber           Number
hi def link iecOperator         Operator
hi def link iecPragma           PreProc
hi def link iecRepeat           Repeat
hi def link iecStatement        Statement
hi def link iecStorageClass     StorageClass
hi def link iecString           String
hi def link iecStringError      Error
hi def link iecStringEscape     Special
hi def link iecStringEscapeWide Special
hi def link iecStructure        Structure
hi def link iecTodo             Todo
hi def link iecType             Type
hi def link iecError            Error

let b:current_syntax = "iec"

