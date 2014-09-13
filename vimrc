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
	" enable autorecognize for SJIS-encoded files
	setglobal fileencodings=ucs-bom,utf-8,sjis,default,latin1
	" default to IME off
	set iminsert=0
	set imsearch=-1
endif

if has('win32') || has('win64')
	" use '.vim' instead of 'vimfiles', and use .viminfo
	set runtimepath=~/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,~/.vim/after
	set viminfo+=n~/.viminfo
	" redirect $MYVIMRC to this file, rather than the stub
	let $MYVIMRC='~/.vim/vimrc'
	if executable("bash")
		" Use bash if available
		set shell=bash
		set shellslash
	else
		set shell=cmd
	endif
	if executable("tee")
		" Make build output show up on the screen, just like in *nix
		" noshelltemp and nomore ideally would be set only during make
		set shellpipe=2>&1\|\ tee
		set noshelltemp
		set nomore
	endif
endif

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()

" Use ag or ack instead of grep
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
elseif executable('ack')
	set grepprg=ack\ --nogroup\ --nocolor
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

" set spellcheck dictionary to US English
set spelllang=en_us

" }}}
" Editor {{{

" Use all filetype-dependent settings
filetype plugin indent on

" essentials
set hidden				" keep hidden buffers on window close
set history=100			" keep 100 lines of command line history
set switchbuf=usetab	" when executing quickfix or buffer split command, look for existing window before opening a new one
set linebreak			" break at word boundaries when 'wrap' is set
set display+=lastline	" show partial lines when wrapping
set noequalalways		" don't resize windows on close or split

" set session saving options
set sessionoptions=help,sesdir,tabpages,winsize

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" set virtual editing mode for visual block selection
set virtualedit=block

" use popup right-click menu on all platforms
set mousemodel=popup

" better search settings
set incsearch			" do incremental searching
set ignorecase			" use case-insensitive searches
set smartcase			" make only lower-case patterns case-insensitive

" Use syntax and search highlighting, when the terminal has colors
if &t_Co > 2 || has("gui_running")
	syntax on
	set hlsearch
endif

" start with folding on
set foldmethod=syntax
set foldlevelstart=0

" don't autoformat text by default
set formatoptions-=t
" use auto-format for comments, using trailing space
set formatoptions+=cwa
" Don't break after single letter words
set formatoptions+=1
" Support Japanese line break rules more properly
set formatoptions+=mM

" limit syntax highlighting on long lines for speed
set synmaxcol=400

" use wildcard completion menu
set wildmenu
set wildmode=full

" use the only acceptable c indent style
set autoindent		" use automatic indenting if no file type indent exists
"set smarttab		" tab/backspace at beginning of line moves by shiftwidth instead of (soft)tabstop
set shiftwidth=4	" indent by 4 spaces
set tabstop=4		" tabs are 4 spaces wide
set softtabstop=4	" indents made of spaces are 4 spaces wide
set cinoptions=:0g0N-s " don't indent case labels or scope declarations
set nowrap			" turn off text wrap

" in case I add expandtab, I can still edit makefiles
autocmd FileType make setlocal noexpandtab

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

set guioptions=m		" hide all gui stuff except menu bar
set laststatus=2		" always show status line
set visualbell			" get rid of the stupid noise
set ruler				" show the cursor position all the time
set showcmd				" display incomplete commands

" Change shown characters for list mode
set listchars=tab:→·,eol:¬,trail:·,nbsp:█,precedes:«,extends:»

" Set windows font and color scheme
colorscheme numbat256
if has('win32') || has('win64')
	set guifont=Consolas:h8
	set guifontwide=MS_Gothic:h8:cSHIFTJIS
endif

if $TERM =~ "^xterm"
	" set xterm escape sequences
	let &t_ZH="\e[3m"		" start italics
	let &t_ZR="\e[23m"		" end italics
	let &t_us="\e[4m"		" start underline
	let &t_ue="\e[24m"		" end underline
	let &t_SI="\e[5 q"		" start insert (blinking bar)
	let &t_EI="\e[1 q"		" end insert (blinking block)
endif

if $COLORTERM == "gnome-terminal"
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
	set termencoding=default	" not an 8-bit terminal
	set t_Co=256
	let &t_AB="\e[48;5;%dm"	" set ANSI background color
	let &t_AF="\e[38;5;%dm"	" set ANSI foreground color
	let &t_ZH="\e[3m"		" start italics
	let &t_ZR="\e[23m"		" end italics
	let &t_us="\e[4m"		" start underline
	let &t_ue="\e[24m"		" end underline
	" ConEmu really doesn't handle unicode well
	set listchars=tab:>\ ,eol:<,trail:-,nbsp:%,precedes:<,extends:>
endif

" Set window size
if has("gui_running")
	" GUI is running or is about to start.
	set lines=48 columns=120
	if has('win32') || has('win64')
		" Maximize window with the worst hack possible (English Windows)
		if has("autocmd")
			au GUIEnter * simalt ~x
		endif
	endif
else
	" This is console Vim.
	if exists("+lines")
		set lines=48
	endif
	if exists("+columns")
		set columns=120
	endif
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

" sudo write with w!!
cmap w!! w !sudo tee >/dev/null %

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

" Exit insert mode with jj or jk
inoremap jj <Esc>
inoremap jk <Esc>

" Use K for grep instead of man
"nnoremap K :!ack "\b<C-R><C-W>\b"<CR>:cw<CR>

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

" Output,WinOutput,TabOutput simplify grabbing output from ex commands
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
"   :WinOutput ls
"   :TabOutput echo "Key mappings for Control+A:" | map <C-A>
"
command! -nargs=+ -complete=command Output call RedirMessages(<q-args>, ''       )
command! -nargs=+ -complete=command WinOutput call RedirMessages(<q-args>, 'new'    )
command! -nargs=+ -complete=command TabOutput call RedirMessages(<q-args>, 'tabnew' )

" }}}
" Easytags Options {{{
set tags=./tags;,~/.vimtags " add upward search for local tags files
let g:easytags_dynamic_files = 1 " write to first available tags file from above list
if has('win32') || has('win64')
	let g:easytags_file = '~/.vimtags'
else
	let g:easytags_file = '~/.vimtags-$USER'
endif
let g:easytags_async = 1
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
" }}}
" TagBar Options {{{
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

" }}}

