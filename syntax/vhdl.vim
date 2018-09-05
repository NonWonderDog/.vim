" Vim syntax file
" Language:     VHDL
" Maintainer:   Robert Morris <nonwonderdog@gmail.com>
" Todo:         Don't fold between `:` and `;` in i/o lists.
"               Define syntax clusters for combinatorial, sequential, etc.
"               Don't fold labelled processes, etc. twice
" VHSIC (Very High Scale Integrated Circuit) Hardware Description Language

if exists("b:current_syntax") || version < 600
  finish
endif

let b:current_syntax = "vhdl"

let s:cpo_save = &cpo
set cpo&vim

" case is not significant in VHDL
syn case ignore

syn cluster vhdlNormal contains=vhdlComment,vhdlSpecial,vhdlStorageClass,vhdlStatement,vhdlFunction,vhdlOperator,vhdlNumber,vhdlFloat,vhdlLogic,vhdlBoolean,vhdlString,vhdlCharacter,vhdlAttribute,vhdlType

" Entity regions begin with "entity", except after "end", and end with ";".  
" They may contain a nested definition region that begins with "is" and ends 
" with either "begin", "end", or "end entity".  The declaration region may be 
" followed by a code region that begins with "begin" and ends with either "end" 
" or "end entity".
" Yes, entities can have code regions.  About the only useful thing you can put 
" in there is "assert", though.
" An entity region may also contain "port map" and "generic map" directives, 
" which are represented with a region beginning with either "port" or "generic" 
" and ending with ";".  This ends the entity region.
syn region vhdlEntity
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\s*\<entity\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlEntMap,vhdlEntDef,vhdlEntCode,vhdlParens,vhdlSpecial,vhdlComment
syn region vhdlEntMap
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\%(\<port\>\|\<generic\>\)"
        \ end="\ze;"
        \ transparent
        \ contains=TOP
syn region vhdlEntDef
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\%(\ze\<begin\>\|\<end\>\%(\s\+\<entity\>\)\?\)"
        \ transparent
        \ contains=TOP
syn region vhdlEntCode
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<begin\>"
        \ end="\<end\>\%(\s\+\<entity\>\)\?"
        \ transparent
        \ contains=TOP

" Architecture regions begin with "architecture", except after "end", and end 
" with ";".  They may contain a nested declaration region that begins with "is" 
" and ends with "begin".  The declaration region, if it exists, is followed 
" immediately by a code region that begins with "begin" and ends with either 
" "end" or "end architecture".
syn region vhdlArchitecture
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\s*\<architecture\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlArchVars,vhdlArchCode,vhdlStatement,vhdlOf
syn region vhdlArchVars
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze\%(\<begin\>\)"
        \ transparent
        \ contains=TOP
syn region vhdlArchCode
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<begin\>"
        \ end="\<end\>\%(\s\+\<architecture\>\)\?"
        \ transparent
        \ contains=TOP

" Configuration regions begin with "configuration", except after "end", and end 
" with ";".  They may contain a nested declaration region that begins with "is" 
" and ends with ";".
syn region vhdlConfiguration
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\s*\<configuration\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlConfigDecl,vhdlStatement,vhdlOf
syn region vhdlConfigDecl
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze;"
        \ transparent
        \ contains=TOP

" Attribute regions begin with "attribute", and end with ";".  They may contain 
" a nested target region that begins with "of" and ends with ";", and may 
" contain a declaration region that begins with "is" and ends with ";".
syn region vhdlAttributeRegion
        \ matchgroup=vhdlStatement
        \ start="\<attribute\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=@vhdlNormal,vhdlAttributeTargetRegion
syn region vhdlAttributeTargetRegion
        \ matchgroup=vhdlOf
        \ contained
        \ start="\<of\>"
        \ end="\ze;"
        \ transparent
        \ contains=vhdlSpecial,vhdlReturn,vhdlAttributeTarget,vhdlAttributeDecl
syn region vhdlAttributeDecl
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze;"
        \ transparent
        \ contains=@vhdlNormal
syn keyword vhdlAttributeTarget contained package architecture configuration component entity function procedure process type subtype signal variable constant literal label

" Process regions begin with "process", except after "end", and end with ";".  
" They contain a declaration region that starts at "process" and ends at 
" "begin".  The declaration region is followed by a sequential code region that 
" starts at "begin" and ends at either "end" or "end process".
syn region vhdlProcess
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\ze\s*\<process\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlProcessVars,vhdlProcessCode
syn region vhdlProcessVars
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<process\>"
        \ end="\ze\%(\<begin\>\)"
        \ transparent
        \ contains=TOP
syn region vhdlProcessCode
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<begin\>"
        \ end="\%(\<end\>\)\@3<=\%(\s*\<process\>\)\?"
        \ transparent
        \ contains=TOP

" Function regions begin with "function", except after "end", and end with ";" 
" or "<>".  They may contain a nested parameter region that begins with "(" and 
" ends with ")".  They may contain a nested declaration region that begins with 
" "is" and ends with either "begin" or "<>".  The declaration region, if it 
" exists, may be followed immediately by a code region that begins with "begin" 
" and ends with either "end" or "end function".
syn region vhdlFunc
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\s*\<function\>"
        \ end="\ze\%(;\|<>\)"
        \ fold transparent
        \ contains=vhdlFuncParams,vhdlFuncVars,vhdlFuncCode,vhdlStatement,vhdlType,vhdlReturn
syn region vhdlFuncParams
        \ matchgroup=vhdlSpecial
        \ contained
        \ start="("
        \ end=")"
        \ transparent
        \ contains=vhdlFuncParams,@vhdlNormal
syn region vhdlFuncVars
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze\%(<>\|\<begin\>\)"
        \ transparent
        \ contains=TOP
syn region vhdlFuncCode
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<begin\>"
        \ end="\<end\>\%(\s*\<function\>\)\?"
        \ transparent
        \ contains=TOP

" Procedure regions begin with "procedure", except after "end", and end with 
" ";".  They contain a nested parameter region that begins with "(" and ends 
" with ")".  They may contain a nested declaration region that begins with "is" 
" and ends with "begin".  The declaration region, if it exists, is followed 
" immediately by a code region that begins with "begin" and ends with either 
" "end" or "end procedure".
" I don't know of empty procedures as package generics are allowed.
syn region vhdlProcedure
        \ matchgroup=vhdlStatement
        \ start="\%(\<end\>\)\@3<!\s*\<procedure\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlProcParams,vhdlProcVars,vhdlProcCode,vhdlStatement
syn region vhdlProcParams
        \ matchgroup=vhdlSpecial
        \ contained
        \ start="("
        \ end=")"
        \ transparent
        \ contains=vhdlProcParams,@vhdlNormal
syn region vhdlProcVars
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze\%(\<begin\>\)"
        \ transparent
        \ contains=TOP
syn region vhdlProcCode
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<begin\>"
        \ end="\<end\>\%(\s*\<procedure\>\)\?"
        \ transparent
        \ contains=TOP

" Package and Package Body regions begin with "package", except after "end" and 
" end with ";".  They contain a code region that starts with "is" and ends with 
" either "new", "end" or "end package".
" A "new" package region may contain a "generic map" directive, which is 
" represented by a region beginning with "generic" and ending with the final 
" ";".
syn region vhdlPackage
        \ matchgroup=vhdlStatement
        \ start="\<package\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlPackBody,vhdlPackCode,vhdlPackMap
syn region vhdlPackCode
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\(\<new\>\|\<end\>\%(\s*\<package\>\)\?\)"
        \ transparent
        \ contains=TOP
syn region vhdlPackMap
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<generic\>"
        \ end="\ze;"
        \ transparent
        \ contains=TOP
syn keyword vhdlPackBody body
highlight def link vhdlPackBody vhdlStatement

" Alias regions begin with "alias" and end with ";".  They may contain a type 
" region that starts with ":" and ends with "is".  They contain a definition 
" regision that starts with "is" and ends with ";".
syn region vhdlAlias
        \ matchgroup=vhdlStatement
        \ start="\<alias\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlAliasType,vhdlTypeDefinition
syn region vhdlAliasType
        \ matchgroup=vhdlIs
        \ start=":"
        \ end="\ze\<is\>"
        \ fold transparent
        \ contains=vhdlParens,@vhdlNormal

" Type regions begin with "type" and end with ";".  They contain a definition 
" region that starts with "is" and ends with ";".  The definition region may 
" contain a record region that begins with "record" and ends with "end record".
" Subtypes and aliases are also covered here.
" TODO Need to add "is protected" and "is protected body", but I don't 
" understand them.
syn region vhdlType
        \ matchgroup=vhdlStatement
        \ start="\%(\<subtype\>\|\<type\>\)"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlTypeDefinition
syn region vhdlTypeDefinition
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze;"
        \ transparent
        \ contains=vhdlRecord,vhdlParens,vhdlOf,@vhdlNormal
syn region vhdlRecord
        \ matchgroup=vhdlStatement
        \ contained
        \ start="\<record\>"
        \ end="\<end\s\+record\>"
        \ transparent
        \ contains=vhdlParens,@vhdlNormal

" Fold every labelled statement, from colon to semicolon.
syn region vhdlLabel
        \ matchgroup=vhdlSpecial
        \ start=":"
        \ end="\ze;"
        \ fold transparent
        \ contains=TOP

" Conditional regions begin with "if", and may be followed by "then" or 
" "generate".
syn region vhdlIf
        \ matchgroup=vhdlConditional
        \ start="\<if\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlThen,vhdlGenerate,vhdlParens,@vhdlNormal
syn region vhdlThen
        \ matchgroup=vhdlConditional
        \ contained
        \ start="\<then\>"
        \ end="\%(\<elsif\>\|\<end\s\+if\>\)"
        \ transparent
        \ contains=TOP
syn region vhdlGenerate
        \ matchgroup=vhdlConditional
        \ contained
        \ start="\<generate\>"
        \ end="\%(\<else\ze\s+generate\>\|\<end\s\+generate\>\)"
        \ transparent
        \ contains=TOP
syn keyword vhdlConditional generate

" Loop regions begin with "for", and may be followed by "loop" or "generate".
syn region vhdlFor
        \ matchgroup=vhdlConditional
        \ start="\<for\>"
        \ end="\ze;"
        \ fold transparent
        \ contains=vhdlLoop,vhdlGenerate,vhdlParens,@vhdlNormal
syn region vhdlLoop
        \ matchgroup=vhdlConditional
        \ start="\<loop\>"
        \ end="\<end\s\+loop\>"
        \ transparent
        \ contains=TOP

" The rest are easy
syn region vhdlComponent
        \ matchgroup=vhdlStatement
        \ start="\<component\>"
        \ end="\<end\>\%(\s\+\<component\>\)\?"
        \ fold transparent

syn region vhdlCase
        \ matchgroup=vhdlConditional
        \ start="\<case\>?\?"
        \ end="\<end\s\+case\>?\?"
        \ fold transparent
        \ contains=vhdlCaseDef,vhdlParens,@vhdlNormal
syn region vhdlCaseDef
        \ matchgroup=vhdlIs
        \ contained
        \ start="\<is\>"
        \ end="\ze\<end\s\+case\>?\?"
        \ transparent
        \ contains=TOP

" conditional statements
syn match   vhdlError        "\<else\s\+if\>"
syn keyword vhdlConditional  else elsif when

" VHDL keywords
syn keyword vhdlStatement after all assert
syn keyword vhdlStatement block buffer bus
syn keyword vhdlStatement context
syn keyword vhdlStatement disconnect downto
syn keyword vhdlStatement end exit
syn keyword vhdlStatement file
syn keyword vhdlStatement generic group guarded
syn keyword vhdlStatement impure in inertial inout
syn keyword vhdlStatement label library linkage literal
syn keyword vhdlStatement map
syn keyword vhdlStatement new next null
syn keyword vhdlStatement on open others out
syn keyword vhdlStatement port postponed pure
syn keyword vhdlStatement register reject report
syn keyword vhdlStatement select severity signal shared
syn keyword vhdlStatement to transport
syn keyword vhdlStatement unaffected until use
syn keyword vhdlStatement variable with
syn keyword vhdlReturn return
syn keyword vhdlOf contained of
syn keyword vhdlIs contained is

syn keyword vhdlType note warning error failure

syn keyword vhdlStorageClass access array constant range
syn keyword vhdlStatement units

syn keyword vhdlRepeat  while wait

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
syn keyword vhdlFunction abs sign ceil floor round trunc realmax realmin uniform sqrt cbrt exp log log2 log10
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

" VHDL 2008 attributes
syn match vhdlAttribute "\'element"
syn match vhdlAttribute "\'subtype"

syn keyword vhdlBoolean true false

syn region vhdlString start=+"+ end=+"+ contains=@Spell

" IEEE std_logic
" case is significant
syn case match
syn match vhdlLogic "\'[0L1HXWZU\-\?]\'"
syn match vhdlLogic "\"[0L1HXWZU\-\?_]\+\""
syn match vhdlLogic "[0-9]*[SsUu]\=[Bb]\"[0L1HXWZU\-\?_]\+\""
syn match vhdlLogic "[0-9]*[SsUu]\=[Oo]\"[0-7LHXWZU\-\?_]\+\""
syn match vhdlLogic "[0-9]*[SsUu]\=[Xx]\"[0-9a-fA-FLHXWZU\-\?_]\+\""
syn case ignore

" characters
syn match  vhdlCharacter "'.'"
syn keyword vhdlCharacter NUL SOH STX ETX EOT ENQ ACK BEL BS HT LF VT FF CR SO SI DLE
syn keyword vhdlCharacter DC1 DC2 DC3 DC4 NAK SYN ETB CAN EM SUB ESC FSP GSP RSP USP
syn keyword vhdlCharacter DEL c128 c129 c130 c131 c132 c133 c134 c135 c136 c137 c139
syn keyword vhdlCharacter c140 c141 c142 c143 c144 c145 c146 c147 c148 c149 c150 c151
syn keyword vhdlCharacter c152 c153 c154 c155 c156 c157 c158 c159

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
syn keyword vhdlOperator mod rem not
syn keyword vhdlOperator =>
syn keyword vhdlOperator **
syn match   vhdlOperator "[-+*/<>&][<>]\@!"
syn match   vhdlOperator "?\=[/<>]\=="
syn match   vhdlOperator "?[<>]"
syn match   vhdlOperator "??"
syn match   vhdlParens   "[()]"
syn match   vhdlSpecial  "[|\[\];.,]"
syn match   vhdlOperator ":="
syn match   vhdlSpecial  "<>" " make sure this isn't confused with 'not equal'
syn match   vhdlSpecial contained ":"
highlight def link vhdlParens vhdlSpecial


" extended identifier
syn region vhdlSpecial start="\\" end="\\"

" external identifier
syn region vhdlSpecial start="<<" end=">>" contains=vhdlStatement,vhdlType

" comments
syn keyword vhdlTodo contained TODO FIXME XXX NOTE

syn region  vhdlComment
            \ oneline 
            \ contains=vhdlTodo,@Spell
            \ start="--"
            \ end="$"

" Define the default highlighting.
highlight def link vhdlLabel            Label
highlight def link vhdlSpecial          Special
highlight def link vhdlStatement        Statement
highlight def link vhdlReturn           Statement
highlight def link vhdlOf               Statement
highlight def link vhdlIs               Statement
highlight def link vhdlAttributeTarget  Type
highlight def link vhdlStorageClass     StorageClass
highlight def link vhdlTypedef          Typedef
highlight def link vhdlConditional      Conditional
highlight def link vhdlRepeat           Repeat
highlight def link vhdlCharacter        Character
highlight def link vhdlString           String
highlight def link vhdlBoolean          Boolean
highlight def link vhdlComment          Comment
highlight def link vhdlSpecialComment   SpecialComment
highlight def link vhdlLogic            Number
highlight def link vhdlNumber           Number
highlight def link vhdlFloat            Float
highlight def link vhdlType             Type
highlight def link vhdlOperator         Operator
highlight def link vhdlFunction         Function
highlight def link vhdlError            Error
highlight def link vhdlAttribute        Type
highlight def link vhdlTodo             Todo

" Unfortunately the syntax folding requires we start from the beginning every 
" time.
syntax sync fromstart

let &cpo = s:cpo_save
unlet s:cpo_save
