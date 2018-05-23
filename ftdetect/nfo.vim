au BufReadPre *.nfo setlocal fileencodings=utf-8,cp437
au BufNewFile,BufRead *.nfo   set filetype=nfo
au GUIEnter *.nfo set lines=70 columns=81
