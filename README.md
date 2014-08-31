Vim Configuration Files
=======================

For ease of compatibility between Windows and Linux, this was designed to live 
in `~/.vim` on both platforms.  It will not function correctly if installed to 
another directory.  Note that this is not the default location on Windows, 
which uses `~/vimfiles` and `~/_vimrc` by default.

In Vim 7.3 and above, vim will look for `~/.vim/vimrc` in preference to 
`~/.vimrc`, so a symlink from `~/.vimrc` is unecessary.

An install script `win_install.bat` is included for Windows, which creates 
a stub file at `~/.vimrc` to redirect to the `~/.vim` directory.

On Windows, Explorer interprets a file or folder name starting with a dot as 
a file with an extension but no name, and gives an error. To work around this, 
add a trailing dot to the file name. Typing `.vim.` to rename the folder will 
create the correctly named directory.

