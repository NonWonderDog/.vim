nnoremap <buffer> <F5> :AsyncRun -program=make build<CR>
inoremap <buffer> <F5> <Esc>:AsyncRun -program=make build<CR>
vnoremap <buffer> <F5> :<C-u>AsyncRun -program=make build<CR>
