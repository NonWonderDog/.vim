" Extra Doxygen syntax highlighting

" escape characters and non-printing single '\' characters
syn match doxygenEscape "[\@]\%(---\|--\|::\|[\$@&~<>#%".|]\)"

" normal commands, containing a keyword
syn region doxygenCommandRegion matchgroup=doxygenCommand start="[\@]\a\@=" end="\A\@=" contains=doxygenCommand
syn region doxygenCommandRegion matchgroup=doxygenTodo start="[\@]\a\@=\%(todo\|bug\)" end="\A\@="

" function commands -- doesn't play nice with comment characters on every line
"syn region doxygenCommandRegion matchgroup=doxygenCommand start="[\@]f\A\@=\s\@!" end="\%([\[\]}$]\|{.\{-}}{\?\|\s\)"
syn region doxygenCommandRegion matchgroup=doxygenCommand start="[\@]f\$" end="[\@]f\$" contains=@texMathZoneGroup
syn region doxygencommandregion matchgroup=doxygencommand start="[\@]f\[" end="[\@]f\]" contains=@texMathZoneGroup
syn region doxygencommandregion matchgroup=doxygencommand start="[\@]f{.\{-}}{" end="[\@]f\}" contains=@texMathZoneGroup

" plantuml -- doesn't play nice with comment characters on every line
"syn include @plantuml syntax/plantuml.vim " Doesn't work
syn region doxygencommandregion matchgroup=doxygencommand start="[\@]startuml\%({.\{-}}\)\?" end="[\@]enduml" contains=@plantuml

syn keyword doxygencommand contained a addindex addtogroup anchor arg attention author authors
syn keyword doxygencommand contained b brief
syn keyword doxygencommand contained c callgraph callergraph category cite class code cond copybrief copydetails copydoc copyright
syn keyword doxygencommand contained date def defgroup deprecated details diafile dir docbookonly dontinclude dot dotfile
syn keyword doxygenCommand contained e else elseif em enum example exception extends
syn keyword doxygenCommand contained endcode endcond enddocbookonly endif endinternal endlatexonly endlink endmanonly endmsc endparblock endrtfonly endsecreflist endverbatim endxmlonly 
syn keyword doxygenCommand contained file fn
syn keyword doxygenCommand contained headerfile hideinitializer htmlinclude htmlonly
syn keyword doxygenCommand contained idlexcept if ifnot image implements include includelineno ingroup internal invariant interface
syn keyword doxygenCommand contained latexinclude latexonly li line link 
syn keyword doxygenCommand contained mainpage manonly memberof msc mscfile
syn keyword doxygenCommand contained n name namespace nosubgrouping note
syn keyword doxygenCommand contained overload
syn keyword doxygenCommand contained p package page par paragraph param parblock post pre private privatesection property protected protectedsection pure
syn keyword doxygenCommand contained ref refitem related relates relatedalso relatesalso remark remarks result return returns retval rtfonly
syn keyword doxygenCommand contained sa secreflist section see short showinitializer since skip skipine snippet struct subpage subsection subsubsection
syn keyword doxygenCommand contained tableofcontents test throw throws tparam typedef
syn keyword doxygenCommand contained union until
syn keyword doxygenCommand contained var verbatim verbinclude version vhdlflow
syn keyword doxygenCommand contained warning weakgroup
syn keyword doxygenCommand contained xmlonly xrefitem

hi link doxygenCommand  Special
hi link doxygenEscape   Special
hi link doxygenTodo     Todo

