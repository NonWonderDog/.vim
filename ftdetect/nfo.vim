let s:fencs = ''

function! s:nfo_pre()
    let s:fencs = &g:fencs
    set fencs=ucs-bom,utf-8,cp437
endfunction

function! s:nfo_post()
    let &g:fencs = s:fencs
endfunction

au BufReadPre *.nfo call s:nfo_pre()
au BufRead,BufNewFile *.nfo set filetype=nfo
au BufReadPost *.nfo call s:nfo_post()

au GUIEnter *.nfo set lines=70 columns=81
