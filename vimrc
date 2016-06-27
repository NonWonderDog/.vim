" Bob Morris .vimrc file
" Tested on Windows 7 and Ubuntu 14.04
" Using Vim 7.4

" vim:fdm=marker

set nocompatible

" Environment {{{
if has("multi_byte")
    " use unicode
    set encoding=utf-8
    set fileencoding=utf-8
    scriptencoding utf-8
    if has('win32') || has('win64')
        " use SJIS and 'ANSI' codepages on Windows
        " The "default" codepage on English Windows is "latin1", which is 
        " wrong. It should be "cp1252".  Unfortunately that means we can't use 
        " "default" here, so you have to change this if you're on Russian 
        " Windows, for example.
        setglobal fileencodings=ucs-bom,utf-8,sjis,cp1252
    else
        " recognize SJIS on Linux
        setglobal fileencodings=ucs-bom,utf-8,sjis,default,latin1
    end
    " default to IME off
    set iminsert=0
    set imsearch=-1
endif

if has('win32') || has('win64')
    " use '.vim' instead of 'vimfiles', and use .viminfo
    if !has('nvim')
        set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
        set viminfo+=n~/.viminfo
    endif
    " using bash really confuses ConEmu
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

" Use ag or ack instead of grep
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor
elseif executable("grep")
    if executable("sed")
        " call sed to replace posix /c/ paths with c:/
        let &grepprg='grep -n -H $* \| sed \"s_^/\\(.\\)._\\1:/_\"'
    else
        set grepprg=grep\ -n\ -H
    endif
endif

" keep swap, backup, and undo files tidy
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

set swapfile " use swap files
set undofile " use persistent undo
set nobackup " no permanent backups
set writebackup " make a temporary backup before overwriting a file

" enable the mouse
if has('mouse')
    set mouse=a
endif

" }}}
" {{{ Plugins
" Allow :Man lookups
runtime ftplugin/man.vim

" Manage plugins with vim-plug
call plug#begin('~/.vim/plugged')
Plug 'PProvost/vim-ps1'

Plug 'Twinside/vim-hoogle'
Plug 'Twinside/vim-syntax-haskell-cabal'

Plug 'bkad/CamelCaseMotion'
Plug 'equalsraf/neovim-gui-shim'
Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'kannokanno/previm'
Plug 'kergoth/vim-hilinks'
Plug 'majutsushi/tagbar'
Plug 'nelstrom/vim-markdown-folding'
Plug 'scrooloose/syntastic'
Plug 'tmhedberg/matchit'
Plug 'tomtom/tcomment_vim'

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'

Plug 'tyru/open-browser.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'xolox/vim-easytags'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'
call plug#end()

" Use pathogen
" runtime bundle/vim-pathogen/autoload/pathogen.vim
" execute pathogen#infect()


" }}}
" Editor {{{

" Use all filetype-dependent settings
filetype plugin indent on

" set spellcheck dictionary to US English
set spelllang=en_us

" essentials
set hidden              " keep hidden buffers on window close
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

" start with folding on
set foldmethod=syntax
set foldlevelstart=0

" use autoformatting
set textwidth=79        " autoformat to 79-column text
set formatoptions-=t    " don't autoformat text (=code) by default
set formatoptions+=cjwa " use auto-format for comments, using trailing space for continuation
set formatoptions+=1    " don't break after single letter words
set formatoptions+=mB   " support CJK line break rules more properly

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
set autoindent          " use automatic indenting
set smartindent         " use 'C-lite' indent rules for filetypes that don't define rules
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

" little tweaks
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
set laststatus=2        " always show status line
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set cc=80               " highlight column 80
if has('win32') || has('win64')
    " Gnome has this as an option, but windows always makes a ding
    set visualbell          " get rid of the stupid noise
endif

" Change shown characters for list mode
if has("gui_running")
    set listchars=tab:►—,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→
else
    " avoid unicode for safety
    set listchars=tab:>-,eol:¬,trail:·,nbsp:·,precedes:«,extends:»
endif

" Set windows font and color scheme
colorscheme numbat
if has('win32') || has('win64')
    set guifont=Consolas:h8
    set guifontwide=MS_Gothic:h8:cSHIFTJIS
endif

if $TERM =~ "^xterm"
    " set xterm escape sequences
    let &t_ZH="\e[3m"       " start italics
    let &t_ZR="\e[23m"      " end italics
    let &t_us="\e[4m"       " start underline
    let &t_ue="\e[24m"      " end underline
    let &t_SI="\e[5 q"      " start insert (blinking bar)
    let &t_EI="\e[1 q"      " end insert (blinking block)
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

if !empty($CONEMUBUILD)
    " 256 color terminal is possible in Windows using ConEmu
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm" " set ANSI background color
    let &t_AF="\e[38;5;%dm" " set ANSI foreground color
    let &t_ZH="\e[3m"       " start italics
    let &t_ZR="\e[23m"      " end italics
    let &t_us="\e[4m"       " start underline
    let &t_ue="\e[24m"      " end underline
    " rebind mouse wheel
    map <Esc>[62~ <C-E>
    imap <Esc>[62~ <C-X><C-E>
    map <Esc>[63~ <C-Y>
    imap <Esc>[63~ <C-X><C-Y>
    " rebind backspace
    map <Char-0x07F> <BS>
    imap <Char-0x07F> <BS>
    " This only really works using codepage 65001
    set listchars=tab:►—,eol:¬,trail:·,nbsp:⁃,precedes:←,extends:→
endif

" Set gui window size
if has("gui_running")
    " GUI is running or is about to start.
    set lines=48 columns=132
    "if has('win32') || has('win64')
    "    " Maximize window with the worst hack possible (English Windows)
    "    if has("autocmd")
    "        au GUIEnter * simalt ~x
    "    endif
    "endif
endif

" }}}
" Mappings {{{

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U (delete entered text on current line) in insert mode deletes a lot.
" Use CTRL-G u to first break undo, so that you can undo CTRL-U after
" inserting a line break.  Do the same for CTRL-W (delete word)
inoremap <C-U> <C-G>u<C-U>
inoremap <c-w> <c-g>u<c-w>

" sudo write with W!
cmap W! w !sudo tee >/dev/null %

" remove middle mouse button paste mapping
map <MiddleMouse> <Nop>
imap <MiddleMouse> <Nop>
map <2-MiddleMouse> <Nop>
imap <2-MiddleMouse> <Nop>
map <3-MiddleMouse> <Nop>
imap <3-MiddleMouse> <Nop>
map <4-MiddleMouse> <Nop>
imap <4-MiddleMouse> <Nop>

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

" Open folds with spacebar
nnoremap <Space> zA
nnoremap <S-Space> za

" Exit insert mode with jj or jk
inoremap jj <Esc>
inoremap jk <Esc>

" Always move by screen lines instead of file lines
nnoremap j gj
nnoremap k gk

" Navigate windows with Alt-movement keys
set winaltkeys=no
nnoremap <silent> <A-h> :<C-U>wincmd h<CR>
nmap <Esc>h <A-h>
nnoremap <silent> <A-j> :<C-U>wincmd j<CR>
nmap <Esc>j <A-j>
nnoremap <silent> <A-k> :<C-U>wincmd k<CR>
nmap <Esc>k <A-k>
nnoremap <silent> <A-l> :<C-U>wincmd l<CR>
nmap <Esc>l <A-l>

" Step through quickfix with F7 F8

nnoremap <silent> <F7> :cp<CR>
nnoremap <silent> <F8> :cn<CR>

" Make with F5
nnoremap <F5> :w<CR>:make<CR>
inoremap <F5> <Esc>:w<CR>:make<CR>
vnoremap <F5> <C-U>:w<CR>:make<CR>

" Compile plantUML with F11
nnoremap <F11> :w<CR>:silent !plantuml %<CR>
inoremap <F11> <Esc>:w<CR>:silent !plantuml %<CR>
vnoremap <F11> <C-U>:w<CR>:silent !plantuml %<CR>

" Open Tagbar with F10
nnoremap <silent> <F10> :TagbarToggle<CR>

" }}}
" Commands {{{

" CDC = Change to Directory of Current file
command CDC cd %:p:h

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

" }}}
" Syntax Options {{{
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
call camelcasemotion#CreateMotionMappings('<Leader>')

" Easytags Options
set tags=./tags;,~/.vimtags " add upward search for local tags files
let g:easytags_dynamic_files = 1 " write to first available tags file from above list
let g:easytags_async = 1
if has('win32') || has('win64')
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

" Syntastic Options
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}
" Neovim Options {{{
if has('nvim')
    set termguicolors
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1
endif
" }}}
