augroup LinuxSourceException
    autocmd!
    autocmd BufEnter  *linux*/*.[ch]  let b:TabsOkay=1
    autocmd BufEnter  *linux*/*.[ch]  let b:Tabs8=1
    autocmd BufEnter  *linux*/*.[ch]  runtime coding-common.vim
    autocmd BufEnter  *u*boot*/*.[ch]  let b:TabsOkay=1
    autocmd BufEnter  *u*boot*/*.[ch]  let b:Tabs8=1
    autocmd BufEnter  *u*boot*/*.[ch]  runtime coding-common.vim
augroup END

function! GlennSource()
    if exists('b:GlennSourceToggle')
        unlet b:GlennSourceToggle
        unlet b:TabsOkay
        unlet b:OverLength
        unlet! b:Tabs8
    else
        let b:GlennSourceToggle=1
        let b:TabsOkay=1
        let b:OverLength=120
        unlet! b:Tabs8
    endif
    runtime coding-common.vim
endfunction

function! LinuxSource()
    if exists('b:LinuxSourceToggle')
        unlet! b:LinuxSourceToggle
        unlet! b:TabsOkay
        unlet! b:OverLength
        unlet! b:Tabs8
    else
        let b:LinuxSourceToggle=1
        let b:TabsOkay=1
        let b:OverLength=80
        let b:Tabs8=1
    endif
    runtime coding-common.vim
endfunction

if exists('b:GlennSourceToggle')
    call GlennSource()
endif

if exists('b:LinuxSourceToggle')
    call LinuxSource()
endif

nnoremap <buffer> <LocalLeader>gs :call GlennSource()<CR>
nnoremap <buffer> <LocalLeader>ls :call LinuxSource()<CR>

command! -nargs=1 Silent
\ | execute ':silent !'.<q-args>
\ | execute ':redraw!'

nnoremap <buffer> K :Silent man -s 2,3,4,5,6,7,8,9,1 <C-R>=expand("<cword>")<CR><CR>

" =====[CScope Bindings]=====
setlocal cscopetag
setlocal cscopetagorder=1
if filereadable("cscope.out")
  cscope add cscope.out
elseif $CSCOPE_DB != ""
  cscope add $CSCOPE_DB
endif
nmap <buffer> <C-@>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <buffer> <C-@>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <buffer> <C-@>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <buffer> <C-@>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <buffer> <C-@>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <buffer> <C-@>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <buffer> <C-@>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <buffer> <C-@>d :cs find d <C-R>=expand("<cword>")<CR><CR>

runtime coding-common.vim
