" Automatically turn off expandtab and text autoformatting for *.tsv files, or 
" any file with a tab character on the first line.
" Do the same for fstab because I like it that way.

autocmd BufRead,BufNewFile *.tsv set noexpandtab nosmarttab softtabstop=0 fo-=t
autocmd BufRead,BufNewFile fstab set noexpandtab nosmarttab softtabstop=0 fo-=t
autocmd BufRead * if getline(1) =~ '\t' | set noexpandtab nosmarttab softtabstop=0 fo-=t | endif
