" Vim syntax file
" Language:	VHDL
" Maintainer:	Robert Morris <nonwonderdog@gmail.com>
" Credits:	Czo <Olivier.Sirol@lip6.fr>
"		Stephan Hegel <stephan.hegel@snc.siemens.com.cn>
" Last Change:	2014 Apr 16

" VHSIC Hardware Description Language
" Very High Scale Integrated Circuit

" For version 5.x: Clear all syntax items
" For version 6.x: Quit when a syntax file was already loaded
if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

let s:cpo_save = &cpo
set cpo&vim

" case is not significant in VHDL
syn case ignore

" horrifically complicated syntax folding
syn region vhdlPackage	    start="\%(\<package\>\)\@<=.*\<is\>" end="\<end\%(\s\+\(entity\|architecture\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>" skip="--.*\n" keepend fold transparent
syn keyword vhdlStatement   package

syn region vhdlEntity	    start="\%(\<entity\>\)\@<=.*\<is\>$" end="\<end\%(\s\+\(package\|architecture\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>" skip="--.*\n" fold keepend transparent
syn keyword vhdlStatement   entity

syn region vhdlArchCont	    start="\%(\<architecture\>\)\@<=.*\<is\>$" end="\<end\%(\s\+\(package\|entity\|function\|procedure\|process\|component\|record\|if\|case\)\)\@!\>" skip="--.*\n" keepend transparent contains=vhdlArchitecture,vhdlBegin,vhdlArchOf
syn region vhdlArchitecture start="\<is\>" end="\<begin\>"me=s-1 skip="--.*\n" fold transparent contained contains=TOP
syn region vhdlBegin	    matchgroup=vhdlStatement start="\<begin\>" end="\<end\>" skip="--.*\n" fold transparent contained contains=TOP
syn keyword vhdlArchOf	    of
syn keyword vhdlStatement   architecture

syn region vhdlFunction	    start="\%(\<function\>\)\@<=.*\<is\>$" end="\<end\%(\s\+\(package\|entity\|architecture\|procedure\|process\|component\|record\|if\|case\)\)\@!\>" skip="--.*\n" fold keepend extend transparent
syn keyword vhdlStatement   function

syn region vhdlProcedure    start="\%(\<procedure\>\)\@<=.*\<is\>$" end="\<end\%(\s\+\(package\|entity\|architecture\|function\|process\|component\|record\|if\|case\)\)\@!\>" skip="--.*\n" fold keepend extend transparent
syn keyword vhdlStatement   procedure

syn region vhdlProcess	    matchgroup=vhdlStatement start="\<process\>" end="\<end\s\+process\>" skip="--.*\n" fold keepend extend transparent

syn region vhdlComponent    matchgroup=vhdlStatement start="\<component\>" end="\<end\s\+component\>" skip="--.*\n" fold keepend extend transparent
syn region vhdlRecord	    matchgroup=vhdlStatement start="\<record\>" end="\<end\s\+record\>" skip="--.*\n" fold keepend extend transparent

" conditional statements
syn region  vhdlIf	    matchgroup=vhdlConditional	start="\<if\>" end="\<end\s\+if\>" skip="--.*\n" fold keepend extend transparent contains=TOP
syn match   vhdlConditional "\<else\>"
syn match   vhdlError	    "\<else\s\+if\>"
syn keyword vhdlConditional then elsif

syn region  vhdlCase	    matchgroup=vhdlConditional	start="\<case\>" end="\<end\s\+case\>" skip="--.*\n" fold keepend extend transparent contains=TOP
syn keyword vhdlConditional when

" VHDL keywords
syn keyword vhdlStatement after all assert
syn keyword vhdlStatement attribute
syn keyword vhdlStatement begin block body buffer bus
syn keyword vhdlStatement configuration
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

syn keyword vhdlStorageClass access alias array constant range
syn keyword vhdlStatement subtype type units

syn keyword vhdlRepeat	while wait for loop

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
syn keyword vhdlFunction to_01 to_x01 to_ux01 to_x01z is_x
syn keyword vhdlFunction resize std_match
syn keyword vhdlFunction shift_left shift_right rotate_left rotate_right
" IEEE math_real
syn keyword vhdlNumber MATH_E MATH_1_OVER_E
syn keyword vhdlNumber MATH_PI MATH_2_PI MATH_1_OVER_PI MATH_PI_OVER_2 MATH_PI_OVER_3 MATH_PI_OVER_4 MATH_3_PI_OVER_2
syn keyword vhdlNumber MATH_LOG_OF_2 MATH_LOG_OF_10 MATH_LOG2_OF_E MATH_LOG10_OF_E
syn keyword vhdlNumber MATH_SQRT_2 MATH_1_OVER_SQRT_PI
syn keyword vhdlNumber MATH_DEG_TO_RAD MATH_RAD_TO_DEG
syn keyword vhdlFunction sign ceil floor round trunc realmax realmin uniform sqrt cbrt exp log log2 log10
syn keyword vhdlFunction sin cos tan arcsin arccos arctan sinh cosh tanh arcsinh arccosh arctanh
" TEXtIO functions
syn keyword vhdlFunction readline writeline
syn keyword vhdlFunction read oread hread bread write owrite hwrite bwrite
" VHDL 2008 fixed point types
syn keyword vhdlType ufixed sfixed
syn keyword vhdlType fixed_round_style_type fixed_overflow_style_type
syn keyword vhdlType unresolved_ufixed u_ufixed unresolved_sfixed u_sfixed
syn keyword vhdlFunction to_ufixed to_sfixed to_integer to_real
syn keyword vhdlFunction find_leftmost find_rightmost divide reciprocal add_carry scalb
syn keyword vhdlFunction ufixed_low ufixed_high sfixed_low sfixed_high
syn keyword vhdlFunction to_ufix to_sfix ufix_high ufix_low sfixed_low sfixed_high
" VHDL 2008 floating point types
syn keyword vhdlType float unresolved_float u_float
syn keyword vhdlType float32 unresolved_float32 u_float_32
syn keyword vhdlType float64 unresolved_float64 u_float_64
syn keyword vhdlType float128 unresolved_float128 u_float_128
syn keyword vhdlType round_type
syn keyword vhdlFunction to_float
" VHDL 2008 additions
syn keyword vhdlStatement force release
syn match   vhdlSpecial "[@\^]"
syn keyword vhdlType boolean_vector integer_vector real_vector time_vector
syn keyword vhdlType unresolved_signed unresolved_unsigned u_signed u_unsigned
syn keyword vhdlFunction to_string to_ostring to_hstring justify
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

" for this vector values case is significant
syn case match
" Values for standard VHDL types
syn match vhdlVector "\'[0L1HXWZU\-\?]\'"
" Values for non standard VHDL types qsim_12state for Mentor Graphics Sys1076/QuickHDL
syn keyword vhdlVector S0S S1S SXS S0R S1R SXR S0Z S1Z SXZ S0I S1I SXI
syn case ignore

" logic vectors
syn match  vhdlVector "B\"[01_]\+\""
syn match  vhdlVector "O\"[0-7_]\+\""
syn match  vhdlVector "X\"[0-9a-f_]\+\""
syn region vhdlString start=+"+  end=+"+ contains=@Spell

" characters
syn match  vhdlCharacter "'.'"
syn keyword vhdlCharacter NUL SOH STX ETX EOT ENQ ACK BEL BS HT LF VT FF CR SO SI DLE
syn keyword vhdlCharacter DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM SUB ESC FSP GSP RSP USP
syn keyword vhdlCharacter DEL c128 c129 c130 c131 c132 c133 c134 c135 c136 c137 c139
syn keyword vhdlCharacter c140 c141 c142 c143 c144 c145 c146 c147 c148 c149 c150 c151
syn keyword vhdlCharacter c152 c153 c154 c155 c156 c157 c158 c159

" illegal characters (@ and ^ are allowed in external names as of VHDL-2008)
syn match vhdlError "[$~!#%\[\]{}]"
" integers
syn match vhdlNumber "-\=\<[0-9_]\+\>"
syn match vhdlNumber "-\=\<[0-9_]\+[eE][+]\=[0-9_]\+\>"
syn match vhdlNumber "0*2#[01_]\+#\%([eE][+]\=[0-9_]\+\)\="
syn match vhdlNumber "0*16#[0-9a-f_]\+#\%([eE][+]\=[0-9_]\+\)\="
" floating point
syn match vhdlFloat "-\=\<[0-9_]\+\.[0-9_]\+\>"
syn match vhdlFloat "-\=\<[0-9_]\+\.[0-9_]\+[eE]-\=[0-9_]\+\>"
syn match vhdlFloat "0*2#[01_]\+\.[01_]\+#\%([eE][+-]\=\d\+\)\="
syn match vhdlFloat "0*16#[0-9a-f_]\+\.[0-9a-f_]\+#\%([eE][+-]\=\d\+\)\="
" time
syn match vhdlNumber "\<\d\+\s\+\%(\%([fpnum]s\)\|\%(sec\)\|\%(min\)\|\%(hr\)\)\>"
syn match vhdlNumber "\<\d\+\.\d\+\s\+\%(\%([fpnum]s\)\|\%(sec\)\|\%(min\)\|\%(hr\)\)\>"
" operators
syn keyword vhdlFunction minimum maximum rising_edge falling_edge now
syn keyword vhdlOperator and nand or nor xor xnor
syn keyword vhdlOperator rol ror sla sll sra srl
syn keyword vhdlOperator mod rem abs not
syn match   vhdlOperator "[-+*/<>&]"
syn keyword vhdlOperator **
syn match   vhdlOperator "?\=[/<>]\=="
syn match   vhdlOperator "??"
syn keyword vhdlOperator =>
syn match   vhdlSpecial  "[:;.,]"
syn match   vhdlOperator ":="
syn region  parens	matchgroup=vhdlSpecial	start="(" end=")" fold transparent
" extended identifier
syn match   vhdlSpecial	"\\.\{-}\\"

" comments
"syn include @doxygen syntax/doxygen.vim
"syn include @plantuml syntax/plantuml.vim
syn match   vhdlComment "--.*$" contains=@Spell,vhdlTodo
syn keyword vhdlTodo	contained TODO FIXME XXX

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_vhdl_syntax_inits")
  if version < 508
    let did_vhdl_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink vhdlLabel	    Label
  HiLink vhdlSpecial	    Special
  HiLink vhdlArchOf	    Statement
  HiLink vhdlStatement	    Statement
  HiLink vhdlStorageClass   StorageClass
  HiLink vhdlTypedef	    Typedef
  HiLink vhdlConditional    Conditional
  HiLink vhdlRepeat	    Repeat
  HiLink vhdlCharacter	    Character
  HiLink vhdlString	    String
  HiLink vhdlVector	    String
  HiLink vhdlBoolean	    Boolean
  HiLink vhdlComment	    Comment
  HiLink vhdlSpecialComment SpecialComment
  HiLink vhdlNumber	    Number
  HiLink vhdlFloat	    Float
  HiLink vhdlType	    Type
  HiLink vhdlOperator	    Operator
  HiLink vhdlFunction	    Function
  HiLink vhdlError	    Error
  HiLink vhdlAttribute	    Type
  HiLink vhdlTodo	    Todo

  delcommand HiLink
endif

let b:current_syntax = "vhdl"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim: ts=8
