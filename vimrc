" Bob Morris .vimrc file
" Incorpoating some ideas from spf13
" Tested on Windows 10 and Arch Linux
" Using Vim 8.0

" Environment {{{
" Identify platform {{{
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! WINDOWS()
    return  (has('win32') || has('win64'))
endfunction
" }}}

" Basics {{{
set nocompatible
if !WINDOWS()
    set shell=sh
endif
" }}}

" Unicode/Japanese Support {{{
if has("multi_byte")
    " use unicode
    set encoding=utf-8
    set fileencoding=utf-8
    scriptencoding utf-8
    if WINDOWS()
        " The "default" codepage on English Windows is "latin1", which 
        " is wrong. It should be "cp1252".  Unfortunately that means we 
        " can't use "default" here, so you have to change this if 
        " you're on non-English Windows.
        setglobal fileencodings=ucs-bom,utf-8,sjis,cp1252
    else
        " recognize SJIS on Linux
        setglobal fileencodings=ucs-bom,utf-8,sjis,default,latin1
    end
    " default to IME off
    set iminsert=0
    set imsearch=-1
endif
" }}}

" Windows/Linux Compatibility {{{
if WINDOWS()
    " use '.vim' instead of 'vimfiles', and use .viminfo
    if !has('nvim')
        set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
        set viminfo+=n~/.viminfo
    endif
    " using a shell other than cmd causes too many plugin issues
    " if executable("bash") || executable("tcsh")
    "    " Use *nix shell if available
    "    if executable("tcsh")
    "        set shell=tcsh
    "        set shellredir=>&
    "    elseif executable("bash")
    "        set shell=bash
    "        set shellredir=>%s\ 2>&1
    "    endif
    "    set shellslash
    "    " set shell configuration here to avoid confusing early-loading
    "    " plugins
    "    set shellcmdflag=-c
    "    set shellpipe=>
    "    set shellxquote=\"
    " else
    "    set shell=cmd
    " endif
    if executable("tee")
        " Make build output show up on the screen, just like in *nix
        " noshelltemp and nomore ideally would be set only during make
        set shellpipe=2>&1\|\ tee
        if &shell =~ "csh"
            set shellpipe=\|&\ tee
        endif
        set noshelltemp
        set nomore
    endif
endif
" }}}

" Grep program {{{
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor
elseif executable("grep")
    if WINDOWS()
        if executable("sed")
            " call sed to replace posix /c/ paths with c:/
            let &grepprg='grep -n -H $* \| sed \"s_^/\\(.\\)._\\1:/_\"'
        else
            set grepprg=grep\ -n\ -H
        endif
    endif
endif
" }}}

" Temp Files {{{
" keep swap, backup, undo, and view files tidy
" create directories if they don't exist
if empty(glob('~/.vim/.backup'))
    call mkdir($HOME . "/.vim/.backup")
endif
if empty(glob('~/.vim/.swap'))
    call mkdir($HOME . "/.vim/.swap")
endif
if empty(glob('~/.vim/.undo'))
    call mkdir($HOME . "/.vim/.undo")
endif
" use local hidden directories if they exist
set directory=./.vim-swap//
set backupdir=./.vim-backup//
set undodir=./.vim-swap//
" otherwise use directories in ~/.vim
set directory+=~/.vim/.swap//
set backupdir+=~/.vim/.backup//
set undodir+=~/.vim/.undo//
" viewdir only accepts a single directory
set viewdir=~/.vim/.view
set viewoptions=folds,cursor,unix,slash

set swapfile " use swap files
if has('persistent_undo')
    set undofile " use persistent undo
    set undolevels=1000
    set undoreload=10000
endif
set nobackup " no permanent backups
set writebackup " make a temporary backup before overwriting a file
" }}}
" }}}
" Plugins {{{
" Allow :Man lookups
runtime ftplugin/man.vim

" Manage plugins with vim-plug
call plug#begin('~/.vim/plugged')

" colorschemes
" I use my own based on wombat, but sometimes I need a light scheme.
Plug 'yfiua/vim-github-colorscheme'
Plug 'jonathanfilip/vim-lucius'
Plug 'SimonGreenhill/summerfruit256.vim'

" others
Plug 'PProvost/vim-ps1'
Plug 'dag/vim-fish'

Plug 'bimlas/vim-eightheader'

Plug 'Twinside/vim-hoogle', { 'for': 'haskell' }
Plug 'Twinside/vim-syntax-haskell-cabal', { 'for': 'haskell' }

Plug 'Konfekt/FastFold'
Plug 'zhimsel/vim-stay'
Plug 'kien/ctrlp.vim'
Plug 'bkad/CamelCaseMotion'
Plug 'equalsraf/neovim-gui-shim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'kergoth/vim-hilinks'
" Plug 'majutsushi/tagbar'
Plug 'tmhedberg/matchit'
Plug 'tomtom/tcomment_vim'

Plug 'mbbill/undotree'
Plug 'machakann/vim-sandwich'

Plug 'rust-lang/rust.vim'

Plug 'skywind3000/asyncrun.vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-characterize'

Plug 'vimoutliner/vimoutliner'

Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-pandoc-after'
Plug 'vim-scripts/a.vim'

Plug 'Kuniwak/vint'
Plug 'w0rp/ale'
Plug 'markonm/traces.vim'

" Plug 'ludovicchabant/vim-gutentags'

Plug 'idbrii/vim-focusclip', and(has('clipboard'),empty($MSYSTEM)) ? {} : { 'for': [] }
Plug 'kana/vim-fakeclip', has('clipboard') ? { 'for': [] } : {}
Plug 'wincent/terminus'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

" Use pathogen
" runtime bundle/vim-pathogen/autoload/pathogen.vim
" execute pathogen#infect()


" }}}
" Editor {{{

" enable the mouse
if has('mouse')
    set mouse=a
endif

set shortmess+=filmnrxoOtT      " Abbreviate messages (no 'hit enter')
set hidden                      " keep hidden buffers on window close

" Use all filetype-dependent settings
filetype plugin indent on

" set spellcheck dictionary to US English
set spelllang=en_us

" essentials
set history=100         " keep 100 lines of command line history
set switchbuf=usetab    " when executing quickfix or buffer split command, look for existing window before opening a new one
if has("linebreak")
    set linebreak       " break at word boundaries when 'wrap' is set
    set showbreak=..    " start wrapped lines with '..'
    if exists("&breakindent")
        set breakindent " maintain indents when wrapping
    endif
endif
set display+=lastline   " show partial lines when wrapping
set noequalalways       " don't resize windows on close or split
set ttimeoutlen=10      " 10 ms delay for terminal escape codes
set title               " update window title in console

" Change shown characters for list mode
set listchars=tab:►—,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→

" set session saving options
set sessionoptions=help,sesdir,tabpages,winsize

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set virtual editing mode for visual block selection
set virtualedit=block

" use popup right-click menu on all platforms
set mousemodel=popup

" better search settings
set incsearch           " do incremental searching
set ignorecase          " use case-insensitive searches
set smartcase           " make only lower-case patterns case-insensitive

" Use syntax and search highlighting, when the terminal has colors
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" better folding
set foldmethod=syntax
set foldlevelstart=1
set foldopen-=block " don't open folds by { } etc. motions

if !empty(glob("~/.vim/plugged/vim-eightheader"))
    function! FoldText()
        let l:text  = matchstr(foldtext(), '\(: \)\@<=.*')
        let l:count = v:foldend - v:foldstart + 1
        let l:start = '+' . v:folddashes
        let l:end   = '(' . l:count . ' lines)'
        return EightHeaderCall(l:text, &textwidth, 'left', [ l:start, '-', ' ' ], l:end, '\=" ".s:str." "' )
    endfunction
    set foldtext=FoldText()
endif

" use autoformatting
set textwidth=79        " autoformat to 79-column text
set formatoptions-=t    " don't autoformat text (=code) by default
set formatoptions+=cjwa " use auto-format for comments, using trailing space for continuation
set formatoptions+=1    " don't break after single letter words
" set formatoptions+=mB   " support CJK line break rules more properly
set formatoptions+=M    " support unicode math more properly

" set compatibility options
set cpoptions+=J        " sentences are separated by two spaces

" limit syntax highlighting on long lines for speed
set synmaxcol=400

" use wildcard completion menu
set wildmenu
set wildmode=full

" Tabs should align to 8 columns to match posix terminal output (and github),
" but I prefer 4 spaces for indentation.
" This is a compromise configuration in which tabs are always 8 spaces wide, 
" except at the beginning of a line where 4 space indents are used.  This way 
" all you need to do to edit tab-delimited files is "set noexpandtab".
set autoindent          " use automatic indent hanging
set tabstop=8           " literal tabs are 8 spaces wide
set softtabstop=8       " expanded tabs are 8 spaced wide
set shiftwidth=4        " indent code by 4 spaces
set smarttab            " use shiftwidth instead of softtabstop for tabs at beginning of line
set expandtab           " don't insert tab characters

" C indent options
set cinoptions=:0       " don't indent case labels
set cinoptions+=g0      " don't indent C++ scope declarations
set cinoptions+=N-s     " don't indent after namespace declaration

set nowrap              " turn off text wrap
set sidescroll=1        " better unwrapped text scrolling

" Use explicit tab characters in makefiles
autocmd FileType make setlocal noexpandtab

" Use HTML for 'K' man page lookups in gui if possible
" <Leader>K can be used for man.vim lookups
if has('gui_running')
    if executable('man') && executable('groff')
        if !empty($BROWSER)
            set keywordprg=man\ -H
        elseif executable('firefox')
            set keywordprg=man\ -Hfirefox
        elseif executable('chromium-browser')
            set keywordprg=man\ --html=chromium-browser
        elseif executable('google-chrome')
            set keywordprg=man\ --html=google-chrome
        endif
    endif
endif

" use :help for 'K' lookups in vim files
autocmd FileType vim setlocal keywordprg=:help

" default quickfix support
set errorformat=%f(%l):%m
" improved gcc compatibility
set errorformat+=%f:%l:\ %tarning:\ %m
set errorformat+=%f:%l:\ %trror:\ %m
" more defaults
set errorformat+=%f:%l:%m
set errorformat+=%f\|%l\|\ %m
" Cosmic compiler
set errorformat+=#%t%*[^\ ]\ %*[^\ ]\ %f:%l\ %m
set errorformat+=#%t%*[^\ ]\ %*[^\ ]\ %f:%l(%c)\ %m
set errorformat+=#%t%*[^\ ]\ %*[^\ ]\ %f:%l(%c+%*[0-9])\ %m

" use side-by-side diffs
set diffopt+=vertical

" more natural split directions
" set splitbelow
set splitright

if has("autocmd")
    " Jump to the last cursor position when opening a buffer
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif
endif

" }}}
" Appearance {{{

set guioptions=m        " hide all gui stuff except menu bar
set guioptions+=A       " copy to clipboard on modeless selection
set laststatus=2        " always show status line
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set cc=80               " highlight column 80
if WINDOWS()
    " Gnome has this as an option, but windows always makes a ding
    set visualbell          " get rid of the stupid noise
endif

" Set windows font and color scheme
colorscheme numbat
if WINDOWS()
    set guifont=Consolas:h8
    set guifontwide=MS_Gothic:h8:cSHIFTJIS
endif

if $TERM =~ "^xterm"
    if empty($ConEmuBuild)
        " set xterm escape sequences
        let &t_ZH="\e[3m"       " start italics
        let &t_ZR="\e[23m"      " end italics
        let &t_us="\e[4m"       " start underline
        let &t_ue="\e[24m"      " end underline
        let &t_SI="\e[5 q"      " start insert (blinking bar)
        let &t_EI="\e[1 q"      " end insert (blinking block)
    endif
endif

if $COLORTERM == "gnome-terminal"
    " In Ubuntu the arrows fall back on wrong-sized fonts
    set listchars=tab:▸—,eol:¬,trail:·,nbsp:⁃,precedes:«,extends:»
    " Use 256 color mode
    set t_Co=256
    " use autocommands since DECSCUSR isn't supported yet
    " This isn't really optimal since it changes the default profile for all
    " terminal windows, but it's the only solution that works.
    let &t_SI=""
    let &t_EI=""
    if has("autocmd")
        " the VimEnter command shows termresponse on startup???
        "au VimEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
        au InsertEnter * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape ibeam"
        au InsertLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
        au VimLeave * silent execute "!gconftool-2 --type string --set /apps/gnome-terminal/profiles/Default/cursor_shape block"
    endif
endif

if !empty($ConEmuBuild) && !empty($TERM)
    " 256 color terminal is possible in Windows using ConEmu
    " set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm" " set ANSI background color
    let &t_AF="\e[38;5;%dm" " set ANSI foreground color
    let &t_ZH="\e[3m"       " start italics
    let &t_ZR="\e[23m"      " end italics
    let &t_us="\e[4m"       " start underline
    let &t_ue="\e[24m"      " end underline
    " rebind mouse wheel
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
    "inoremap <Esc>[62~ <C-X><C-E>
    "inoremap <Esc>[63~ <C-X><C-Y>
    " rebind backspace
    map <Char-0x07F> <BS>
    imap <Char-0x07F> <BS>
    " This only really works using codepage 65001
    set listchars=tab:►—,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→
endif

" Make sure &t_EI fires on startup
" This just enters insert mode, does nothing, and returns to normal mode
au VimEnter * normal a

" Set gui window size
if has("gui_running")
    " GUI is running or is about to start.
    set lines=48 columns=161
    "if WINDOWS()
    "    " Maximize window with the worst hack possible (English Windows)
    "    if has("autocmd")
    "        au GUIEnter * simalt ~x
    "    endif
    "endif
endif

" }}}
" Mappings {{{

" Don't use Ex mode, use Q to replay the q macro
nnoremap Q @q
vnoremap Q :norm @q<cr>

" more logical Y mapping
nnoremap Y y$

" CTRL-U (delete entered text on current line) in insert mode deletes a lot.
" Use CTRL-G u to first break undo, so that you can undo CTRL-U after
" inserting a line break.  Do the same for CTRL-W (delete word)
inoremap <C-U> <C-G>u<C-U>
inoremap <c-w> <c-g>u<c-w>

" sudo write with W!
cmap W! w !sudo tee >/dev/null %

" remove middle mouse button paste mapping
" map <MiddleMouse> <Nop>
" imap <MiddleMouse> <Nop>
" map <2-MiddleMouse> <Nop>
" imap <2-MiddleMouse> <Nop>
" map <3-MiddleMouse> <Nop>
" imap <3-MiddleMouse> <Nop>
" map <4-MiddleMouse> <Nop>
" imap <4-MiddleMouse> <Nop>

" Get rid of F1 help
map <F1> <Nop>
imap <F1> <Nop>

" Create Blank Newlines and stay in Normal mode with <Enter>
"nnoremap <silent> <Enter> o<Esc>
"nnoremap <silent> <S-Enter> O<Esc>

" Break line with CTRL-J
nnoremap <NL> i<CR><ESC>

" Clear highlighting with <C-l>
nnoremap <silent> <C-l> :<C-U>noh<CR><C-l>

" Toggle folds with spacebar
nnoremap <Space> za
vnoremap <Space> za
" Toggle folds recursively with S-Space (gui) or C-Space
nnoremap <S-Space> zA
vnoremap <S-Space> zA
nnoremap <NUL> zA
nnoremap <NUL> zA

" Exit insert mode with jj or jk
inoremap jj <Esc>
inoremap jk <Esc>

" Always move by screen lines instead of file lines
nnoremap j gj
nnoremap k gk

" Navigate windows with Alt-movement keys
set winaltkeys=no
if $TERM =~ "^tmux"
    nnoremap <silent> <Esc>h :<C-u>TmuxNavigateLeft<CR>
    nnoremap <silent> <Esc>j :<C-u>TmuxNavigateDown<CR>
    nnoremap <silent> <Esc>k :<C-u>TmuxNavigateUp<CR>
    nnoremap <silent> <Esc>l :<C-u>TmuxNavigateRight<CR>
    nnoremap <silent> <A-h> :<C-u>TmuxNavigateLeft<CR>
    nnoremap <silent> <A-j> :<C-u>TmuxNavigateDown<CR>
    nnoremap <silent> <A-k> :<C-u>TmuxNavigateUp<CR>
    nnoremap <silent> <A-l> :<C-u>TmuxNavigateRight<CR>
    tnoremap <silent> <Esc>h <C-w>:<C-u>TmuxNavigateLeft<CR>
    tnoremap <silent> <Esc>j <C-w>:<C-u>TmuxNavigateDown<CR>
    tnoremap <silent> <Esc>k <C-w>:<C-u>TmuxNavigateUp<CR>
    tnoremap <silent> <Esc>l <C-w>:<C-u>TmuxNavigateRight<CR>
    tnoremap <silent> <A-h> <C-w>:<C-u>TmuxNavigateLeft<CR>
    tnoremap <silent> <A-j> <C-w>:<C-u>TmuxNavigateDown<CR>
    tnoremap <silent> <A-k> <C-w>:<C-u>TmuxNavigateUp<CR>
    tnoremap <silent> <A-l> <C-w>:<C-u>TmuxNavigateRight<CR>
else
    nnoremap <silent> <Esc>h :<C-u>wincmd h<CR>
    nnoremap <silent> <Esc>j :<C-u>wincmd j<CR>
    nnoremap <silent> <Esc>k :<C-u>wincmd k<CR>
    nnoremap <silent> <Esc>l :<C-u>wincmd l<CR>
    nnoremap <silent> <A-h> :<C-u>wincmd h<CR>
    nnoremap <silent> <A-j> :<C-u>wincmd j<CR>
    nnoremap <silent> <A-k> :<C-u>wincmd k<CR>
    nnoremap <silent> <A-l> :<C-u>wincmd l<CR>
    tnoremap <silent> <Esc>h <C-w>h
    tnoremap <silent> <Esc>j <C-w>j
    tnoremap <silent> <Esc>k <C-w>k
    tnoremap <silent> <Esc>l <C-w>l
    tnoremap <silent> <A-h> <C-w>h
    tnoremap <silent> <A-j> <C-w>j
    tnoremap <silent> <A-k> <C-w>k
    tnoremap <silent> <A-l> <C-w>l
endif

" Make with F5
" nnoremap <F5> :make<CR>
" inoremap <F5> <Esc>:make<CR>
" vnoremap <F5> :<C-u>make<CR>
nnoremap <F5> :AsyncRun -cwd=<root> -program=make<CR>
inoremap <F5> <Esc>:AsyncRun -cwd=<root> -program=make<CR>
vnoremap <F5> :<C-u>AsyncRun -cwd=<root> -program=make<CR>

" Run tests with F6
nnoremap <F6> :AsyncRun -program=make test<CR>
inoremap <F6> <Esc>:AsyncRun -program=make test<CR>
vnoremap <F6> :<C-u>AsyncRun -program=make test<CR>

" Step through quickfix with F7 F8
nnoremap <silent> <F7> :<C-u>cp<CR>
nnoremap <silent> <F8> :<C-u>cn<CR>

" Open Tagbar with F10
nnoremap <silent> <F10> :<C-u>TagbarToggle<CR>

" Compile plantUML with F11
" nnoremap <F11> :w<CR>:silent !plantuml %<CR>
" inoremap <F11> <Esc>:w<CR>:silent !plantuml %<CR>
" vnoremap <F11> <C-U>:w<CR>:silent !plantuml %<CR>

" Fullscreen on F11 for Windows gvim
" using dll from asins/gvimfullscreen_win32
if has('gui_running')
    if has('win64')
        map <F11> :<C-u>call libcallnr($HOME."/.vim/gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
    elseif has('win32')
        map <F11> :<C-u>call libcallnr($HOME."/.vim/gvimfullscreen_x32.dll", "ToggleFullScreen", 0)<CR>
    endif
endif

" clang-format with <leader>=
nmap <leader>= <Plug>(ale_fix)

" }}}
" Commands {{{

" CDC = Change to Directory of Current file
command CDC cd %:p:h
command LCDC lcd %:p:h

" Make = asynchronous :make
command! -bang -nargs=* -complete=file Make AsyncRun -program=make @ <args>

" Output,OutputWin,OutputTab simplify grabbing output from ex commands
function! RedirMessages(msgcmd, destcmd)
    " Captures the output generated by executing a:msgcmd, then places this
    " output in the current buffer.
    "
    " If the a:destcmd parameter is not empty, a:destcmd is executed
    " before the output is put into the buffer. This can be used to open a
    " new window, new tab, etc., before :put'ing the output into the
    " destination buffer.
    redir => message
    silent execute a:msgcmd
    redir END

    if strlen(a:destcmd) " destcmd is not an empty string
        silent execute a:destcmd
    endif

    silent put=message
endfunction

" Create commands to make RedirMessages() easier to use interactively.
" eg.
"   :Output registers
"   :OutputWin ls
"   :OutputTab echo "Key mappings for Control+A:" | map <C-A>
"
command! -nargs=+ -complete=command Output call RedirMessages(<q-args>, ''       )
command! -nargs=+ -complete=command OutputWin call RedirMessages(<q-args>, 'new'    )
command! -nargs=+ -complete=command OutputTab call RedirMessages(<q-args>, 'tabnew' )

" commands for scratch buffers
command! -complete=command Scratch  :new    | :setlocal buftype=nofile | :setlocal noswapfile
command! -complete=command EScratch :enew   | :setlocal buftype=nofile | :setlocal noswapfile
command! -complete=command VScratch :vnew   | :setlocal buftype=nofile | :setlocal noswapfile
command! -complete=command TScratch :tabnew | :setlocal buftype=nofile | :setlocal noswapfile

" }}}
" Autocommands {{{
if has("autocmd")
    augroup vimrc
        " save clipboard on exit
        if executable("xsel")
            autocmd VimLeave * call system("xsel -ib", getreg("+"))
        endif
    augroup END
endif
" }}}
" Syntax Options {{{
" Load doxygen in supported files
let g:load_doxygen_syntax=1
" Use LaTeX instead of TeX
let g:tex_flavor = "latex"
" Apply language-specific highlighting inside markdown fenced code blocks
let g:markdown_fenced_languages = [
            \ 'sh', 'shell=sh', 'bash=sh', 'zsh=sh', 'tcsh',
            \ 'tex', 'latex=tex',
            \ 'css', 'html', 'xml',
            \ 'javascript', 'js=javascript', 'json=javascript',
            \ 'c', 'cpp', 'csharp=cs', 'c#=cs',
            \ 'vhdl', 'verilog', 'tcl'
            \ ]
" }}}
" Plugin Settings {{{

" CamelCaseMotion Options
if !empty(glob("~/.vim/plugged/CamelCaseMotion/"))
    call camelcasemotion#CreateMotionMappings('<Leader>')
endif

" Easytags Options
set tags=./tags;,~/.vimtags " add upward search for local tags files
let g:easytags_dynamic_files = 1 " write to first available tags file from above list
let g:easytags_async = 1
if WINDOWS()
    let g:easytags_file = '~/.vimtags'
else
    let g:easytags_file = '~/.vimtags-$USER'
endif
" add arduino support
let g:easytags_languages = {
            \   'arduino': {
            \       'cmd': 'ctags',
            \       'args': [],
            \       'fileoutput_opt': '-f',
            \       'stdout_opt': '-f-',
            \       'recurse_flag': '-R'
            \   }
            \}

" TagBar Options
" Add arduino support
let g:tagbar_type_arduino = {
            \ 'ctagstype' : 'c++',
            \ 'kinds'     : [
            \ 'd:macros:1:0',
            \ 'p:prototypes:1:0',
            \ 'g:enums',
            \ 'e:enumerators:0:0',
            \ 't:typedefs:0:0',
            \ 'n:namespaces',
            \ 'c:classes',
            \ 's:structs',
            \ 'u:unions',
            \ 'f:functions',
            \ 'm:members:0:0',
            \ 'v:variables:0:0'
            \ ],
            \ 'sro'        : '::',
            \ 'kind2scope' : {
            \ 'g' : 'enum',
            \ 'n' : 'namespace',
            \ 'c' : 'class',
            \ 's' : 'struct',
            \ 'u' : 'union'
            \ },
            \ 'scope2kind' : {
            \ 'enum'      : 'g',
            \ 'namespace' : 'n',
            \ 'class'     : 'c',
            \ 'struct'    : 's',
            \ 'union'     : 'u'
            \ }
            \ }

" vim-markdown-folding Options
let g:markdown_fold_style = 'nested'

" disable tmux-navigator default mappings
let g:tmux_navigator_no_mappings = 1

" unbreak sentence motions
" vim-sandwich defines `is` and `as`; move them to `iq` and `aq`
let g:textobj_sandwich_no_default_key_mappings = 1
xmap ib <Plug>(textobj-sandwich-auto-i)
omap ib <Plug>(textobj-sandwich-auto-i)
xmap ab <Plug>(textobj-sandwich-auto-a)
omap ab <Plug>(textobj-sandwich-auto-a)

xmap iq <Plug>(textobj-sandwich-query-i)
omap iq <Plug>(textobj-sandwich-query-i)
xmap aq <Plug>(textobj-sandwich-query-a)
omap aq <Plug>(textobj-sandwich-query-a)

" pandoc options
let g:pandoc#after#modules#enabled = ["tablemode"]
let g:pandoc#modules#disabled = []
let g:pandoc#folding#fold_fenced_codeblocks = 1
let g:pandoc#folding#fdc = 4
let g:pandoc#formatting#mode = 'ha'
let g:pandoc#syntax#conceal#urls = 0
let g:pandoc#syntax#codeblocks#embeds#use = 1
let g:pandoc#syntax#codeblocks#embeds#langs = ["c","cpp","sh","vhdl","makefile=make","asm"] " 'forth' breaks word boundaries...
let g:pandoc#syntax#style#emphases = 1
let g:pandoc#syntax#style#underline_special = 1
let g:pandoc#syntax#style#use_definition_lists = 1

"ale
let g:ale_linters = {
            \   'cpp': ['clangd','clangtidy'],
            \   'rust': ['rls']
            \}
let g:ale_rust_rls_toolchain = 'stable'
let g:ale_fixers = {
            \   '*': ['remove_trailing_lines'],
            \   'cpp': ['clang-format'],
            \   'rust': ['rustfmt']
            \}
" let g:ale_cpp_gcc_options = '-std=c++17 -Wall -Wextra'
" let g:ale_cpp_clang_options = '-std=c++17 -Wall -Wextra'
" let g:ale_cpp_clangtidy_options = '-std=c++17 -Wall -Wextra -x c++'
" let g:ale_cpp_clangcheck_options = '-- -std=c++17 -Wall -Wextra -x c++'
let g:ale_cpp_gcc_options = '-std=c++17 -Wall -Wextra -I' . getcwd()
let g:ale_cpp_clang_options = '-std=c++17 -Wall -Wextra -I' . getcwd()
let g:ale_cpp_clangtidy_options = '-std=c++17 -Wall -Wextra -x c++ -I' . getcwd()
let g:ale_cpp_clangtidy_checks = [
            \    'bugprone-*',
            \    'cppcoreguidelines-*',
            \    'modernize-*',
            \    'performance-*',
            \    'portability-*',
            \    'readability-*',
            \    '-readability-named-parameter',
            \    '-cppcoreguidelines-pro-bounds-constant-array-index'
            \]
let g:ale_cpp_clangcheck_options = '-- -std=c++17 -Wall -Wextra -x c++ -I' . getcwd()
" let g:ale_c_parse_compile_commands = 1
" let g:ale_c_parse_makefile = 1
let g:ale_c_build_dir_names = ['build', 'bin', 'release', 'debug']
let g:ale_completion_enabled = 1

"asyncrun
" refresh quickfix list after completion
let g:asyncrun_exit = "silent copen | wincmd p"
let g:asyncrun_open = 10
let g:asyncrun_save = 1
let g:asyncrun_auto = "make"
" }}}
" Neovim {{{
if has('nvim')
    set termguicolors
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
" }}}
" vim:fdm=marker:fdl=0:
