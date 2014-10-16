" F5 pdflatex builds 
nnoremap <F5> :w<CR>:make<CR>
inoremap <F5> <Esc>:w<CR>:make<CR>
vnoremap <F5> <C-U>:w<CR>:make<CR>
autocmd Filetype tex let &l:makeprg="pdflatex %"

