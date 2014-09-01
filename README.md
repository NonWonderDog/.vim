Vim Configuration Files
=======================
My Vim dotfiles.

Includes:
- Windows and Linux compatibility
- UTF-8 and CJK input support
- Custom color scheme based on "Wombat"
- Custom syntax files for VHDL 2008 and IEC Structured Text

For ease of compatibility between Windows and Linux, this was designed to live 
in `~/.vim` on both platforms.  It will not function correctly if installed to 
any other directory.  Note that this is not the default location on Windows, 
which uses `~/vimfiles` and `~/_vimrc` by default.

Linux Install
-------------
This requires an install of Vim with python support. On Ubuntu Linux, this can 
be found in the `vim-gnome` or `vim-gtk` package.

The `exuberant-ctags` package integrates with Vim and is very useful for 
navigating around code.  It is required for the Easytags and Tagbar plugins.  

Vim 7.3 and above will prioritize the `~/.vim/vimrc` included in this 
repository over `~/.vimrc` in the home folder, so no symbolic links are 
necessary. Make sure to delete any existing `~/.vimrc` file, or these settings 
will not be used.

For an install from scratch:

	sudo apt-get install vim-gtk exuberant-ctags
	git clone git@github.com:NonWonderDog/.vim.git ~/.vim
	rm ~/.vimrc
	vim +Helptags +qall

Windows Install
---------------
The contents of this repository must be installed to a `%USERPROFILE%/.vim` 
directory.  This distribution will not function correctly if installed to the 
default `%USERPROFILE%/vimfiles` directory.

When renaming files or folders in Windows Explorer, everything after the final 
dot is interpreted as an extension, and Explorer does not allow one to create 
files with an extension but no name.  To create a file or directory beginning 
in a dot in Explorer, the simplest workaround is to add a dot to the end of the 
name.  The name `.vim.` will create the `.vim` directory.  No workarounds are 
needed if creating the directory from a command prompt.

After a `git clone` or `svn checkout`, the win\_install.bat script will create 
a stub `~/.vimrc` file pointing to the real `~/.vim/vimrc` file.  This step is 
necessary because we are not using the default `~/vimfiles` path.

After installing Vim and this repository, start Vim and execute `:Helptags` to 
update the documentation.

### Prerequisites
- Vim 7.4 or above: <http://www.vim.org/download.php>
- Exuberant Ctags: <http://ctags.sourceforge.net/>
	- `ctags.exe` from the download must be on your Windows `%PATH%`.
- 32-bit Python 2.7: <https://www.python.org/download>
	- Required for the Ultisnip plugin.
	- The official Vim 7.4 release for Windows also supports Python 3.2, but
	  not Python 3.3 or above

If you're using a different Vim build 
([Haroogan's](https://bitbucket.org/Haroogan/vim-for-windows/src) is quite good 
for 64-bit), make sure to install an appropriate version of Python.  To install 
the 64-bit build of Vim 7.4, extract it to C:/Program Files/Vim/vim74 and run 
install.exe with administrator priviledges.

Todo
----
It should be possible to free this from the `~/.vim` path dependency on 
Windows.
