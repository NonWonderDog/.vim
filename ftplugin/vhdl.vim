" some VHDL tools

"setlocal makeprg=vmap\ proasic3e\ \"C:/Microsemi/Libero_v11.3/Designer/lib/modelsim/precompiled/vhdl/proasic3e\"\ \&\ vlib\ %:h/../simulation/presynth\ \&\ set\ MODELSIM=%:h/../simulation/modelsim.ini\ \&\ vcom\ -2008\ -work\ %:h/../simulation/presynth\ %
set errorformat=**\ %trror:\ %f(%l):\ %m 
set errorformat+=**\ %tarning:\ [%n]\ %f(%l):\ %m 
set errorformat+=**\ %tarning:\ %f(%l):\ %m 
" makefile directory change
set errorformat+=%Dmake[%*\\d]:\ Entering\ directory\ `%f',%Xmake[%*\\d]:\ Leaving\ directory\ `%f'

" auto comment stuff
set comments=:--!,:-- "normal and doxygen comments
set fo-=t fo+=croqlj

