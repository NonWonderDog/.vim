Vim Configuration Files
=======================
My Vim dotfiles.

Includes:
- Windows and Linux compatibility
- UTF-8 and CJK input support
- Custom color scheme based on "Wombat"
- 256 color terminal support on Linux xterm and gnome-terminal
- 256 color terminal support on Windows using 
  [ConEmu](https://code.google.com/p/conemu-maximus5/)
- Nearly identical colors in both 24-bit and 256 color
- Support for bash shell (Git Bash, win-bash, etc) on Windows
- Custom syntax files for VHDL 2008 and IEC Structured Text

For ease of compatibility between Windows and Linux, this was designed to live 
in `~/.vim` on both platforms.  It will not function correctly if installed to 
any other directory.  Note that this is not the default location on Windows, 
which uses `~/vimfiles` and `~/_vimrc` by default (where `~` is equal to 
`%USERPROFILE%`).

Linux Install
-------------
The Ultisnip plugin requires an install of Vim with python support. On Ubuntu 
Linux, a version of gvim with python can be found in the `vim-gnome` or 
`vim-gtk` package.  `vim-gtk` seems to be more complete, but has extra 
dependencies on Ubuntu.

The `exuberant-ctags` package integrates with Vim and is very useful for 
navigating around code.  It is required for the Easytags and Tagbar plugins.  

Vim 7.3 and above will use the `~/.vim/vimrc` included in this repository if no 
`~/.vimrc` is found, so no installation script is necessary. If you prefer to 
have your settings in `~/.vimrc` anyway, the `install` script will create the 
link for you and move any old `~/.vimrc` file to `.dotfiles_old/vimrc`.

For an install from scratch:

	sudo apt-get install vim-gtk exuberant-ctags
	git clone git@github.com:NonWonderDog/.vim.git ~/.vim
        ~/.vim/install
        vim +PlugInstall +qall

Windows Install
---------------
The contents of this repository must be installed to a `%USERPROFILE%/.vim` 
directory.  This distribution will not function correctly if installed to the 
default `%USERPROFILE%/vimfiles` directory.

Windows explorer makes it difficult to create files that start with a period 
and have no extension, as it interprets them as files with an extension but no 
name.  To work around this, append a final dot -- it and the "empty extension" 
will be removed. Type `.vim.` as the directory name in Explorer to create the 
`.vim` directory.  This isn't necessary if creating the directory from 
a command prompt.

After a `git clone` or `svn checkout`, run the `install.bat` script to create 
a symbolic link from `%USERPROFILE%/.vimrc` to `%USERPROFILE%/.vim/vimrc`.  
This step is necessary because we are not using the default 
`%USERPROFILE%/vimfiles` path.  `install.bat` runs the included `install.ps1` 
PowerShell script as administrator.

After installing Vim and this repository, start Vim and execute `:PlugInstall` 
to install plugins with vim-plug.

It's highly recommended that a version of `tee` be on your Windows path, as it 
smoothes out a few annoyances with Vim on Windows.  Most notably, Vim will not 
have to open a separate command window for commands such as `make`, `grep`, or 
`!ctags`.  The simplest way to get this utility is to install msysgit and let 
it add the GNU utilities to your path.

### Prerequisites
- Vim 7.4 or above: <http://www.vim.org/download.php>
- Exuberant Ctags: <http://ctags.sourceforge.net/>
	- `ctags.exe` from the download must be on your Windows `%PATH%`.

