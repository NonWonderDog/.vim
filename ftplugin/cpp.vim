" Update cmake with F4
nnoremap <buffer> <F4> :AsyncRun -cwd=<root>/build cmake ..<CR>
inoremap <buffer> <F4> <Esc>:AsyncRun -cwd=<root>/build cmake ..<CR>
vnoremap <buffer> <F4> :<C-u>AsyncRun -cwd=<root>/build cmake ..<CR>

nnoremap <buffer> <F5> :AsyncRun -cwd=<root>/build make<CR>
inoremap <buffer> <F5> <Esc>:AsyncRun -cwd=<root>/build make<CR>
vnoremap <buffer> <F5> :<C-u>AsyncRun -cwd=<root>/build make<CR>

nnoremap <buffer> <F6> :AsyncRun -cwd=<root>/build make test<CR>
inoremap <buffer> <F6> <Esc>:AsyncRun -cwd=<root>/build make test<CR>
vnoremap <buffer> <F6> :<C-u>AsyncRun -cwd=<root>/build make test<CR>

" Run with F9
nnoremap <F9> :term<CR>cd $VIM_ROOT/build<CR>make run<CR>
inoremap <F9> <Esc>:term<CR>cd $VIM_ROOT/build<CR>make run<CR>
vnoremap <F9> :<C-u>term<CR>cd $VIM_ROOT/build<CR>make run<CR>
