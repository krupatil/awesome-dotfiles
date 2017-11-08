autocmd StdinReadPre * let s:std_in=1
" autocmd FileType nerdtree setlocal nolist

" Remove extra ~ from NARDTree icon
augroup devicons_nerdtree
    autocmd FileType nerdtree setlocal list
    autocmd FileType nerdtree setlocal nolist
augroup END

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
