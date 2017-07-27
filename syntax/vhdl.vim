" Vim syntax file
" Language:     VHDL
" Maintainer:   Robert Morris <nonwonderdog@gmail.com>
" Credits:      Czo <Olivier.Sirol@lip6.fr>
"               Stephan Hegel <stephan.hegel@snc.siemens.com.cn>
" Last Change:  2014 Apr 16

" VHSIC Hardware Description Language
" Very High Scale Integrated Circuit

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if exists("b:current_syntax") || version < 600
  finish
endif

let b:current_syntax = "vhdl"

let s:cpo_save = &cpo
set cpo&vim

" case is not significant in VHDL
syn case ignore

" horrifically complicated syntax folding
syn region vhdlPackage
        \ start="\%(\<package\>\)\@<=.*\<is\>"
        \ end="\<end\%(\s\+\(entity\|architecture\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>"
        \ keepend fold transparent
syn keyword vhdlStatement   package

syn region vhdlEntity
        \ start="\%(\<entity\>\)\@<=.*\<is\>$"
        \ end="\<end\%(\s\+\(package\|architecture\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>"
        \ fold keepend transparent
syn keyword vhdlStatement   entity

syn region vhdlArchCont
        \ start="\%(\<architecture\>\)\@<=.*\<is\>$"
        \ end="\<end\%(\s\+\(package\|entity\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>"
        \ keepend transparent
        \ contains=vhdlArchitecture,vhdlBegin,vhdlArchOf
syn region vhdlArchitecture
        \ start="\<is\>"
        \ end="\<begin\>"me=s-1
        \ fold transparent contained
        \ contains=TOP
syn region vhdlBegin
        \ matchgroup=vhdlStatement
        \ start="\<begin\>"
        \ end="\<end\>"
        \ fold transparent contained
        \ contains=TOP
syn keyword vhdlArchOf      of
syn keyword vhdlStatement   architecture

syn region vhdlFunction
        \ start="\%(\<function\>\)\@<=.*\<is\>$"
        \ end="\<end\%(\s\+\(package\|entity\|architecture\|procedure\|process\|component\|record\|if\|case\)\)\@!\>"
        \ fold keepend extend transparent
syn keyword vhdlStatement   function

syn region vhdlProcedure
        \ start="\%(\<procedure\>\)\@<=.*\<is\>$"
        \ end="\<end\%(\s\+\(package\|entity\|architecture\|function\|process\|component\|record\|if\|case\)\)\@!\>"
        \ fold keepend extend transparent
syn keyword vhdlStatement   procedure

syn region vhdlProcess
        \ matchgroup=vhdlStatement
        \ start="\<process\>"
        \ end="\<end\s\+process\>"
        \ fold keepend extend transparent

syn region vhdlComponent
        \ matchgroup=vhdlStatement
        \ start="\<component\>"
        \ end="\<end\s\+component\>"
        \ fold keepend extend transparent
syn region vhdlRecord
        \ matchgroup=vhdlStatement
        \ start="\<record\>"
        \ end="\<end\s\+record\>"
        \ fold keepend extend transparent

" conditional statements
syn match   vhdlConditional  "\<then\>"
syn match   vhdlConditional  "\<else\>"
syn match   vhdlConditional  "\<end\s\+if\>"
syn match   vhdlConditional  "\<end\s\+case\>"
syn match   vhdlError        "\<else\s\+if\>"
syn keyword vhdlConditional  if case
syn keyword vhdlConditional  elsif when

" VHDL keywords
syn keyword vhdlStatement after all assert
syn keyword vhdlStatement attribute
syn keyword vhdlStatement begin block body buffer bus
syn keyword vhdlStatement configuration context
syn keyword vhdlStatement disconnect downto
syn keyword vhdlStatement end exit
syn keyword vhdlStatement file
syn keyword vhdlStatement generate generic group guarded
syn keyword vhdlStatement impure in inertial inout is
syn keyword vhdlStatement label library linkage literal
syn keyword vhdlStatement map
syn keyword vhdlStatement new next null
syn keyword vhdlStatement of on open others out
syn keyword vhdlStatement port postponed pure
syn keyword vhdlStatement register reject report return
syn keyword vhdlStatement select severity signal shared
syn keyword vhdlStatement to transport
syn keyword vhdlStatement unaffected until use
syn keyword vhdlStatement variable with

syn keyword vhdlType note warning error failure

syn keyword vhdlStorageClass access array constant range
syn keyword vhdlStatement alias subtype type units

syn keyword vhdlRepeat  while wait for loop

" Predefined VHDL types
syn keyword vhdlType bit bit_vector
syn keyword vhdlType character boolean integer real time
syn keyword vhdlType string severity_level
" Predefined standard ieee VHDL types
syn keyword vhdlType positive natural signed unsigned
syn keyword vhdlType line text
syn keyword vhdlType std_logic std_logic_vector
syn keyword vhdlType std_ulogic std_ulogic_vector
syn keyword vhdlFunction to_slv to_sulv to_unsigned to_signed
syn keyword vhdlFunction to_StdLogicVector to_Std_Logic_Vector
syn keyword vhdlFunction to_StdULogicVector to_Std_ULogic_Vector
syn keyword vhdlFunction to_01 to_x01 to_ux01 to_x01z is_x
syn keyword vhdlFunction resize std_match
syn keyword vhdlFunction shift_left shift_right rotate_left rotate_right
" IEEE math_real
syn keyword vhdlFloat MATH_E MATH_1_OVER_E
syn keyword vhdlFloat MATH_PI MATH_2_PI MATH_1_OVER_PI MATH_PI_OVER_2 MATH_PI_OVER_3 MATH_PI_OVER_4 MATH_3_PI_OVER_2
syn keyword vhdlFloat MATH_LOG_OF_2 MATH_LOG_OF_10 MATH_LOG2_OF_E MATH_LOG10_OF_E
syn keyword vhdlFloat MATH_SQRT_2 MATH_1_OVER_SQRT_PI
syn keyword vhdlFloat MATH_DEG_TO_RAD MATH_RAD_TO_DEG
syn keyword vhdlFunction sign ceil floor round trunc realmax realmin uniform sqrt cbrt exp log log2 log10
syn keyword vhdlFunction sin cos tan arcsin arccos arctan sinh cosh tanh arcsinh arccosh arctanh
" TEXtIO functions
syn keyword vhdlFunction readline writeline
syn keyword vhdlFunction read oread hread bread write owrite hwrite bwrite
syn keyword vhdlFunction BINARY_WRITE BINARY_READ OCTAL_READ OCTAL_WRITE HEX_READ HEX_WRITE
" VHDL 2008 fixed point types
syn keyword vhdlType ufixed sfixed
syn keyword vhdlType fixed_round_style_type fixed_overflow_style_type
syn keyword vhdlType unresolved_ufixed u_ufixed unresolved_sfixed u_sfixed
syn keyword vhdlFunction to_ufixed to_sfixed to_integer to_real
syn keyword vhdlFunction find_leftmost find_rightmost divide reciprocal remainder modulo add_carry scalb Is_Negative
syn keyword vhdlFunction ufixed_low ufixed_high sfixed_low sfixed_high saturate
syn keyword vhdlFunction to_ufix to_sfix UFix_high UFix_low SFix_low SFix_high
" VHDL 2008 floating point types
syn keyword vhdlType float unresolved_float u_float
syn keyword vhdlType float32 unresolved_float32 u_float_32
syn keyword vhdlType float64 unresolved_float64 u_float_64
syn keyword vhdlType float128 unresolved_float128 u_float_128
syn keyword vhdlType round_type
syn keyword vhdlFunction to_float
" VHDL 2008 additions
syn keyword vhdlStatement force release
syn keyword vhdlType boolean_vector integer_vector time_vector real_vector
syn keyword vhdlType unresolved_signed unresolved_unsigned u_signed u_unsigned
syn keyword vhdlFunction to_string to_bstring to_ostring to_hstring justify
syn keyword vhdlFunction TO_BINARY_STRING TO_OCTAL_STRING TO_HEX_STRING
syn keyword vhdlFunction from_string from_bstring from_ostring from_hstring
syn keyword vhdlFunction from_binary_string from_octal_string from_hex_string
syn keyword vhdlFunction swrite tee flush
syn keyword vhdlFunction find_leftmost find_rightmost
" Predefined non standard VHDL types for Mentor Graphics Sys1076/QuickHDL
syn keyword vhdlType qsim_state qsim_state_vector
syn keyword vhdlType qsim_12state qsim_12state_vector
syn keyword vhdlType qsim_strength
" Predefined non standard VHDL types for Alliance VLSI CAD
syn keyword vhdlType mux_bit mux_vector reg_bit reg_vector wor_bit wor_vector

" array attributes
syn match vhdlAttribute "\'high"
syn match vhdlAttribute "\'left"
syn match vhdlAttribute "\'length"
syn match vhdlAttribute "\'low"
syn match vhdlAttribute "\'range"
syn match vhdlAttribute "\'reverse_range"
syn match vhdlAttribute "\'right"
syn match vhdlAttribute "\'ascending"
" block attributes
syn match vhdlAttribute "\'behaviour"
syn match vhdlAttribute "\'structure"
syn match vhdlAttribute "\'simple_name"
syn match vhdlAttribute "\'instance_name"
syn match vhdlAttribute "\'path_name"
syn match vhdlAttribute "\'foreign"
" signal attribute
syn match vhdlAttribute "\'active"
syn match vhdlAttribute "\'delayed"
syn match vhdlAttribute "\'event"
syn match vhdlAttribute "\'last_active"
syn match vhdlAttribute "\'last_event"
syn match vhdlAttribute "\'last_value"
syn match vhdlAttribute "\'quiet"
syn match vhdlAttribute "\'stable"
syn match vhdlAttribute "\'transaction"
syn match vhdlAttribute "\'driving"
syn match vhdlAttribute "\'driving_value"
" type attributes
syn match vhdlAttribute "\'base"
syn match vhdlAttribute "\'high"
syn match vhdlAttribute "\'left"
syn match vhdlAttribute "\'leftof"
syn match vhdlAttribute "\'low"
syn match vhdlAttribute "\'pos"
syn match vhdlAttribute "\'pred"
syn match vhdlAttribute "\'rightof"
syn match vhdlAttribute "\'succ"
syn match vhdlAttribute "\'val"
syn match vhdlAttribute "\'image"
syn match vhdlAttribute "\'value"

syn keyword vhdlBoolean true false

" for std_logic values case is significant
syn case match
syn match vhdlVector "\'[0L1HXWZU\-\?]\'"
syn match vhdlVector "[0-9]*[SU]\=B\"[0L1HXWZU\-\?_]\+\""
syn match vhdlVector "[0-9]*[SU]\=O\"[0-7LHXWZU\-\?_]\+\""
syn match vhdlVector "[0-9]*[SU]\=X\"[0-9a-fLHXWZU\-\?_]\+\""
syn case ignore

syn region vhdlString start=+"+  end=+"+ contains=@Spell

" characters
syn match  vhdlCharacter "'.'"
syn keyword vhdlCharacter NUL SOH STX ETX EOT ENQ ACK BEL BS HT LF VT FF CR SO SI DLE
syn keyword vhdlCharacter DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM SUB ESC FSP GSP RSP USP
syn keyword vhdlCharacter DEL c128 c129 c130 c131 c132 c133 c134 c135 c136 c137 c139
syn keyword vhdlCharacter c140 c141 c142 c143 c144 c145 c146 c147 c148 c149 c150 c151
syn keyword vhdlCharacter c152 c153 c154 c155 c156 c157 c158 c159

" extended identifier
syn region vhdlLabel start="\\" end="\\"

" external identifier
syn region vhdlLabel start="<<" end=">>"

" illegal characters (@ and ^ are allowed in external names as of VHDL-2008)
syn match vhdlError "[$~!#%{}]"
syn match vhdlSpecial "[@\^]"
" integers
syn match vhdlNumber "-\=\<[0-9_]\+\>"
syn match vhdlNumber "-\=\<[0-9_]\+[eE][+]\=[0-9_]\+\>"
syn match vhdlNumber "0*2#[01_]\+#\%([eE][+]\=[0-9_]\+\)\="
syn match vhdlNumber "0*16#[0-9a-f_]\+#\%([eE][+]\=[0-9_]\+\)\="
" floating point
syn match vhdlFloat "-\=\<[0-9_]\+\.[0-9_]\+\>"
syn match vhdlFloat "-\=\<[0-9_]\+\.[0-9_]\+[eE][+-]\=[0-9_]\+\>"
syn match vhdlFloat "0*2#[01_]\+\.[01_]\+#\%([eE][+-]\=\d\+\)\="
syn match vhdlFloat "0*16#[0-9a-f_]\+\.[0-9a-f_]\+#\%([eE][+-]\=\d\+\)\="
" time
syn match vhdlNumber "\<\d\+\s\+\%(\%([fpnum]s\)\|\%(sec\)\|\%(min\)\|\%(hr\)\)\>"
syn match vhdlNumber "\<\d\+\.\d\+\s\+\%(\%([fpnum]s\)\|\%(sec\)\|\%(min\)\|\%(hr\)\)\>"
" operators
" no attempt here to separate signal assignment from less than or equal, both 
" represented by "<="
syn keyword vhdlFunction minimum maximum rising_edge falling_edge now
syn keyword vhdlOperator and nand or nor xor xnor
syn keyword vhdlOperator rol ror sla sll sra srl
syn keyword vhdlOperator mod rem abs not
syn match   vhdlOperator "[-+*/<>&]"
syn keyword vhdlOperator **
syn match   vhdlOperator "?\=[/<>]\=="
syn match   vhdlOperator "??"
syn keyword vhdlOperator =>
syn match   vhdlSpecial  "[\[\]:;().,]"
syn match   vhdlOperator ":="

" comments
syn keyword vhdlTodo    contained TODO FIXME XXX NOTE

syn region  vhdlComment
            \ oneline 
            \ contains=vhdlTodo,@Spell
            \ start="--"
            \ end="$"

" Define the default highlighting.
highlight def link vhdlLabel            Label
highlight def link vhdlSpecial          Special
highlight def link vhdlArchOf           Statement
highlight def link vhdlStatement        Statement
highlight def link vhdlStorageClass     StorageClass
highlight def link vhdlTypedef          Typedef
highlight def link vhdlConditional      Conditional
highlight def link vhdlRepeat           Repeat
highlight def link vhdlCharacter        Character
highlight def link vhdlString           String
highlight def link vhdlVector           String
highlight def link vhdlBoolean          Boolean
highlight def link vhdlComment          Comment
highlight def link vhdlSpecialComment   SpecialComment
highlight def link vhdlNumber           Number
highlight def link vhdlFloat            Float
highlight def link vhdlType             Type
highlight def link vhdlOperator         Operator
highlight def link vhdlFunction         Function
highlight def link vhdlError            Error
highlight def link vhdlAttribute        Type
highlight def link vhdlTodo             Todo

" We shouldn't need to look backwards to highlight, with the possible exception 
" of external identifiers.  And they don't work anyway...
syntax sync minlines=1 maxlines=1

let &cpo = s:cpo_save
unlet s:cpo_save
