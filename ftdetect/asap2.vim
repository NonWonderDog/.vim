let s:fencs = ''

function! s:asap2_pre()
    let s:fencs = &g:fencs
    set fencs=ucs-bom,latin1
endfunction

function! s:asap2_post()
    let &g:fencs = s:fencs
endfunction

au BufReadPre *.a2l,*.aml call s:asap2_pre()
au BufRead,BufNewFile *.a2l set filetype=asap2
au BufRead,BufNewFile *.aml set filetype=asap2ml
au BufReadPost *.a2l,*.aml call s:asap2_post()
