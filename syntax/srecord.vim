syn clear

" 
" Motorola S-Record Syntax highlighting file
"
" Written By Brad Phelan kotku@rocketmail.com 2002
"
" Version 2.0
"

" Match the Record type field
syn match s0 /^S0/ nextgroup=count0

syn match s1 /^S1/ nextgroup=count1
syn match s2 /^S2/ nextgroup=count2
syn match s3 /^S3/ nextgroup=count3

syn match s5 /^S5/ nextgroup=count5

syn match s7 /^S7/ nextgroup=count7
syn match s8 /^S7/ nextgroup=count8
syn match s9 /^S7/ nextgroup=count9

" -----------------s0 -------------------------
" Match the count field
syn match count0 /\x\x/ nextgroup=address0
" Match the address field
syn match address0 /\x\{4\}/ nextgroup=body1
" ---------------- s1 --------------------------
" Match the count field
syn match count1 /\x\x/ nextgroup=address1
" Match the address field
syn match address1 /\x\{4\}/ nextgroup=body1
" ---------------- s2 --------------------------
" Match the count field
syn match count2 /\x\x/ nextgroup=address2
" Match the address field
syn match address2 /\x\{6\}/ nextgroup=body1
" ---------------- s3 --------------------------
" Match the count field
syn match count3 /\x\x/ nextgroup=address3
" Match the address field
syn match address3 /\x\{8\}/ nextgroup=body1
" ---------------- s5 --------------------------
" Match the count field
syn match count5 /\x\x/ nextgroup=address5
" Match the address field
syn match address5 /\x\{4\}/ nextgroup=crc
" ---------------- s7 --------------------------
" Match the count field
syn match count7 /\x\x/ nextgroup=address7
" Match the address field
syn match address7 /\x\{8\}/ nextgroup=crc
" ---------------- s8 --------------------------
" Match the count field
syn match count8 /\x\x/ nextgroup=address8
" Match the address field
syn match address8 /\x\{8\}/ nextgroup=crc
" ---------------- s9 --------------------------
" Match the count field
syn match count9 /\x\x/ nextgroup=address9
" Match the address field
syn match address9 /\x\{8\}/ nextgroup=crc

" Color every byte an alternate color for easy
" skim reading
syn match body1 /\x\{2}/ nextgroup=crc,body2
syn match body2 /\x\{2}/ nextgroup=crc,body1

" Match the CRC
syn match crc /\x\x\s*$/

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_hex_syntax_inits")
  if version < 508
    let did_hex_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    command -nargs=+ HiLink hi def link <args>
  endif

  HiLink s0				WarningMsg
  HiLink s1				WarningMsg
  HiLink s2				WarningMsg
  HiLink s3				WarningMsg
  HiLink s5				WarningMsg
  HiLink s7				WarningMsg
  HiLink s8				WarningMsg
  HiLink s9				WarningMsg

  HiLink count0			Constant
  HiLink count1			Constant
  HiLink count2			Constant
  HiLink count3			Constant
  HiLink count5			Constant
  HiLink count7			Constant
  HiLink count8			Constant
  HiLink count9			Constant

  HiLink address0		Comment
  HiLink address1		Comment
  HiLink address2		Comment
  HiLink address3		Comment
  HiLink address5		Comment
  HiLink address7		Comment
  HiLink address8		Comment
  HiLink address9		Comment

  HiLink body2			CursorColumn

  HiLink crc			Search

  delcommand HiLink
endif
