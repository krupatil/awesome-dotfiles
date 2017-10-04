runtime coding-common.vim

nnoremap <f5> :!dot -Tpng -O "%"<cr>:silent !""\%ProgramFiles(x86)\%\IrfanView\i_view32.exe" "%.png"<cr><cr>

" Disable 80 column highlighting
match none
