" Automatically turn off expandtab and text autoformatting for *.tsv files, or 
" any file with a tab character on the first line.
" Do the same for fstab because I like it that way.

autocmd BufRead,BufNewFile *.tsv setlocal noexpandtab nosmarttab softtabstop=0 fo-=t
autocmd BufRead,BufNewFile fstab setlocal noexpandtab nosmarttab softtabstop=0 fo-=t
autocmd BufRead * if getline(1) =~ '\t' | setlocal noexpandtab nosmarttab softtabstop=0 fo-=t | endif
