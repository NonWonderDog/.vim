" Vim syntax file
" Language:    ASAM MCD-2 MC
" Maintainer:  Robert Morris <robert.morris@roush.com>
" Last Change: 2018-05-24
" Filenames:   *.a2l
" Version:     0.00

" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Characters allowed in keywords
setlocal iskeyword=a-z,A-Z,48-57,_

" Control Words
syn region asap2Section matchgroup=asap2Keyword start="/begin" end="/end" fold transparent

" Keywords
syn keyword asap2Function A2ML A2ML_VERSION
syn keyword asap2Function ADDR_EPK ADDRESS_TYPE
syn keyword asap2Function ALIGNMENT_BYTE ALIGNMENT_FLOAT16_IEEE
syn keyword asap2Function ALIGNMENT_FLOAT32_IEEE ALIGNMENT_FLOAT64_IEEE
syn keyword asap2Function ALIGNMENT_INT64 ALIGNMENT_LONG ALIGNMENT_WORD
syn keyword asap2Function ANNOTATION ANNOTATION_LABEL ANNOTATION_ORIGIN
syn keyword asap2Function ANNOTATION_TEXT
syn keyword asap2Function ARRAY_SIZE AR_COMPONENT AR_PROTOTYPE_OF
syn keyword asap2Function ASAP2_VERSION
syn keyword asap2Function AXIS_DESCR AXIS_PTS AXIS_PTS_REF
syn keyword asap2Function AXIS_PTS_X AXIS_PTS_Y AXIS_PTS_Z AXIS_PTS_4 AXIS_PTS_5
syn keyword asap2Function AXIS_RESCALE_X

syn keyword asap2Function BIT_MASK BIT_OPERATION
syn keyword asap2Function BLOB
syn keyword asap2Function BYTE_ORDER

syn keyword asap2Function CALIBRATION_ACCESS
syn keyword asap2Function CALIBRATION_HANDLE CALIBRATION_HANDLE_TEXT
syn keyword asap2Function CALIBRATION_METHOD
syn keyword asap2Function CHARACTERISTIC COEFFS COEFFS_LINEAR
syn keyword asap2Function CHARACTERISTIC COEFFS COEFFS_LINEAR
syn keyword asap2Function COMPARISON_QUANTITY
syn keyword asap2Function COMPU_METHOD COMPU_TAB COMPU_TAB_REF
syn keyword asap2Function COMPU_VTAB COMPU_VTAB_RANGE
syn keyword asap2Function CONSISTENT_EXCHANGE CONVERSION CPU_TYPE
syn keyword asap2Function CURVE_AXIS_REF CUSTOMER CUSTOMER_NO

syn keyword asap2Function DATA_SIZE DEF_CHARACTERISTIC
syn keyword asap2Function DEFAULT_VALUE DEFAULT_VALUE_NUMERIC
syn keyword asap2Function DEPENDENT_CHARACTERISTIC DEPOSIT DISCRETE
syn keyword asap2Function DISPLAY_IDENTIFIER
syn keyword asap2Function DIST_OP_X DIST_OP_Y DIST_OP_Z DIST_OP_4 DIST_OP_5

syn keyword asap2Function ECU ECU_ADDRESS ECU_ADDRESS_EXTENSION
syn keyword asap2Function ECU_CALIBRATION_OFFSET ENCODING EPK ERROR_MASK
syn keyword asap2Function EXTENDED_LIMITS

syn keyword asap2Function FIX_AXIS_PAR FIX_AXIS_PAR_DIST FIX_AXIS_PAR_LIST
syn keyword asap2Function FIX_NO_AXIS_PTS_X FIX_NO_AXIS_PTS_Y
syn keyword asap2Function FIX_NO_AXIS_PTS_Z FIX_NO_AXIS_PTS_4
syn keyword asap2Function FIX_NO_AXIS_PTS_5 FNC_VALUES FORMAT
syn keyword asap2Function FORMULA FORMULA_INV FRAME FRAME_MEASUREMENT
syn keyword asap2Function FUNCTION FUNCTION_LIST FUNCTION_VERSION

syn keyword asap2Function GROUP GUARD_RAILS

syn keyword asap2Function HEADER

syn keyword asap2Function IDENTIFICATION IN_DATA IN_MEASUREMENT
syn keyword asap2Function INPUT_QUANTITY INSTANCE

syn keyword asap2Function LAYOUT LEFT_SHFIT LIMITS LOC_MEASUREMENT

syn keyword asap2Function MAP_LIST MATRIX_DIM MAX_GRAD MAX_REFRESH
syn keyword asap2Function MEASUREMENT MEMORY_LAYOUT MEMORY_SEGMENT
syn keyword asap2Function MOD_COMMON MOD_PAR MODEL_LINK MODULE MONOTONY

syn keyword asap2Function NO_AXIS_PTS_X NO_AXIS_PTS_Y NO_AXIS_PTS_Z
syn keyword asap2Function NO_AXIS_PTS_4 NO_AXIS_PTS_5 NO_OF_INTERFACES
syn keyword asap2Function NO_RESCALE_X NUMBER

syn keyword asap2Function OFFSET_X OFFSET_Y OFFSET_Z OFFSET_4 OFFSET_5
syn keyword asap2Function OUT_MEASUREMENT OVERWRITE

syn keyword asap2Function PHONE_NO PHYS_UNIT PROJECT PROJECT_NO

syn keyword asap2Function READ_ONLY READ_WRITE RECORD_LAYOUT
syn keyword asap2Function REF_CHARACTERISTIC REF_GROUP REF_MEASUREMENT
syn keyword asap2Deprecated REF_MEMORY_SEGMENT
syn keyword asap2Function REF_UNIT RESERVED RIGHT_SHIFT
syn keyword asap2Function RIP_ADDR_W RIP_ADDR_X RIP_ADDR_Y RIP_ADDR_Z
syn keyword asap2Function RIP_ADDR_4 RIP_ADDR_5 ROOT

syn keyword asap2Function SHIFT_OP_X SHIFT_OP_Y SHIFT_OP_Z SHIFT_OP_4
syn keyword asap2Function SHIFT_OP_5 SIGN_EXTEND SI_EXPONENTS
syn keyword asap2Function SRC_ADDR_X SRC_ADDR_Y SRC_ADDR_Z SRC_ADDR_4
syn keyword asap2Function SRC_ADDR_5
syn keyword asap2Function STATIC_ADDRESS_OFFSET STATIC_RECORD_LAYOUT
syn keyword asap2Function STATUS_STRING_REF STEP_SIZE STRUCTURE_COMPONENT
syn keyword asap2Function SUB_FUNCTION SUB_GROUP SUPPLIER
syn keyword asap2Function SYMBOL_LINK SYMBOL_TYPE_LINK SYSTEM_CONSTANT

syn keyword asap2Function TRANSFORMER
syn keyword asap2Function TRANSFORMER_IN_OBJECTS TRANSFORMER_OUT_OBJECTS
syn keyword asap2Function TYPEDEF_AXIS TYPEDEF_BLOB TYPEDEF_CHARACTERISTIC
syn keyword asap2Function TYPEDEF_MEASUREMENT TYPEDEF_STRUCTURE

syn keyword asap2Function UNIT UNIT_CONVERSION USER USER_RIGHTS

syn keyword asap2Function VAR_ADDRESS VAR_CHARACTERISTIC VAR_CRITERION
syn keyword asap2Function VAR_FORBIDDEN_COMB VAR_MEASUREMENT VAR_NAMING
syn keyword asap2Function VAR_SELECTION_CHARACTERISTIC VAR_SEPARATOR
syn keyword asap2Function VARIANT_CODING VERSION
syn keyword asap2Function VIRTUAL VIRTUAL_CHARACTERISTIC

" Strings
syn match asap2Special display contained "\\\('\|\"\|\\\|n\|r\|t\)"
syn match asap2Special display contained "\"\""
syn region asap2String matchgroup=asap2String start=+"+ skip=+""+ end=+"+ contains=asap2Special

" Numbers
syn match asap2Number  display "[-+]\=\<\d\+\>"
syn match asap2Number  display "[-+]\=\<0x[0-9A-F]\+\>"
syn match asap2Float   display "[-+]\=\<\d\+\.\d*\(E[-+]\=\d\+\)\="
syn match asap2Float   display "[-+]\=\<\.\d\+\(E[-+]\=\d\+\)\=\>"
syn match asap2Float   display "[-+]\=\<\d\+E[-+]\=\d\+\>"

" datatype
syn keyword asap2Type UBYTE SBYTE UWORD SWORD ULONG SLONG A_UINT64 A_INT64
syn keyword asap2Type FLOAT16_IEEE FLOAT32_IEEE FLOAT64_IEEE

" datasize
syn keyword asap2Size BYTE WORD LONG

" addrtype
syn keyword asap2AType PBYTE PWORD PLONG PLONGLONG DIRECT

" byteorder
syn keyword asap2BOrder LITTLE_ENDIAN BIG_ENDIAN MSB_LAST MSB_FIRST
syn keyword asap2BOrder MSB_FIRST_MSW_LAST MSB_LAST_MSW_FIRST

" indexorder
syn keyword asap2IOrder INDEX_INCR INDEX_DECR

" Includes
syn region asap2Include display contained start=+"+ end=+"+
syn match  asap2Include "[-./[:alnum:]_~]\+" display contained
syn match  asap2Keyword display "^\s*/include" nextgroup=asap2Include skipwhite

" Comments
syn keyword asap2Todo contained TODO FIXME XXX
syn region asap2Comment start="//" end="$" keepend contains=@Spell,asap2Todo
syn region asap2Comment start="/\*" end="\*/" contains=@Spell,asap2Todo fold extend

" A2ML
syn include @a2ml syntax/asap2ml.vim
syn region a2ml matchgroup=asap2Keyword start="/begin\s\+A2ML\>" end="/end\s\+A2ML\>" contains=@a2ml fold transparent

" Default style links
hi def link asap2AType          asap2Type
hi def link asap2BOrder         StorageClass
hi def link asap2Comment        Comment
hi def link asap2Define         Define
hi def link asap2Float          Float
hi def link asap2Function       Function
hi def link asap2IOrder         StorageClass
hi def link asap2Include        Include
hi def link asap2Integer        Number
hi def link asap2Keyword        Keyword
hi def link asap2Number         Number
hi def link asap2Operator       Operator
hi def link asap2Size           asap2Type
hi def link asap2Special        Special
hi def link asap2String         String
hi def link asap2Todo           Todo
hi def link asap2Type           Type

syn sync fromstart

let b:current_syntax = "asap2"

let &cpo = s:cpo_save
unlet s:cpo_save
