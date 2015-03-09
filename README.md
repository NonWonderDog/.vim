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
        vim +Helptags +qall

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

After installing Vim and this repository, start Vim and execute `:Helptags` to 
update the documentation.

Bash will be used for the Vim `shell` setting if it exists.  It's highly 
recommended that `bash`, `tee`, and `grep` be on your Windows path, as they 
smooth out a few annoyances with Vim on Windows.  Most notably, Vim will not 
have to open a separate command window for commands such as `make`, `grep`, or 
`!ctags`.  If you're using msysgit, you more than likely already have these 
utilities.

The one downside of using bash as the Windows Vim shell is the output filename 
format.  Vim doesn't understand `/c/Program\ Files/` style paths, so full paths 
will not be hyperlinked in the quickfix list.  I've added a quick hack to make 
the Vim `grep` command automatically convert filenames starting with `/` to 
windows format, but this isn't very well tested and doesn't help with `make` 
output.  The older [win-bash](http://win-bash.sourceforge.net/) project returns 
Windows-style filepaths, but is too limited to be of much use (it doesn't 
support subshells, for one thing).

### Prerequisites
- Vim 7.4 or above: <http://www.vim.org/download.php>
- Exuberant Ctags: <http://ctags.sourceforge.net/>
	- `ctags.exe` from the download must be on your Windows `%PATH%`.
- 32-bit Python 2.7: <https://www.python.org/download>
	- Required for the Ultisnip plugin.
	- The official Vim 7.4 release for Windows also supports Python 3.2, but
	  not Python 3.3 or above

If you're using a different Vim build 
([Haroogan](https://bitbucket.org/Haroogan/vim-for-windows/src) provides a good 
64-bit build), make sure to install an appropriate version of Python.  To 
install the 64-bit build of Vim 7.4, extract it to C:/Program Files/Vim/vim74 
and run install.exe with administrator priviledges.

Todo
----
* Remove the `~/.vim` path dependency on Windows.
* Get Linux IME support (IBus-Anthy, etc) to work more like the Windows IME 
  integration
* Change cursor to underline in REPLACE mode in terminal Vim (check 
  v:insertmode on InsertChange and InsertEnter)

