nnoremap <buffer> <F5> :AsyncRun -program=make build<CR>
inoremap <buffer> <F5> <Esc>:AsyncRun -program=make build<CR>
vnoremap <buffer> <F5> :<C-u>AsyncRun -program=make build<CR>

setlocal colorcolumn=100

function! Cargo_run()
    let cwd = getcwd()
    let root = system('cargo locate-project')
    let root = matchstr(root, '{"root":"\zs.\{-}\ze"}')
    let root = fnamemodify(root, ":h")
    execute 'lcd '.root
    execute 'term cargo run'
    execute 'wincmd p'
    execute 'lcd '.cwd
    execute 'wincmd p'
endfunction

" Run with F9
nnoremap <silent> <F9> :call Cargo_run()<CR>
inoremap <silent> <F9> <Esc>:call Cargo_run()<CR>
vnoremap <silent> <F9> :<C-u>call Cargo_run()<CR>
