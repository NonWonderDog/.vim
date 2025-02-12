# Read the MATLAB path definition file, and add lines immediately before the
# default MATLAB paths.

## Helper Functions
function pauseQuit
{
    # If running in the console, wait for input before closing.
    if ($Host.Name -eq "ConsoleHost") {
        write-host ""
        write-host "Press any key to continue..."
        $Host.UI.RawUI.FlushInputBuffer()
        $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
    }
    exit
}

## Main Program
$dir = get-item -Force (split-path -parent $MyInvocation.MyCommand.Path)
$files = @("vimrc")
$olddir = join-path $HOME .dotfiles_old

# create dotfiles_old in home dir
mkdir $olddir -Force > $null

# move any existing dotfiles in homedir to dotfiles_old directory, then create 
# symlinks from the homedir to any files in the ~/.dotfiles directory specified 
# in $files
write-host "Moving any existing dotfiles from $HOME to $olddir"
foreach ($file in $files) {
    if (test-path $HOME\.$file) {
        move-item $HOME\.$file $olddir
    }
}

foreach ($file in $files) {
    New-Item -Path "$HOME\.$file" -ItemType SymbolicLink -Value "$dir\$file"
}

write-host "Done."
pauseQuit
