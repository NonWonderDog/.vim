" Remove annoying mapping from Terminus that adds delay to exiting insert mode
if has('unix')
    iunmap <expr> <Esc>[200~
endif
